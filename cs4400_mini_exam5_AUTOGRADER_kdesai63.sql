-- CS4400: Introduction to Database Systems: Tuesday, November 16, 2021
-- Mini-Exam #5: Automated Testing Environment for the Groceries Database 
-- This version of the database is intended to work with legacy versions of MySQL
-- [AUTOGRADER] for Mini-Exam #5

-- -------------------------------------------------
-- ENTER YOUR QUERY SOLUTIONS STARTING AT LINE 116
-- -------------------------------------------------

drop database if exists delivery_scenario;
create database if not exists delivery_scenario;
use delivery_scenario;

-- -----------------------------------------------
-- table structures
-- -----------------------------------------------

create table users (
uname varchar(40) not null,
first_name varchar(100) not null,
last_name varchar(100) not null,
address varchar(500) not null,
birthdate date default null,
primary key (uname)
) engine = innodb;

create table customers (
uname varchar(40) not null,
rating integer not null,
credit integer not null,
primary key (uname)
) engine = innodb;

create table employees (
uname varchar(40) not null,
taxID varchar(40) not null,
hired date not null,
service integer not null,
salary integer not null,
primary key (uname),
unique key (taxID)
) engine = innodb;

create table drone_pilots (
uname varchar(40) not null,
licenseID varchar(40) not null,
experience integer not null,
primary key (uname),
unique key (licenseID)
) engine = innodb;

create table floor_workers (
uname varchar(40) not null,
primary key (uname)
) engine = innodb;

create table items (
barcode varchar(40) not null,
iname varchar(100) not null,
weight integer not null,
primary key (barcode)
) engine = innodb;

create table orders (
orderID varchar(40) not null,
sold_on date not null,
purchased_by varchar(40) not null,
carrier_store varchar(40) not null,
carrier_tag integer not null,
primary key (orderID)
) engine = innodb;

create table stores (
storeID varchar(40) not null,
sname varchar(100) not null,
revenue integer not null,
manager varchar(40) not null,
primary key (storeID)
) engine = innodb;

create table drones (
storeID varchar(40) not null,
droneTag integer not null,
capacity integer not null,
remaining_trips integer not null,
pilot varchar(40) not null,
primary key (storeID, droneTag)
) engine = innodb;

create table order_lines (
orderID varchar(40) not null,
barcode varchar(40) not null,
price integer not null,
quantity integer not null,
primary key (orderID, barcode)
) engine = innodb;

create table employed_workers (
storeID varchar(40) not null,
uname varchar(40) not null,
primary key (storeID, uname)
) engine = innodb;

-- Enter your queries in the area below using this format:
-- create or replace view practiceQuery<#> as
-- <your proposed query solution>;

-- Be sure to end all queries with a semi-colon (';') and make sure that
-- the <#> value matches the query value from the practice sheet

-- -------------------------------------------------
-- view structures (student created)
-- PUT ALL PROPOSED QUERY SOLUTIONS BELOW THIS LINE
-- -------------------------------------------------
create or replace view practiceQuery51 as
select taxID, licenseID, hired from drone_pilots, employees where drone_pilots.uname = employees.uname and experience > 38;

create or replace view practiceQuery38 as
select last_name,first_name,address,birthdate from  users, employees,customers where users.uname = employees.uname and employees.uname = customers.uname and service>10 and credit <150;

create or replace view practiceQuery58 as
select storeID, droneTag, remaining_trips,capacity from drones,employees,customers where drones.pilot = employees.uname and employees.uname = customers.uname and year(hired)<2021;

create or replace view practiceQuery44 as
select first_name, licenseID,birthdate from users,drone_pilots where drone_pilots.uname = users.uname and experience >= 35;

create or replace view practiceQuery46 as
select drones.storeID,droneTag,capacity,remaining_trips from drone_pilots,drones,stores where  drones.pilot = drone_pilots.uname and stores.storeID = drones.storeID and experience<41 and revenue<=300;

create or replace view practiceQuery35 as
select taxID,hired,salary, stores.storeID, stores.revenue from employees,floor_workers,users,employed_workers,stores where users.uname = employees.uname and employees.uname = floor_workers.uname and floor_workers.uname = employed_workers.uname and employed_workers.storeID = stores.storeID and year(users.birthdate) < 1973;


-- -------------------------------------------------
-- PUT ALL PROPOSED QUERY SOLUTIONS ABOVE THIS LINE
-- -------------------------------------------------
set @thisDatabase = 'delivery_scenario';

-- -----------------------------------------------
-- referential structures
-- -----------------------------------------------

-- -----------------------------------------------
-- table data
-- -----------------------------------------------

insert into users values
('jstone5', 'Jared', 'Stone', '101 Five Finger Way', '1961-01-06'),
('sprince6', 'Sarah', 'Prince', '22 Peachtree Street', '1968-06-15'),
('awilson5', 'Aaron', 'Wilson', '220 Peachtree Street', '1963-11-11'),
('lrodriguez5', 'Lina', 'Rodriguez', '360 Corkscrew Circle', '1975-04-02'),
('tmccall5', 'Trey', 'McCall', '360 Corkscrew Circle', '1973-03-19'),
('eross10', 'Erica', 'Ross', '22 Peachtree Street', '1975-04-02'),
('hstark16', 'Harmon', 'Stark', '53 Tanker Top Lane', '1971-10-27'),
('echarles19', 'Ella', 'Charles', '22 Peachtree Street', '1974-05-06'),
('csoares8', 'Claire', 'Soares', '706 Living Stone Way', '1965-09-03'),
('agarcia7', 'Alejandro', 'Garcia', '710 Living Water Drive', '1966-10-29'),
('bsummers4', 'Brie', 'Summers', '5105 Dragon Star Circle', '1976-02-09'),
('cjordan5', 'Clark', 'Jordan', '77 Infinite Stars Road', '1966-06-05'),
('fprefontaine6', 'Ford', 'Prefontaine', '10 Hitch Hikers Lane', '1961-01-28'),
('ghopper5', 'Gracie', 'Hopper', '117 Compiler Circle', '1970-06-18'),
('klandis8', 'Kevin', 'Landis', '22 Bonsai Tree Lane', '1966-08-19'),
('sturing13', 'Sally', 'Turing', '2 Automata Avenue', '1968-07-08');

insert into customers values
('jstone5', 4, 40),
('sprince6', 5, 30),
('awilson5', 2, 100),
('lrodriguez5', 4, 60),
('bsummers4', 3, 110),
('cjordan5', 3, 50),
('sturing13', 5, 90);

insert into employees values
('awilson5', '111-11-1111', '2020-03-15', 9, 46000),
('lrodriguez5', '222-22-2222', '2019-04-15', 20, 58000),
('tmccall5', '333-33-3333', '2018-10-17', 29, 33000),
('eross10', '444-44-4444', '2020-04-17', 10, 61000),
('hstark16', '555-55-5555', '2018-07-23', 20, 59000),
('echarles19', '777-77-7777', '2021-01-02', 3, 27000),
('csoares8', '888-88-8888', '2019-02-25', 26, 57000),
('agarcia7', '999-99-9999', '2019-03-17', 24, 41000),
('bsummers4', '000-00-0000', '2018-12-06', 17, 35000),
('fprefontaine6', '121-21-2121', '2020-04-19', 5, 20000),
('ghopper5', '232-32-3232', '2020-04-19', 27, 33000),
('klandis8', '454-54-5454', '2020-04-19', 2, 27000);

insert into floor_workers values
('eross10'),
('hstark16'),
('echarles19'),
('ghopper5'),
('klandis8');

insert into stores values
('pub', 'Publix', 200, 'hstark16'),
('krg', 'Kroger', 300, 'echarles19'),
('whf', 'Whole_Foods', 600, 'ghopper5');

insert into employed_workers values
('pub', 'eross10'),
('pub', 'hstark16'),
('krg', 'eross10'),
('krg', 'echarles19'),
('krg', 'klandis8'),
('whf', 'ghopper5'),
('whf', 'klandis8');

insert into drone_pilots values
('awilson5', '314159', 41),
('lrodriguez5', '287182', 67),
('tmccall5', '181633', 10),
('agarcia7', '610623', 38),
('bsummers4', '411911', 35),
('fprefontaine6', '657483', 2);

insert into drones values
('pub', 1, 10, 3, 'awilson5'),
('pub', 2, 20, 2, 'lrodriguez5'),
('krg', 1, 15, 4, 'tmccall5'),
('pub', 9, 45, 1, 'fprefontaine6');

insert into items values
('pr_3C6A9R', 'pot roast', 6),
('ss_2D4E6L', 'shrimp salad', 3),
('hs_5E7L23M', 'hoagie sandwich', 3),
('clc_4T9U25X', 'chocolate lava cake', 5),
('ap_9T25E36L', 'antipasto platter', 4);

insert into orders values
('pub_303', '2021-05-23', 'sprince6', 'pub', 1),
('pub_305', '2021-05-22', 'sprince6', 'pub', 2),
('krg_217', '2021-05-23', 'jstone5', 'krg', 1),
('pub_306', '2021-05-22', 'awilson5', 'pub', 2);

insert into order_lines values
('pub_303', 'pr_3C6A9R', 20, 1),
('pub_303', 'ap_9T25E36L', 4, 1),
('pub_305', 'clc_4T9U25X', 10, 2),
('pub_306', 'hs_5E7L23M', 3, 2),
('pub_306', 'ap_9T25E36L', 10, 1),
('krg_217', 'pr_3C6A9R', 15, 2);

-- -------------------------------------------------
-- autograding system
-- -------------------------------------------------
set @thisDatabase = 'delivery_scenario';

-- This is required to support some of the arbitrary SQL commands that might be used in the testing process.
set SQL_SAFE_UPDATES = 0;

-- This SQL MODE is used to deliberately allow for queries that do not follow the "ONLY_FULL_GROUP_BY" protocol.
-- Though it does permit queries that are arguably poorly-structured, this is permitted by the most recent SQL standards.
set session SQL_MODE = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- The magic44_data_capture table is used to store the data created by the student's queries
-- The table is populated by the magic44_evaluate_queries stored procedure
-- The data in the table is used to populate the magic44_test_results table for analysis

drop table if exists magic44_data_capture;
create table magic44_data_capture (
	stepID integer, queryID integer,
    columnDump0 varchar(1000), columnDump1 varchar(1000), columnDump2 varchar(1000), columnDump3 varchar(1000), columnDump4 varchar(1000),
    columnDump5 varchar(1000), columnDump6 varchar(1000), columnDump7 varchar(1000), columnDump8 varchar(1000), columnDump9 varchar(1000),
	columnDump10 varchar(1000), columnDump11 varchar(1000), columnDump12 varchar(1000), columnDump13 varchar(1000), columnDump14 varchar(1000)
);

-- The magic44_column_listing table is used to help prepare the insert statements for the magic44_data_capture
-- table for the student's queries which may have variable numbers of columns (the table is prepopulated)

drop table if exists magic44_column_listing;
create table magic44_column_listing (
	columnPosition integer,
    simpleColumnName varchar(50),
    nullColumnName varchar(50)
);

insert into magic44_column_listing (columnPosition, simpleColumnName) values
(0, 'columnDump0'), (1, 'columnDump1'), (2, 'columnDump2'), (3, 'columnDump3'), (4, 'columnDump4'),
(5, 'columnDump5'), (6, 'columnDump6'), (7, 'columnDump7'), (8, 'columnDump8'), (9, 'columnDump9'),
(10, 'columnDump10'), (11, 'columnDump11'), (12, 'columnDump12'), (13, 'columnDump13'), (14, 'columnDump14');

drop function if exists magic44_gen_simple_template;
delimiter //
create function magic44_gen_simple_template(numberOfColumns integer)
	returns varchar(1000) deterministic
begin
return (select group_concat(simpleColumnName separator ", ") from magic44_column_listing
	where columnPosition < numberOfColumns);
end //
delimiter ;

-- Create a variable to effectively act as a program counter for the testing process/steps
set @stepCounter = 0;

-- The magic44_magic44_query_capture function is used to construct the instruction
-- that can be used to execute and store the results of a query
drop function if exists magic44_query_capture;
delimiter //
create function magic44_query_capture(thisQuery integer)
	returns varchar(1000) deterministic
begin
	set @numberOfColumns = (select count(*) from information_schema.columns
		where table_schema = @thisDatabase
        and table_name = concat('practiceQuery', thisQuery));

	set @buildQuery = "insert into magic44_data_capture (stepID, queryID, ";
    set @buildQuery = concat(@buildQuery, magic44_gen_simple_template(@numberOfColumns));
    set @buildQuery = concat(@buildQuery, ") select ");
    set @buildQuery = concat(@buildQuery, @stepCounter, ", ");
    set @buildQuery = concat(@buildQuery, thisQuery, ", practiceQuery");
    set @buildQuery = concat(@buildQuery, thisQuery, ".* from practiceQuery");
    set @buildQuery = concat(@buildQuery, thisQuery, ";");
    
return @buildQuery;
end //
delimiter ;

-- The magic44_testing_steps table is used to change the state of the database to test the queries more fully
-- This table is used by the magic44_evaluate_queries stored procedure
-- The table is prepopulated and contains both SQL commands and non-SQL special commands that drive the testing process
-- The SQL commands are used to change the state of the database to facilitate more thorough testing
-- The non-SQL special commands are used to support execution of otherwise complex commands (e.g., stored procedures)

drop table if exists magic44_testing_steps;
create table magic44_testing_steps (
	stepID integer,
    changeInstruction varchar(2000),
    primary key (stepID)
);

-- In many cases, we will use a "compensating transaction" policy to change a table, and then change it's contents
-- back to the original state to minimize any effects from propagting errors
-- For more advanced testing, however, multiple sequential changes to the tables will be executed

insert into magic44_testing_steps values
(0, '&non_sql&evaluate_all_queries'),
(1, 'insert into users values
("new_user2", "Some", "User", "An Address", "1962-01-01"),
("new_user3", "Some", "User", "A TreeLane", "1963-02-01"),
("new_user4", "Some", "User", "An Addtrees Circle", "1964-06-01"),
("new_user5", "Some", "User", "An Address Tree in my Street", "1965-05-01"),
("new_user6", "Some", "User", "A Tree", "1966-07-01"),
("new_user7", "Some", "User", "An Address", "1967-06-01"),
("new_user8", "Some", "User", "Tree Address", "1968-10-01");'),
(2, 'insert into employees values
("new_user2", "taxID_10", "2020-03-15", 10, 50000),
("new_user3", "taxID_25", "2020-03-15", 25, 20000),
("new_user4", "taxID_100", "2020-03-15", 10, 10000),
("new_user5", "taxID_250", "2020-03-15", 25, 60000);'),
(3, 'insert into order_lines values
("pub_303", "clc_4T9U25X", 4, 2),
("pub_303", "hs_5E7L23M", 20, 1),
("pub_306", "clc_4T9U25X", 3, 1),
("pub_305", "pr_3C6A9R", 35, 1),
("pub_305", "ap_9T25E36L", 10, 2);'),
(4, 'insert into customers values
("new_user4", 1, 20),
("new_user5", 2, 30),
("new_user6", 3, 50),
("new_user7", 4, 80),
("new_user8", 5, 130);'),
(5, 'insert into floor_workers values
("new_user3"),
("new_user4");'),
(6, 'insert into drones values
("krg", 2, 20, 3, "agarcia7"),
("pub", 6, 45, 2, "bsummers4");'),
(7, 'insert into drone_pilots values
("new_user5", "313161", 17);'),
(8, '&non_sql&evaluate_all_queries'),
(10, 'delete from users where uname like "new_user%";'),
(11, 'delete from employees where uname like "new_user%";'),
(12, 'delete from order_lines where orderID = "pub_303" and barcode = "clc_4T9U25X";'),
(13, 'delete from order_lines where orderID = "pub_303" and barcode = "hs_5E7L23M";'),
(14, 'delete from order_lines where orderID = "pub_306" and barcode = "clc_4T9U25X";'),
(15, 'delete from order_lines where orderID = "pub_305" and barcode = "pr_3C6A9R";'),
(16, 'delete from order_lines where orderID = "pub_305" and barcode = "ap_9T25E36L";'),
(17, 'delete from customers where uname like "new_user%";'),
(18, 'delete from drones where storeID = "krg" and droneTag = "2";'),
(19, 'delete from drones where storeID = "pub" and droneTag = "6";'),
(20, 'delete from drone_pilots where uname like "new_user%";'),
(21, 'delete from floor_workers where uname like "new_user%";');

drop function if exists magic44_query_exists;
delimiter //
create function magic44_query_exists(thisQuery integer)
	returns integer deterministic
begin
	return (select exists (select * from information_schema.views
		where table_schema = @thisDatabase
        and table_name like concat('practiceQuery', thisQuery)));
end //
delimiter ;

drop function if exists magic44_test_step_exists;
delimiter //
create function magic44_test_step_exists()
	returns integer deterministic
begin
	return (select exists (select * from magic44_testing_steps where stepID = @stepCounter));
end //
delimiter ;

-- Exception checking has been implemented to prevent (as much as reasonably possible) errors
-- in the queries being evaluated from interrupting the testing process
-- The magic44_log_query_errors table capture these errors for later review

drop table if exists magic44_log_query_errors;
create table magic44_log_query_errors (
	step_id integer,
    query_id integer,
    error_code char(5),
    error_message text	
);

drop procedure if exists magic44_query_check_and_run;
delimiter //
create procedure magic44_query_check_and_run(in thisQuery integer)
begin
	declare err_code char(5) default '00000';
    declare err_msg text;
    
	declare continue handler for SQLEXCEPTION
    begin
		get diagnostics condition 1
			err_code = RETURNED_SQLSTATE, err_msg = MESSAGE_TEXT;
	end;

	if magic44_query_exists(thisQuery) then
		set @sql_text = magic44_query_capture(thisQuery);
		prepare statement from @sql_text;
        execute statement;
        if err_code <> '00000' then
			insert into magic44_log_query_errors values (@stepCounter, thisQuery, err_code, err_msg);
		end if;
        deallocate prepare statement;
	end if;
end //
delimiter ;

drop procedure if exists magic44_test_step_check_and_run;
delimiter //
create procedure magic44_test_step_check_and_run()
begin
	if magic44_test_step_exists() then
		set @sql_text = (select changeInstruction from magic44_testing_steps where stepID = @stepCounter);
        if @sql_text = '&non_sql&evaluate_all_queries' then
			call magic44_evaluate_queries();
        else
			prepare statement from @sql_text;
			execute statement;
			deallocate prepare statement;
		end if;
	end if;
end //
delimiter ;

drop procedure if exists magic44_evaluate_queries;
delimiter //
create procedure magic44_evaluate_queries()
sp_main: begin
	set @startingQuery = 0, @endingQuery = 150;
    set @queryCounter = @startingQuery;
    
	all_queries: while @queryCounter <= @endingQuery do
		call magic44_query_check_and_run(@queryCounter);
		set @queryCounter = @queryCounter + 1;
	end while;
end //
delimiter ;

drop procedure if exists magic44_evaluate_testing_steps;
delimiter //
create procedure magic44_evaluate_testing_steps()
sp_main: begin
	set @startingStep = 0;    
    if not exists (select max(stepID) from magic44_testing_steps) then leave sp_main; end if;
    set @endingStep = (select max(stepID) from magic44_testing_steps);
	set @stepCounter = @startingStep;

    all_steps: repeat		
        call magic44_test_step_check_and_run();
        set @stepCounter = @stepCounter + 1;
	until (@stepCounter > @endingStep)
    end repeat;
end //
delimiter ;

-- These tables are used to store the answers and test results.  The answers are generated by executing
-- the test script against our reference solution.  The test results are collected by running the test
-- script against your submission in order to compare the results.

-- the results from magic44_data_capture the are transferred into the magic44_test_results table
drop table if exists magic44_test_results;
create table magic44_test_results (
	step_id integer not null,
    query_id integer,
	row_hash varchar(2000) not null
);

call magic44_evaluate_testing_steps();
insert into magic44_test_results
select stepID, queryID, concat_ws('#', ifnull(columndump0, ''), ifnull(columndump1, ''), ifnull(columndump2, ''), ifnull(columndump3, ''),
ifnull(columndump4, ''), ifnull(columndump5, ''), ifnull(columndump6, ''), ifnull(columndump7, ''), ifnull(columndump8, ''), ifnull(columndump9, ''),
ifnull(columndump10, ''), ifnull(columndump11, ''), ifnull(columndump12, ''), ifnull(columndump13, ''), ifnull(columndump14, ''))
from magic44_data_capture;

-- the answers generated from the reference solution are loaded below
drop table if exists magic44_expected_results;
create table magic44_expected_results (
	step_id integer not null,
    query_id integer,
	row_hash varchar(2000) not null
);

insert into magic44_expected_results values
(0,10,'claire#soares#888-88-8888############'),
(0,10,'erica#ross#444-44-4444############'),
(0,10,'harmon#stark#555-55-5555############'),
(0,10,'lina#rodriguez#222-22-2222############'),
(0,15,'wilson#220peachtreestreet#2020-03-15#pub#1##########'),
(0,15,'summers#5105dragonstarcircle#2018-12-06############'),
(0,15,'rodriguez#360corkscrewcircle#2019-04-15#pub#2##########'),
(0,16,'claire#soares#1965-09-03#706livingstoneway###########'),
(0,16,'gracie#hopper#1970-06-18#117compilercircle###########'),
(0,19,'220peachtreestreet#1963-11-11#100############'),
(0,19,'5105dragonstarcircle#1976-02-09#110############'),
(0,19,'77infinitestarsroad#1966-06-05#50############'),
(0,23,'181633#333-33-3333#33000#4###########'),
(0,23,'287182#222-22-2222#58000#2###########'),
(0,23,'411911#000-00-0000#35000############'),
(0,23,'610623#999-99-9999#41000############'),
(0,23,'657483#121-21-2121#20000#1###########'),
(0,24,'30#sarah#prince############'),
(0,24,'90#sally#turing############'),
(0,26,'claire#soares#706livingstoneway#1965-09-03###########'),
(0,26,'gracie#hopper#117compilercircle#1970-06-18###########'),
(0,26,'jared#stone#101fivefingerway#1961-01-06###########'),
(0,26,'sarah#prince#22peachtreestreet#1968-06-15###########'),
(0,26,'trey#mccall#360corkscrewcircle#1973-03-19###########'),
(0,27,'wilson#111-11-1111#2020-03-15############'),
(0,27,'soares#888-88-8888#2019-02-25############'),
(0,27,'ross#444-44-4444#2020-04-17############'),
(0,27,'stark#555-55-5555#2018-07-23############'),
(0,27,'rodriguez#222-22-2222#2019-04-15############'),
(0,29,'krg_217#2021-05-23#jstone5#krg###########'),
(0,30,'krg_217#2021-05-23#jstone5#krg###########'),
(0,30,'pub_306#2021-05-22#awilson5#pub###########'),
(0,33,'ford#10hitchhikerslane#657483############'),
(0,33,'trey#360corkscrewcircle#181633############'),
(0,35,'232-32-3232#2020-04-19#33000#whf#600##########'),
(0,35,'555-55-5555#2018-07-23#59000#pub#200##########'),
(0,35,'454-54-5454#2020-04-19#27000############'),
(0,37,'pub_303#antipastoplatter#4############'),
(0,37,'pub_305#chocolatelavacake#5############'),
(0,37,'pub_306#antipastoplatter#4############'),
(0,37,'pub_306#hoagiesandwich#3############'),
(0,38,'summers#brie#5105dragonstarcircle#1976-02-09###########'),
(0,38,'rodriguez#lina#360corkscrewcircle#1975-04-02###########'),
(0,43,'potroast#6#2############'),
(0,43,'potroast#6#1############'),
(0,43,'chocolatelavacake#5#2############'),
(0,43,'antipastoplatter#4#1############'),
(0,44,'alejandro#610623#1966-10-29############'),
(0,44,'aaron#314159#1963-11-11############'),
(0,44,'brie#411911#1976-02-09############'),
(0,44,'lina#287182#1975-04-02############'),
(0,46,'krg#1#15#4###########'),
(0,46,'pub#9#45#1###########'),
(0,49,'232-32-3232#2020-04-19#27#33000###########'),
(0,49,'555-55-5555#2018-07-23#20#59000###########'),
(0,49,'454-54-5454#2020-04-19#2#27000###########'),
(0,51,'111-11-1111#314159#2020-03-15############'),
(0,51,'222-22-2222#287182#2019-04-15############'),
(0,57,'000-00-0000#17#2018-12-06#35000###########'),
(0,57,'222-22-2222#20#2019-04-15#58000###########'),
(0,58,'pub#1#3#10###########'),
(0,58,'pub#2#2#20###########'),
(0,61,'clark#jordan#3############'),
(0,61,'jared#stone#4#krg_217###########'),
(0,61,'sarah#prince#5#pub_305###########'),
(0,61,'sarah#prince#5#pub_303###########'),
(0,61,'sally#turing#5############'),
(0,62,'2021-01-02#777-77-7777#27000#3###########'),
(0,62,'2020-04-17#444-44-4444#61000#10###########'),
(0,62,'2020-04-19#232-32-3232#33000#27###########'),
(0,62,'2018-07-23#555-55-5555#59000#20###########'),
(0,62,'2020-04-19#454-54-5454#27000#2###########'),
(0,64,'000-00-0000#35000#411911############'),
(0,64,'121-21-2121#20000#657483############'),
(0,64,'333-33-3333#33000#181633############'),
(8,10,'claire#soares#888-88-8888############'),
(8,10,'erica#ross#444-44-4444############'),
(8,10,'harmon#stark#555-55-5555############'),
(8,10,'lina#rodriguez#222-22-2222############'),
(8,10,'some#user#taxid_10############'),
(8,10,'some#user#taxid_250############'),
(8,15,'wilson#220peachtreestreet#2020-03-15#pub#1##########'),
(8,15,'summers#5105dragonstarcircle#2018-12-06#pub#6##########'),
(8,15,'rodriguez#360corkscrewcircle#2019-04-15#pub#2##########'),
(8,15,'user#anaddtreescircle#2020-03-15############'),
(8,15,'user#anaddresstreeinmystreet#2020-03-15############'),
(8,16,'claire#soares#1965-09-03#706livingstoneway###########'),
(8,16,'gracie#hopper#1970-06-18#117compilercircle###########'),
(8,16,'some#user#1963-02-01#atreelane###########'),
(8,19,'220peachtreestreet#1963-11-11#100############'),
(8,19,'5105dragonstarcircle#1976-02-09#110############'),
(8,19,'77infinitestarsroad#1966-06-05#50############'),
(8,19,'anaddtreescircle#1964-06-01#20############'),
(8,19,'anaddresstreeinmystreet#1965-05-01#30############'),
(8,19,'atree#1966-07-01#50############'),
(8,23,'181633#333-33-3333#33000#4###########'),
(8,23,'287182#222-22-2222#58000#2###########'),
(8,23,'313161#taxid_250#60000############'),
(8,23,'411911#000-00-0000#35000#2###########'),
(8,23,'610623#999-99-9999#41000#3###########'),
(8,23,'657483#121-21-2121#20000#1###########'),
(8,24,'130#some#user############'),
(8,24,'30#sarah#prince############'),
(8,24,'90#sally#turing############'),
(8,26,'claire#soares#706livingstoneway#1965-09-03###########'),
(8,26,'gracie#hopper#117compilercircle#1970-06-18###########'),
(8,26,'jared#stone#101fivefingerway#1961-01-06###########'),
(8,26,'some#user#anaddtreescircle#1964-06-01###########'),
(8,26,'some#user#anaddresstreeinmystreet#1965-05-01###########'),
(8,26,'sarah#prince#22peachtreestreet#1968-06-15###########'),
(8,26,'trey#mccall#360corkscrewcircle#1973-03-19###########'),
(8,27,'wilson#111-11-1111#2020-03-15############'),
(8,27,'soares#888-88-8888#2019-02-25############'),
(8,27,'ross#444-44-4444#2020-04-17############'),
(8,27,'stark#555-55-5555#2018-07-23############'),
(8,27,'rodriguez#222-22-2222#2019-04-15############'),
(8,27,'user#taxid_10#2020-03-15############'),
(8,27,'user#taxid_250#2020-03-15############'),
(8,29,'krg_217#2021-05-23#jstone5#krg###########'),
(8,30,'krg_217#2021-05-23#jstone5#krg###########'),
(8,30,'pub_306#2021-05-22#awilson5#pub###########'),
(8,33,'ford#10hitchhikerslane#657483############'),
(8,33,'some#anaddresstreeinmystreet#313161############'),
(8,33,'trey#360corkscrewcircle#181633############'),
(8,35,'232-32-3232#2020-04-19#33000#whf#600##########'),
(8,35,'555-55-5555#2018-07-23#59000#pub#200##########'),
(8,35,'454-54-5454#2020-04-19#27000############'),
(8,35,'taxid_25#2020-03-15#20000############'),
(8,35,'taxid_100#2020-03-15#10000############'),
(8,37,'pub_303#antipastoplatter#4############'),
(8,37,'pub_303#chocolatelavacake#5############'),
(8,37,'pub_305#antipastoplatter#4############'),
(8,37,'pub_305#chocolatelavacake#5############'),
(8,37,'pub_306#antipastoplatter#4############'),
(8,37,'pub_306#chocolatelavacake#5############'),
(8,37,'pub_306#hoagiesandwich#3############'),
(8,38,'summers#brie#5105dragonstarcircle#1976-02-09###########'),
(8,38,'rodriguez#lina#360corkscrewcircle#1975-04-02###########'),
(8,38,'user#some#anaddresstreeinmystreet#1965-05-01###########'),
(8,43,'potroast#6#2############'),
(8,43,'hoagiesandwich#3#1############'),
(8,43,'potroast#6#1############'),
(8,43,'antipastoplatter#4#2############'),
(8,43,'chocolatelavacake#5#2############'),
(8,43,'potroast#6#1############'),
(8,43,'antipastoplatter#4#1############'),
(8,44,'alejandro#610623#1966-10-29############'),
(8,44,'aaron#314159#1963-11-11############'),
(8,44,'brie#411911#1976-02-09############'),
(8,44,'lina#287182#1975-04-02############'),
(8,46,'krg#1#15#4###########'),
(8,46,'krg#2#20#3###########'),
(8,46,'pub#6#45#2###########'),
(8,46,'pub#9#45#1###########'),
(8,49,'232-32-3232#2020-04-19#27#33000###########'),
(8,49,'555-55-5555#2018-07-23#20#59000###########'),
(8,49,'454-54-5454#2020-04-19#2#27000###########'),
(8,49,'taxid_25#2020-03-15#25#20000###########'),
(8,49,'taxid_100#2020-03-15#10#10000###########'),
(8,51,'111-11-1111#314159#2020-03-15############'),
(8,51,'222-22-2222#287182#2019-04-15############'),
(8,57,'000-00-0000#17#2018-12-06#35000###########'),
(8,57,'222-22-2222#20#2019-04-15#58000###########'),
(8,58,'pub#1#3#10###########'),
(8,58,'pub#2#2#20###########'),
(8,58,'pub#6#2#45###########'),
(8,61,'clark#jordan#3############'),
(8,61,'jared#stone#4#krg_217###########'),
(8,61,'some#user#1############'),
(8,61,'some#user#3############'),
(8,61,'some#user#4############'),
(8,61,'some#user#5############'),
(8,61,'sarah#prince#5#pub_305###########'),
(8,61,'sarah#prince#5#pub_303###########'),
(8,61,'sally#turing#5############'),
(8,62,'2021-01-02#777-77-7777#27000#3###########'),
(8,62,'2020-04-17#444-44-4444#61000#10###########'),
(8,62,'2020-04-19#232-32-3232#33000#27###########'),
(8,62,'2018-07-23#555-55-5555#59000#20###########'),
(8,62,'2020-04-19#454-54-5454#27000#2###########'),
(8,62,'2020-03-15#taxid_25#20000#25###########'),
(8,62,'2020-03-15#taxid_100#10000#10###########'),
(8,64,'000-00-0000#35000#411911############'),
(8,64,'121-21-2121#20000#657483############'),
(8,64,'taxid_250#60000#313161############'),
(8,64,'333-33-3333#33000#181633############');

-- Delete the unneeded rows from the answers table to simplify later analysis
delete from magic44_expected_results where not magic44_query_exists(query_id);

-- Modify the row hash results for the results table to eliminate spaces and convert all characters to lowercase
update magic44_test_results set row_hash = lower(replace(row_hash, ' ', ''));

-- The magic44_count_differences view displays the differences between the number of rows contained in the answers
-- and the test results.  the value null in the answer_total and result_total columns represents zero (0) rows for
-- that query result.

drop view if exists magic44_count_answers;
create view magic44_count_answers as
select step_id, query_id, count(*) as answer_total
from magic44_expected_results group by step_id, query_id;

drop view if exists magic44_count_test_results;
create view magic44_count_test_results as
select step_id, query_id, count(*) as result_total
from magic44_test_results group by step_id, query_id;

drop view if exists magic44_count_differences;
create view magic44_count_differences as
select magic44_count_answers.query_id, magic44_count_answers.step_id, answer_total, result_total
from magic44_count_answers left outer join magic44_count_test_results
	on magic44_count_answers.step_id = magic44_count_test_results.step_id
	and magic44_count_answers.query_id = magic44_count_test_results.query_id
where answer_total <> result_total or result_total is null
union
select magic44_count_test_results.query_id, magic44_count_test_results.step_id, answer_total, result_total
from magic44_count_test_results left outer join magic44_count_answers
	on magic44_count_test_results.step_id = magic44_count_answers.step_id
	and magic44_count_test_results.query_id = magic44_count_answers.query_id
where result_total <> answer_total or answer_total is null
order by query_id, step_id;

-- The magic44_content_differences view displays the differences between the answers and test results
-- in terms of the row attributes and values.  the error_category column contains missing for rows that
-- are not included in the test results but should be, while extra represents the rows that should not
-- be included in the test results.  the row_hash column contains the values of the row in a single
-- string with the attribute values separated by a selected delimeter (i.e., the pound sign/#).

drop view if exists magic44_content_differences;
create view magic44_content_differences as
select query_id, step_id, 'missing' as category, row_hash
from magic44_expected_results where concat(step_id, '@', query_id, '@',row_hash) not in
	(select concat(step_id, '@', query_id, '@', row_hash) from magic44_test_results)
union
select query_id, step_id, 'extra' as category, row_hash
from magic44_test_results where concat(step_id, '@', query_id, '@', row_hash) not in
	(select concat(step_id, '@', query_id, '@', row_hash) from magic44_expected_results)
order by query_id, step_id, row_hash;

drop view if exists magic44_result_set_size_errors;
create view magic44_result_set_size_errors as
select step_id, query_id, 'result_set_size' as err_category from magic44_count_differences
group by step_id, query_id;

drop view if exists magic44_attribute_value_errors;
create view magic44_attribute_value_errors as
select step_id, query_id, 'attribute_values' as err_category from magic44_content_differences
where concat(step_id, '@', query_id) not in (select concat(step_id, '@', query_id) from magic44_count_differences)
group by step_id, query_id;

drop view if exists magic44_errors_assembled;
create view magic44_errors_assembled as
select * from magic44_result_set_size_errors
union    
select * from magic44_attribute_value_errors;

drop table if exists magic44_row_count_errors;
create table magic44_row_count_errors (
	query_id integer,
    step_id integer,
    expected_row_count integer,
    actual_row_count integer
);

insert into magic44_row_count_errors
select * from magic44_count_differences
order by query_id, step_id;

drop table if exists magic44_column_errors;
create table magic44_column_errors (
	query_id integer,
    step_id integer,
    extra_or_missing char(20),
    condensed_row_contents varchar(15000)
);

insert into magic44_column_errors
select * from magic44_content_differences
order by query_id, step_id, row_hash;

-- Evaluate potential query errors against the original state and the modified state
drop view if exists magic44_result_errs_original;
create view magic44_result_errs_original as
select distinct 'row_count_errors_initial_state' as title, query_id
from magic44_row_count_errors where step_id = 0;

drop view if exists magic44_result_errs_modified;
create view magic44_result_errs_modified as
select distinct 'row_count_errors_modified_state' as title, query_id
from magic44_row_count_errors
where query_id not in (select query_id from magic44_result_errs_original)
union
select * from magic44_result_errs_original;

drop view if exists magic44_attribute_errs_original;
create view magic44_attribute_errs_original as
select distinct 'column_errors_initial_state' as title, query_id
from magic44_column_errors where step_id = 0
and query_id not in (select query_id from magic44_result_errs_modified)
union
select * from magic44_result_errs_modified;

drop view if exists magic44_attribute_errs_modified;
create view magic44_attribute_errs_modified as
select distinct 'column_errors_modified_state' as title, query_id
from magic44_column_errors
where query_id not in (select query_id from magic44_attribute_errs_original)
union
select * from magic44_attribute_errs_original;

drop view if exists magic44_correct_remainders;
create view magic44_correct_remainders as
select distinct 'fully_correct' as title, query_id
from magic44_test_results
where query_id not in (select query_id from magic44_attribute_errs_modified)
union
select * from magic44_attribute_errs_modified;

drop view if exists magic44_grading_rollups;
create view magic44_grading_rollups as
select title, count(*) as number_affected, group_concat(query_id order by query_id asc) as queries_affected
from magic44_correct_remainders
group by title;

drop table if exists magic44_autograding_results;
create table magic44_autograding_results (
	query_status varchar(1000),
    number_affected integer,
    queries_affected varchar(2000)
);

drop table if exists magic44_autograding_directory;
create table magic44_autograding_directory (query_status_category varchar(1000));
insert into magic44_autograding_directory values ('column_errors_initial_state'),
('column_errors_modified_state'), ('fully_correct'), ('row_count_errors_initial_state'),
('row_count_errors_modified_state');

insert into magic44_autograding_results
select query_status_category, number_affected, queries_affected
from magic44_autograding_directory left outer join magic44_grading_rollups
on query_status_category = title;

create view magic44_row_count_differences as
select *, if(count_initial = count_modified, "check", "") as repairs from
(select query_id, count(*) as count_initial
from magic44_test_results
where step_id = (select min(step_id) from magic44_test_results)
group by step_id, query_id) as results_initial
natural join
(select query_id, count(*) as count_modified
from magic44_test_results
where step_id = (select max(step_id) from magic44_test_results)
group by step_id, query_id) as results_modified;

-- Remove all unneeded tables, views, stored procedures and functions
-- Keep only those structures needed to provide student feedback
drop table if exists magic44_autograding_directory;
drop view if exists magic44_grading_rollups;
drop view if exists magic44_correct_remainders;
drop view if exists magic44_attribute_errs_modified;
drop view if exists magic44_attribute_errs_original;
drop view if exists magic44_result_errs_modified;
drop view if exists magic44_result_errs_original;
drop view if exists magic44_errors_assembled;
drop view if exists magic44_attribute_value_errors;
drop view if exists magic44_result_set_size_errors;
drop view if exists magic44_content_differences;
drop view if exists magic44_count_differences;
drop view if exists magic44_count_test_results;
drop view if exists magic44_count_answers;
drop procedure if exists magic44_evaluate_testing_steps;
drop procedure if exists magic44_evaluate_queries;
drop procedure if exists magic44_test_step_check_and_run;
drop procedure if exists magic44_query_check_and_run;
drop function if exists magic44_test_step_exists;
drop function if exists magic44_query_exists;
drop function if exists magic44_query_capture;
drop function if exists magic44_gen_simple_template;
drop table if exists magic44_column_listing;
drop table if exists magic44_data_capture;
