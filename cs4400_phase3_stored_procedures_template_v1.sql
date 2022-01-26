-- CS4400: Introduction to Database Systems (Fall 2021)
-- Phase III: Stored Procedures & Views [v0] Tuesday, November 9, 2021 @ 12:00am EDT
-- Team 128
-- Team 
-- Team Member Name ahussain61	
-- Team Member Name honeal3
-- Team Member Name (GT username)
-- Directions:
-- Please follow all instructions for Phase III as listed on Canvas.
-- Fill in the team number and names +and GT usernames for all members above.


-- ID: 1a
-- Name: register_customer
drop procedure if exists register_customer;
delimiter //
create procedure register_customer (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12),
    in i_cc_number varchar(19),
    in i_cvv char(3),
    in i_exp_date date,
    in i_location varchar(50)
) 
sp_main: begin
if(i_email not in (select email from Clients) and i_email not in (select email from Accounts)) then 
insert into Accounts values(i_email , i_first_name , i_last_name , i_password);
insert into Clients values(i_email , i_phone_number);
insert into Customer values(i_email , i_cc_number , i_cvv , i_exp_date , i_location);

else
insert into Customer values(i_email , i_cc_number , i_cvv , i_exp_date , i_location);

end if;

end //
delimiter ;

call register_customer('falcon@gmail.com', 'Samuel', 'Wilson', 'password22', '777-469-5347', '9121 2762 7467 5215', '809', '2022-05-11', 'Baton Rouge'); 
call register_customer('asdsd@gmail.com', 'Samuel', 'B jacson', 'password23', '777-469-4252', '9121 2762 7467 5252', '909', '2022-05-11', 'Baton Rouge'); 


-- ID: 1b
-- Name: register_owner
drop procedure if exists register_owner;
delimiter //
create procedure register_owner (
    in i_email varchar(50),
    in i_first_name varchar(100),
    in i_last_name varchar(100),
    in i_password varchar(50),
    in i_phone_number char(12)
) 
sp_main: begin
if(i_email not in (select email from Clients) and i_email not in (select email from Accounts)) then 

insert into Accounts values(i_email , i_first_name , i_last_name , i_password);
insert into Clients values(i_email , i_phone_number);
insert into Owners values(i_email);

else
insert into Owners values(i_email);
end if;
end //
delimiter ;

call register_owner('worldchampion@gmail.com', 'Magnus', 'Carlsen', 'password25', '404-720-5367'); 
call register_owner('asdsd@gmail.com', 'Samuel', 'B jacson', 'password23', '777-469-4252'); 


-- ID: 1c
-- Name: remove_owner
drop procedure if exists remove_owner;
delimiter //
create procedure remove_owner ( 
    in i_owner_email varchar(50)
)
sp_main: begin
if (i_owner_email not in (select Email from customer)) then
 
delete from Owners where Email = i_owner_email;
delete from Clients where Email = i_owner_email;
delete from Accounts where Email = i_owner_email;

else

delete from Owners where Email = i_owner_email;

end if;
end //
delimiter ;
call remove_owner('gburdell3@gmail.com'); 


-- ID: 2a
-- Name: schedule_flight
drop procedure if exists schedule_flight;
delimiter //
create procedure schedule_flight (
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_from_airport char(3),
    in i_to_airport char(3),
    in i_departure_time time,
    in i_arrival_time time,
    in i_flight_date date,
    in i_cost decimal(6, 2),
    in i_capacity int,
    in i_current_date date
)
sp_main: begin
if(i_from_airport = i_to_airport)then leave sp_main; end if;
if(i_current_date >= i_flight_date)then leave sp_main; end if;

insert into Flight values (i_flight_num , i_airline_name , i_from_airport , i_to_airport , i_departure_time , 
i_arrival_time , i_flight_date , i_cost ,i_capacity);


end //
delimiter ;

call schedule_flight('3', 'Southwest Airlines', 'MIA', 'DFW', '130000', '160000', '2021-10-18', 350, 125, '2021-10-04');
-- ID: 2b
-- Name: remove_flight
drop procedure if exists remove_flight;
delimiter //
create procedure remove_flight ( 
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
) 
sp_main: begin
if (i_current_date >= (select Flight_Date from flight where Airline_Name = i_airline_name and Flight_Num = i_flight_num))then leave sp_main; end if;

delete from Book where i_airline_name = Airline_Name and i_flight_num = Flight_Num;
delete from Flight where i_airline_name = Airline_Name and i_flight_num = Flight_Num;

end //
delimiter ;
call remove_flight('2', 'Southwest Airlines', '2021-10-19');

-- ID: 3a
-- Name: book_flight
drop procedure if exists book_flight;
delimiter //
create procedure book_flight (
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_num_seats int,
    in i_current_date date
)
sp_main: begin

if((select Flight_Date from Flight where Airline_Name = i_airline_name and Flight_Num = i_flight_num) 
in (select Flight_Date from book join flight on book.flight_num = flight.flight_num and book.airline_name = flight.airline_name 
where Customer = i_customer_email and book.Airline_Name != i_airline_name 
and book.Flight_Num != i_flight_num and Was_Cancelled = 0)) then leave sp_main; end if;

if(i_num_seats > (select ifnull((capacity - sum(num_seats)) , capacity)
from flight left join book on flight.Airline_Name = book.Airline_Name 
and flight.Flight_Num = book.Flight_Num and Was_Cancelled = 0
group by flight.Airline_Name , flight.Flight_Num
having flight.Airline_Name = i_airline_name and flight.Flight_Num = i_flight_num)) then leave sp_main; end if;

if (i_current_date >= (select Flight_Date from flight where Airline_Name = i_airline_name and Flight_Num = i_flight_num))then leave sp_main; end if;

if(i_customer_email in (select Customer from book where Customer =  i_customer_email and Airline_Name = i_airline_name 
and Flight_Num = i_flight_num and Was_Cancelled = 1)) then leave sp_main; end if;

if(i_customer_email in (select Customer from book where Customer = i_customer_email and Airline_Name = i_airline_name 
and Flight_Num = i_flight_num and Was_Cancelled = 0)) then 

update book set Num_Seats = i_num_seats where Customer = i_customer_email and Airline_Name = i_airline_name 
and Flight_Num = i_flight_num;

else

insert into book values(i_customer_email , i_flight_num , i_airline_name , i_num_seats , 0);

end if;
end //
delimiter ;
call book_flight('cbing10@gmail.com', '2', 'Southwest Airlines', 2, '2021-10-1'); 

-- ID: 3b
-- Name: cancel_flight_booking
drop procedure if exists cancel_flight_booking;
delimiter //
create procedure cancel_flight_booking ( 
    in i_customer_email varchar(50),
    in i_flight_num char(5),
    in i_airline_name varchar(50),
    in i_current_date date
)
sp_main: begin
if( i_customer_email not in 
(select Customer from Book where Flight_Num = i_flight_num and Airline_Name = i_airline_name)) then leave sp_main; end if;
if (i_current_date >= (select Flight_Date from flight where Airline_Name = i_airline_name and Flight_Num = i_flight_num))then leave sp_main; end if; -- Check date less then or greater than

update Book set Was_Cancelled = 1 where Customer = i_customer_email and Airline_Name = i_airline_name and Flight_Num = i_flight_num;

end //
delimiter ;
call cancel_flight_booking('bshelto@gmail.com', '4', 'United Airlines', '2021-10-21'); 


-- ID: 3c
-- Name: view_flight
create or replace view view_flight (
    flight_id,
    flight_date,
    airline,
    destination,
    seat_cost,
    num_empty_seats,
    total_spent
) as
-- TODO: replace this select query with your solution
select f.Flight_Num, Flight_Date , f.Airline_Name,To_Airport,Cost, 
f.Capacity - ifnull(sum(b.Num_Seats * IF(b.Was_Cancelled, 0, 1)), 0) as num_empty_seats,
truncate(ifnull(sum((f.Cost * b.Num_Seats) * IF(b.Was_Cancelled, 0.2, 1)), 0), 3) as total_spent from flight f
left join book b on f.Airline_Name = b.Airline_Name and f.Flight_Num = b.Flight_Num 
group by f.Airline_Name , f.Flight_Num ;

-- ID: 4a
-- Name: add_property
drop procedure if exists add_property;
delimiter //
create procedure add_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_description varchar(500),
    in i_capacity int,
    in i_cost decimal(6, 2),
    in i_street varchar(50),
    in i_city varchar(50),
    in i_state char(2),
    in i_zip char(5),
    in i_nearest_airport_id char(3),
    in i_dist_to_airport int
) 
sp_main: begin
if(i_nearest_airport_id is null and i_dist_to_airport is null) then
insert into Property values
(i_property_name , i_owner_email , i_description , i_capacity , i_cost , i_street , i_city , i_state , i_zip);

else 

insert into Property values
(i_property_name , i_owner_email , i_description , i_capacity , i_cost , i_street , i_city , i_state , i_zip);
insert into Is_Close_To values(i_property_name , i_owner_email , i_nearest_airport_id , i_dist_to_airport );

end if;
  
end //
delimiter ;

call add_property('under ifflin', 'cbing10@gmail.com', ' great paper company for an overnight stay!', 15, 50.00, 'lough Avenue', 'Sranton', 'PA', 18503, NULL, NULL);

-- ID: 4b
-- Name: remove_property
drop procedure if exists remove_property;
delimiter //
create procedure remove_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_current_date date
)
sp_main: begin
if(i_property_name in 
(select Property_Name from Reserve where Property_Name = i_property_name and Owner_Email = i_owner_email and Was_Cancelled = 0 and i_current_date between Start_Date and End_Date))
then leave sp_main; end if;

delete from Reserve where Property_Name = i_property_name and Owner_Email = i_owner_email;
delete from Property where Property_Name = i_property_name and Owner_Email = i_owner_email;
end //
delimiter ;
call remove_property('Beautiful San Jose Mansion', 'arthurread@gmail.com', '2021-10-21'); 

-- ID: 5a
-- Name: reserve_property
drop procedure if exists reserve_property;
delimiter //
create procedure reserve_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_start_date date,
    in i_end_date date,
    in i_num_guests int,
    in i_current_date date
)
sp_main: begin
if (i_current_date >= i_start_date)then leave sp_main; end if;
if (i_customer_email in (select customer from reserve where i_start_date between Start_Date and End_Date and Was_Cancelled = 0)) then leave sp_main; end if;
if (i_customer_email in (select customer from reserve where i_end_date between Start_Date and End_Date and Was_Cancelled = 0)) then leave sp_main; end if;
if (i_customer_email in (select customer from reserve where Start_Date between i_start_date and i_end_date and Was_Cancelled = 0)) then leave sp_main; end if;
if (i_customer_email in (select customer from reserve where End_Date between i_start_date and i_end_date and Was_Cancelled = 0)) then leave sp_main; end if;
-- Cant figure this out.
if(i_num_guests > (select ifnull((Capacity - (sum(num_guests))) , Capacity) from property join reserve on
property.Owner_Email = reserve.owner_email and property.Property_Name = reserve.Property_Name
where reserve.Owner_Email = i_owner_email and reserve.Property_Name = i_property_name and
((Start_Date between i_start_date and i_end_date)
or (End_Date between i_start_date and i_end_date)
or (i_start_date between Start_Date and End_Date) or (i_end_date between Start_Date and End_Date))
and Was_Cancelled = 0
group by property.Property_Name , property.Owner_Email)) then leave sp_main; end if;

insert into Reserve values(i_property_name , i_owner_email , i_customer_email , i_start_date , i_end_date , i_num_guests , 0);

end //
delimiter ;
call reserve_property('Beautiful San Jose Mansion', 'arthurread@gmail.com', 'johnthomas@gmail.com', '2021-10-19', '2021-10-22', 9, '2021-10-01');


-- ID: 5b
-- Name: cancel_property_reservation
drop procedure if exists cancel_property_reservation;
delimiter //
create procedure cancel_property_reservation (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_current_date date
)
sp_main: begin
if(i_customer_email not in (select Customer from Reserve where Property_Name = 
i_property_name and Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;

if(i_customer_email in (select Customer from Reserve where Property_Name = i_property_name 
and Owner_Email = i_owner_email and Customer = i_customer_email and Was_Cancelled = 1))then leave sp_main; end if;

if(i_current_date >= (select Start_Date from Reserve where Property_Name = i_property_name 
and Owner_Email = i_owner_email and Customer = i_customer_email)) then leave sp_main; end if;

update Reserve set Was_Cancelled = 1 where 
i_customer_email = Customer and Property_Name = i_property_name 
and Owner_Email = i_owner_email;

end //
delimiter ;
call cancel_property_reservation('Beautiful Beach Property', 'msmith5@gmail.com', 'cbing10@gmail.com', '2021-10-01'); 

-- ID: 5c
-- Name: customer_review_property
drop procedure if exists customer_review_property;
delimiter //
create procedure customer_review_property (
    in i_property_name varchar(50),
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_content varchar(500),
    in i_score int,
    in i_current_date date
)
sp_main: begin
if(i_customer_email not in (select Customer from reserve where Owner_Email = i_owner_email and Was_Cancelled = 0 and i_current_date >= Start_Date)) then leave sp_main; end if;

insert into Review values(i_property_name  , i_owner_email , i_customer_email , i_content , i_score);
    
end //
delimiter ;
call customer_review_property('Beautiful Beach Property', 'msmith5@gmail.com', 'cbing10@gmail.com', 'This property was amazing!', 5, '0050-12-19'); 
-- ID: 5d
-- Name: view_properties
create or replace view view_properties (
    property_name, 
    average_rating_score, 
    description, 
    address, 
    capacity, 
    cost_per_night
) as
-- TODO: replace this select query with your solution
select Property.Property_name , avg(score) ,  Descr , concat(Street , ', ', City , ', ' , State , ', ' , Zip) as Adress , 
Capacity , Cost from Property left join Review on Property.Property_name = Review.Property_name 
group by Property.Property_name , Descr , street , city , state , zip , capacity , cost;


-- ID: 5e
-- Name: view_individual_property_reservations
drop procedure if exists view_individual_property_reservations;
delimiter //
create procedure view_individual_property_reservations (
    in i_property_name varchar(50),
    in i_owner_email varchar(50)
)
sp_main: begin
    drop table if exists view_individual_property_reservations;
    create table view_individual_property_reservations (
        property_name varchar(50),
        start_date date,
        end_date date,
        customer_email varchar(50),
        customer_phone_num char(12),
        total_booking_cost decimal(6,2),
        rating_score int,
        review varchar(500)
    ) as
    -- reserve.Property_Name , Start_Date , End_Date ,
    select reserve.Property_Name as  property_name , Start_Date as start_date, End_Date as end_date, reserve.Customer as customer_email, 
    Phone_Number as customer_phone_num , 
    if(was_cancelled = 1, ((DateDiff(End_Date,Start_Date) + 1) * cost) * .20 ,((DateDiff(End_Date,Start_Date)+1) * cost)) as total_booking_cost , score as rating_score , content as review
	from reserve left join Clients on reserve.customer = Email left join Review on 
	reserve.Owner_Email = review.Owner_Email and reserve.customer = review.customer 
	and reserve.Property_Name = review.Property_Name left join Property on
	reserve.Owner_Email = Property.Owner_Email and reserve.Property_Name = Property.Property_Name 
	where reserve.Property_name = i_property_name and reserve.Owner_Email = i_owner_email ;
    
    
   -- if(was_cancelled = 1, (DateDiff(End_Date,Start_Date) * cost) * .20 ,(DateDiff(End_Date,Start_Date) * cost))

end //
delimiter ;

call view_individual_property_reservations('House near Georgia Tech', 'gburdell3@gmail.com');

-- ID: 6a
-- Name: customer_rates_owner
drop procedure if exists customer_rates_owner;
delimiter //
create procedure customer_rates_owner (
    in i_customer_email varchar(50),
    in i_owner_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
if(i_customer_email not in (select Customer from reserve where Owner_Email = i_owner_email and Customer = i_customer_email and Was_Cancelled = 0 and i_current_date >= Start_Date))then leave sp_main; end if;

insert into Customers_Rate_Owners values(i_customer_email , i_owner_email , i_score);

end //
delimiter ;
call customer_rates_owner('aray@tiktok.com', 'mj23@gmail.com', 3, '2021-10-17');

-- ID: 6b
-- Name: owner_rates_customer
drop procedure if exists owner_rates_customer;
delimiter //
create procedure owner_rates_customer (
    in i_owner_email varchar(50),
    in i_customer_email varchar(50),
    in i_score int,
    in i_current_date date
)
sp_main: begin
if(i_customer_email not in (select Customer from reserve where Owner_Email = i_owner_email and Was_Cancelled = 0 and i_current_date >= Start_Date))then leave sp_main; end if;

insert into Owners_Rate_Customers values(i_owner_email , i_customer_email , i_score);


end //
delimiter ;
call owner_rates_customer('msmith5@gmail.com', 'cbing10@gmail.com', 4, '2021-10-18'); 

-- ID: 7a
-- Name: view_airports
create or replace view view_airports (
    airport_id, 
    airport_name, 
    time_zone, 
    total_arriving_flights, 
    total_departing_flights, 
    avg_departing_flight_cost
) as
-- TODO: replace this select query with your solution    
select Airport_Id , Airport_Name , Time_Zone , ifnull(count_to, 0) , ifnull(count_from , 0) , average_cost
from Airport left join (select to_airport , count(*) as count_to from flight group by to_airport) as to_flight on Airport_Id = to_flight.To_Airport
left join ( select From_Airport, count(*) as count_from, avg(Cost) as average_cost from Flight 
group by From_Airport) as from_flight on Airport_Id = from_flight.From_Airport
group by Airport_Id , Airport_Name;
 
-- ID: 7b
-- Name: view_airlines
create or replace view view_airlines (
    airline_name, 
    rating, 
    total_flights, 
    min_flight_cost
) as
-- TODO: replace this select query with your solution
select Airline_Name , rating , count(*) , min(cost) from Airline natural join Flight group by Airline_Name;


-- ID: 8a
-- Name: view_customers
create or replace view view_customers (
    customer_name, 
    avg_rating, 
    location, 
    is_owner, 
    total_seats_purchased
) as
-- TODO: replace this select query with your solution
-- view customers
select concat(First_name , ' ', Last_Name) as name , avg(score), location ,(Case When Owners.email is Null then 0 Else 1 end) , 
ifnull(sum(num_seats) , 0)
from Accounts left join Customer on Customer.Email = Accounts.Email left join Book on Book.Customer = Customer.Email 
left join Owners_Rate_Customers on Customer.Email = Owners_Rate_Customers.customer left join Owners on 
Accounts.email = Owners.Email
where Accounts.Email in (select Email from Customer) group by First_Name , Last_Name , location , Owners.email  order by First_name;


-- ID: 8b
-- Name: view_owners
create or replace view view_owners (
    owner_name, 
    avg_rating, 
    num_properties_owned, 
    avg_property_rating
) as
-- TODO: replace this select query with your solution
select concat(First_name , ' ' , Last_Name), avg(Customers_Rate_Owners.score), count(distinct(property.Property_Name)),  avg(Review.score) 
from Accounts join Owners on Owners.Email = Accounts.Email 
left join Customers_Rate_Owners on Owner_Email = Owners.Email 
left join Property on Property.Owner_Email = Owners.Email 
left join Review on Review.Owner_Email = Owners.Email
group by First_name , Last_name;

-- ID: 9a
-- Name: process_date
drop procedure if exists process_date;
delimiter //
create procedure process_date ( 
    in i_current_date date
)
sp_main: begin
-- Ask about the note.
update Customer set location = (select state from airport join flight on airport_id = to_airport 
join book on book.flight_num = flight.flight_num and flight.airline_name = book.airline_name 
where was_cancelled = 0 and customer = customer.email and Flight_Date = i_current_date) 
where customer.email in (select Customer from book join flight on book.flight_num = flight.flight_num and book.airline_name = flight.airline_name 
where was_cancelled = 0 and flight_date = i_current_date);
end //
delimiter ;
call process_date('2021-10-19');

