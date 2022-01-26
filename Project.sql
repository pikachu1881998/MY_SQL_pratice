DROP DATABASE IF EXISTS travel;
CREATE DATABASE IF NOT EXISTS travel;
USE travel;
 

DROP TABLE IF EXISTS airport;
CREATE TABLE airport (
	airport_id char(3),
    airport_name char(200) NOT NULL,
    timezone char(5),
    street char(60) NOT NULL,
    city char(20) NOT NULL,
    state char(3) NOT NULL,
    zip_code decimal(5 , 0) NOT NULL,
    UNIQUE KEY(street , city , state , zip_code),
    UNIQUE KEY(airport_name),
    PRIMARY KEY(airport_id)
)ENGINE=InnoDB;

INSERT INTO airport VALUES
('ATL' , 'Atlanta Hartsfield Jackson Airport' , 'EST' , '6000 N Terminal Pkwy' , 'Atlanta' , 'GA' , 30320);
INSERT INTO airport VALUES
('JFK', 'John F Kennedy International Airport', 'EST' , '455 Airport Ave' , 'Queens', 'NY', 11430);
insert into airport values
('LGA',	'Laguardia Airport', 'EST',	'790 Airport St',	'Queens',	'NY',	11371);
insert into airport values
('LAX','Lost Angeles International Airport','PST','1 World Way','Los Angeles','CA',90045);
insert into airport values
('SJC','Norman Y. Mineta San Jose International Airport','PST',	'1702 Airport Blvd','San Jose',	'CA',95110);
insert into airport values
('ORD',"O'Hare International Airport",'CST',"10000 W O'Hare Ave",'Chicago','IL',60666);
insert into airport values
('MIA','Miami International Airport','EST','2100 NW 42nd Ave','Miami','FL',33126);
insert into airport values
('DFW','Dallas International Airport','CST','2400 Aviation DR','Dallas','TX',75261);



DROP TABLE IF EXISTS airlines;
CREATE TABLE airlines (
	ailines_name char(70),
    raiting float,
    PRIMARY KEY(ailines_name)
)ENGINE=InnoDB;

INSERT INTO airlines VALUES
('Delta Airlines' , 4.7);
insert into airlines values
('Southwest Airlines', 4.4);
insert into airlines values
('American Airlines', 4.6);
insert into airlines values
('United Airlines',4.2);
insert into airlines values
('JetBlue Airways',	3.6);
insert into airlines values
('Spirit Airlines',	3.3);
insert into airlines values
('WestJet',	3.9);
insert into airlines values
('Interjet', 3.7);


DROP TABLE IF EXISTS flights;
CREATE TABLE flights (
	fligh_number decimal(5 , 0),
	name_airlines char(70),
    departs_from char(20) NOT NULL,
    arrives_at char(20) NOT NULL,
    departure_time char(10),
    arrival_time char(10),
    departing_date date,
    cost_per_seat float,
    capacity double(5,0),
    PRIMARY KEY(name_airlines , fligh_number),
    CONSTRAINT FOREIGN KEY(name_airlines) REFERENCES airlines(ailines_name),
    CONSTRAINT FOREIGN KEY(departs_from) REFERENCES airport(airport_id),
    CONSTRAINT FOREIGN KEY(arrives_at) REFERENCES airport(airport_id)
)ENGINE=InnoDB;

INSERT INTO flights VALUES
('1','Delta Airlines','ATL','JFK','10:00 AM','12:00 PM','2021-10-18',400,150);
INSERT INTO flights VALUES
('2','Southwest Airlines','ORD','MIA','10:30 AM','2:30 PM','2021-10-18',350,125);
INSERT INTO flights VALUES
('3','American Airlines','MIA','DFW','1:00 PM','4:00 PM','2021-10-18',350,125);
INSERT INTO flights VALUES
('4','United Airlines','ATL','LGA','4:30 PM','6:30 PM','2021-10-18',400,100);
INSERT INTO flights VALUES
('5','JetBlue Airways','LGA','ATL','11:00 AM','1:00 PM','2021-10-19',400,130);
INSERT INTO flights VALUES
('6','Spirit Airlines','SJC','ATL','12:30 PM','9:30 PM','2021-10-19',650,140);
INSERT INTO flights VALUES
('7','WestJet','LGA','SJC','1:00 PM','4:00 PM','2021-10-19',700,100);
INSERT INTO flights VALUES
('8','Interjet','MIA','ORD','7:30 PM','9:30 PM','2021-10-19',350,125);
INSERT INTO flights VALUES
('9','Delta Airlines','JFK','ATL','8:00 AM','10:00 AM','2021-10-20',375,150);
INSERT INTO flights VALUES
('10','Delta Airlines','LAX','ATL','9:15 AM','6:15 PM','2021-10-20',700,110);
INSERT INTO flights VALUES
('11','Southwest Airlines','LAX','ORD','12:07 PM','7:07 PM','2021-10-20',600,95);
INSERT INTO flights VALUES
('12','United Airlines', 'MIA','ATL','3:35 PM','5:35 PM','2021-10-20',275,115);





DROP TABLE IF EXISTS accounts;
CREATE TABLE accounts (
	email char(150),
    fname char(100),
    lname char(100),
    password_user char(40),
    PRIMARY KEY(email)
)ENGINE=InnoDB;

insert into accounts values
('mmoss1@travelagency.com' , 'Mark' , 'Moss' , 'password1');
insert into accounts values
('asmith@travelagency.com','Aviva','Smith','password2');
insert into accounts values
('mscott22@gmail.com',	'Michael',	'Scott',	'password3');
insert into accounts values
('arthurread@gmail.com',	'Arthur',	'Read',	'password4');
insert into accounts values
('jwayne@gmail.com',	'John',	'Wayne',	'password5');
insert into accounts values 
('gburdell3@gmail.com',	'George',	'Burdell',	'password6');
insert into accounts values
('mj23@gmail.com',	'Michael',	'Jordan',	'password7');
insert into accounts values
('lebron6@gmail.com',	'Lebron',	'James',	'password8');
insert into accounts values
('msmith5@gmail.com',	'Michael',	'Smith',	'password9');
insert into accounts values
('ellie2@gmail.com',	'Ellie',	'Johnson',	'password10');
insert into accounts values
('scooper3@gmail.com',	'Sheldon',	'Cooper',	'password11');
insert into accounts values
('mgeller5@gmail.com',	'Monica',	'Geller',	'password12');
insert into accounts values
('cbing10@gmail.com',	'Chandler',	'Bing',	'password13');
insert into accounts values
('hwmit@gmail.com',	'Howard',	'Wolowitz',	'password14');
insert into accounts values
('swilson@gmail.com',	'Samantha',	'Wilson',	'password16');
insert into accounts values
('aray@tiktok.com',	'Addison',	'Ray',	'password17');
insert into accounts values
('cdemilio@tiktok.com',	'Charlie',	'Demilio',	'password18');
insert into accounts values
('bshelton@gmail.com',	'Blake',	'Shelton',	'password19');
insert into accounts values
('lbryan@gmail.com',	'Luke',	'Bryan',	'password20');
insert into accounts values
('tswift@gmail.com',	'Taylor',	'Swift',	'password21');
insert into accounts values
('jseinfeld@gmail.com',	'Jerry',	'Seinfeld',	'password22');
insert into accounts values
('maddiesmith@gmail.com',	'Madison',	'Smith',	'password23');
insert into accounts values
('johnthomas@gmail.com',	'John',	'Thomas',	'password24');
insert into accounts values
('boblee15@gmail.com',	'Bob',	'Lee',	'password25');

DROP TABLE IF EXISTS admins;
CREATE TABLE admins (
	email char(200),
    PRIMARY KEY(email),
	CONSTRAINT FOREIGN KEY(email) REFERENCES accounts(email)
)ENGINE=InnoDB;

insert into admins values
('mmoss1@travelagency.com');
insert into admins values
('asmith@travelagency.com');


DROP TABLE IF EXISTS clients;
CREATE TABLE clients (
	email char(150),
    phone_number double(10 , 0),
    PRIMARY KEY(email),
    UNIQUE KEY(phone_number),
	CONSTRAINT FOREIGN KEY(email) REFERENCES accounts(email)
)ENGINE=InnoDB;

INSERT INTO clients VALUES
('mscott22@gmail.com',	5551234567);
INSERT INTO clients VALUES
('arthurread@gmail.com', 5552345678);
INSERT INTO clients VALUES
('jwayne@gmail.com', 5553456789);
INSERT INTO clients VALUES
('gburdell3@gmail.com',5554567890);
INSERT INTO clients VALUES
('mj23@gmail.com', 5555678901);
INSERT INTO clients VALUES
('lebron6@gmail.com',5556789012);
INSERT INTO clients VALUES
('msmith5@gmail.com',5557890123);
INSERT INTO clients VALUES
('ellie2@gmail.com',5558901234);
INSERT INTO clients VALUES
('scooper3@gmail.com',6781234567);
INSERT INTO clients VALUES
('mgeller5@gmail.com',678234-5678);
INSERT INTO clients VALUES
('cbing10@gmail.com',6783456789);
INSERT INTO clients VALUES
('hwmit@gmail.com',	6784567890);
INSERT INTO clients VALUES
('swilson@gmail.com',7701234567);
INSERT INTO clients VALUES
('aray@tiktok.com',	7702345678);
INSERT INTO clients VALUES
('cdemilio@tiktok.com',	7703456789);
INSERT INTO clients VALUES
('bshelton@gmail.com', 7704567890);
INSERT INTO clients VALUES
('lbryan@gmail.com',7705678901);
INSERT INTO clients VALUES
('tswift@gmail.com',7706789012);
INSERT INTO clients VALUES
('jseinfeld@gmail.com',	7707890123);
INSERT INTO clients VALUES
('maddiesmith@gmail.com', 7708901234);
INSERT INTO clients VALUES
('johnthomas@gmail.com',4047705555);
INSERT INTO clients VALUES
('boblee15@gmail.com',4046785555);

DROP TABLE IF EXISTS owners;
CREATE TABLE owners (
	email char(200),
    PRIMARY KEY(email),
	CONSTRAINT FOREIGN KEY(email) REFERENCES clients(email)
)ENGINE=InnoDB;

INSERT INTO owners VALUES
('mscott22@gmail.com');
INSERT INTO owners VALUES
('arthurread@gmail.com');
INSERT INTO owners VALUES
('jwayne@gmail.com');
INSERT INTO owners VALUES
('gburdell3@gmail.com');
INSERT INTO owners VALUES
('mj23@gmail.com');
INSERT INTO owners VALUES
('lebron6@gmail.com');
INSERT INTO owners VALUES
('msmith5@gmail.com');
INSERT INTO owners VALUES
('ellie2@gmail.com');
INSERT INTO owners VALUES
('scooper3@gmail.com');
INSERT INTO owners VALUES
('mgeller5@gmail.com');
INSERT INTO owners VALUES
('cbing10@gmail.com');
INSERT INTO owners VALUES
('hwmit@gmail.com');


DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
	email char(200),
    cc_number double(16,0),
    cvv double(3 , 0),
    exp_date date,
    current_location char(100),
    UNIQUE KEY(cc_number),
    PRIMARY KEY(email),
	CONSTRAINT FOREIGN KEY(email) REFERENCES clients(email)
)ENGINE=InnoDB;

INSERT INTO customers VALUES
('scooper3@gmail.com',6518555974461663,551,'2024-02-01', null);
INSERT INTO customers VALUES
('mgeller5@gmail.com',2328567043101965,644,'2024-03-01', null);
INSERT INTO customers VALUES	
('cbing10@gmail.com',8387952398279291,201,'2023-02-01',null);
INSERT INTO customers VALUES	
('hwmit@gmail.com',	6558859698525299,102,'2023-04-01',null);
INSERT INTO customers VALUES	
('swilson@gmail.com',9383321241981836,455,'2022-08-01',null);
INSERT INTO customers VALUES	
('aray@tiktok.com',3110266979495605,744,'2022-08-01',null);
INSERT INTO customers VALUES	
('cdemilio@tiktok.com',2272355540784744,606,'2025-02-01',null);
INSERT INTO customers VALUES	
('bshelton@gmail.com',9276763978834273,862,'2023-09-01', null);
INSERT INTO customers VALUES	
('lbryan@gmail.com',4652372688643798,258,'2023-05-01',null);
INSERT INTO customers VALUES	
('tswift@gmail.com',5478842044367471,857,'2024-12-1',null);
INSERT INTO customers VALUES	
('jseinfeld@gmail.com',3616897712963372,295,'2022-06-01',null);
INSERT INTO customers VALUES	
('maddiesmith@gmail.com',9954569863556952,794,'2022-07-01',null);
INSERT INTO customers VALUES	
('johnthomas@gmail.com',7580327437245356,269,'2025-10-01',null);
INSERT INTO customers VALUES	
('boblee15@gmail.com',7907351371614248,858,'2025-11-01',null);	


DROP TABLE IF EXISTS properties;
CREATE TABLE properties (
	property_name char(50),
	email char(200),
    description_property varchar(300),
    capacity double(5 , 0),
    cost_pernight_per_person float,
	street char(60) NOT NULL,
    city char(20) NOT NULL,
    state char(3) NOT NULL,
    zip_code decimal(5 , 0) NOT NULL,
    UNIQUE KEY(street , city , state , zip_code),
    PRIMARY KEY(email , property_name),
	CONSTRAINT FOREIGN KEY(email) REFERENCES owners(email)
)ENGINE=InnoDB;

INSERT INTO properties VALUES
('Atlanta Great Property','scooper3@gmail.com','This is right in the middle of Atlanta near many attractions!',4,600,'2nd St','ATL','GA','30008');
INSERT INTO properties VALUES
('House near Georgia Tech','gburdell3@gmail.com','Super close to bobby dodde stadium!',3,275,'North Ave','ATL','GA','30008');
INSERT INTO properties VALUES
('New York City Property','cbing10@gmail.com','A view of the whole city. Great property!',2,750,'123 Main St','NYC','NY','10008');
INSERT INTO properties VALUES
('Statue of Libery Property','mgeller5@gmail.com','You can see the statue of liberty from the porch',5,1000,'1st St','NYC','NY','10009');
INSERT INTO properties VALUES
('Los Angeles Property','arthurread@gmail.com',NUll,3,700,'10th St','LA','CA','90008');
INSERT INTO properties VALUES
('LA Kings House','arthurread@gmail.com','This house is super close to the LA kinds stadium!',4,750,'Kings St','La','CA','90011');
INSERT INTO properties VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','Huge house that can sleep 12 people. Totally worth it!',12,900,'Golden Bridge Pkwt','San Jose','CA','90001');
INSERT INTO properties VALUES
('LA Lakers Property','lebron6@gmail.com','This house is right near the LA lakers stadium. You might even meet Lebron James!',4,850,'Lebron Ave','LA','CA','90011');
INSERT INTO properties VALUES
('Chicago Blackhawks House','hwmit@gmail.com','This is a great property!',3,775,'Blackhawks St','Chicago','IL','60176');
INSERT INTO properties VALUES
('Chicago Romantic Getaway','mj23@gmail.com','This is a great property!',2,1050,'23rd Main St','Chicago','IL','60176');
INSERT INTO properties VALUES
('Beautiful Beach Property','msmith5@gmail.com','You can walk out of the house and be on the beach!',2,975,'456 Beach Ave','Miami','FL','33101');
INSERT INTO properties VALUES
('Family Beach House','ellie2@gmail.com','You can literally walk onto the beach and see it from the patio!',6,850,'1132 Beach Ave','Miami','FL','33101');
INSERT INTO properties VALUES
('Texas Roadhouse','mscott22@gmail.com','This property is right in the center of Dallas, Texas!',3,450,'17th Street','Dallas','TX','75043');
INSERT INTO properties VALUES
('Texas Longhorns House','mscott22@gmail.com','You can walk to the longhorns stadium from here!',10,600,'1125 Longhorns Way','Dallas','TX','75001');

DROP TABLE IF EXISTS customer_ratings;
CREATE TABLE customer_ratings (
	owner_email char(200),
    customer_email char(200),
    score decimal(1,0)
    Check(score BETWEEN 0 AND 5),
    PRIMARY KEY(owner_email , customer_email),
	CONSTRAINT FOREIGN KEY(owner_email) REFERENCES owners(email),
    CONSTRAINT FOREIGN KEY(customer_email) REFERENCES customers(email)
)ENGINE=InnoDB;

INSERT INTO customer_ratings VALUES
('gburdell3@gmail.com' , 'swilson@gmail.com' , 5);
INSERT INTO customer_ratings VALUES
('cbing10@gmail.com' , 'aray@tiktok.com' , 5);
INSERT INTO customer_ratings VALUES
('mgeller5@gmail.com' , 'bshelton@gmail.com' , 3);
INSERT INTO customer_ratings VALUES
('arthurread@gmail.com', 'lbryan@gmail.com', 4);
INSERT INTO customer_ratings VALUES
('arthurread@gmail.com' , 'tswift@gmail.com' , 4);
INSERT INTO customer_ratings VALUES
('lebron6@gmail.com', 'jseinfeld@gmail.com', 1);
INSERT INTO customer_ratings VALUES
('hwmit@gmail.com' , 'maddiesmith@gmail.com' , 2);


DROP TABLE IF EXISTS owner_ratings;
CREATE TABLE owner_ratings (
	owner_email char(200),
    customer_email char(200),
    score decimal(1,0)
    Check(score BETWEEN 0 AND 5),
    PRIMARY KEY(owner_email , customer_email),
	CONSTRAINT FOREIGN KEY(owner_email) REFERENCES owners(email),
    CONSTRAINT FOREIGN KEY(customer_email) REFERENCES customers(email)
)ENGINE=InnoDB;

INSERT INTO owner_ratings VALUES
('gburdell3@gmail.com' , 'swilson@gmail.com' , 5);
INSERT INTO owner_ratings VALUES
('cbing10@gmail.com' , 'aray@tiktok.com' , 5);
INSERT INTO owner_ratings VALUES
('mgeller5@gmail.com' , 'bshelton@gmail.com' , 4);
INSERT INTO owner_ratings VALUES
('arthurread@gmail.com', 'lbryan@gmail.com', 4);
INSERT INTO owner_ratings VALUES
('arthurread@gmail.com' , 'tswift@gmail.com' , 3);
INSERT INTO owner_ratings VALUES
('lebron6@gmail.com', 'jseinfeld@gmail.com', 2);
INSERT INTO owner_ratings VALUES
('hwmit@gmail.com' , 'maddiesmith@gmail.com' , 5);


DROP TABLE IF EXISTS is_close_to;
CREATE TABLE is_close_to (
	property_name char(30),
	email char(200),
    airport_id char(3),
    distance decimal(2,0),
    PRIMARY KEY(email , property_name ,airport_id),
	CONSTRAINT FOREIGN KEY(email , property_name) REFERENCES properties(email , property_name),
    CONSTRAINT FOREIGN KEY(airport_id) REFERENCES airport(airport_id)
)ENGINE=InnoDB;

INSERT INTO is_close_to VALUES
('Atlanta Great Property','scooper3@gmail.com','ATL',12);
INSERT INTO is_close_to VALUES
('House near Georgia Tech','gburdell3@gmail.com','ATL',7);
INSERT INTO is_close_to VALUES
('New York City Property','cbing10@gmail.com','JFK',10);
INSERT INTO is_close_to VALUES
('Statue of Libery Property','mgeller5@gmail.com','JFK',8);
INSERT INTO is_close_to VALUES
('New York City Property','cbing10@gmail.com','LGA',25);
INSERT INTO is_close_to VALUES
('Statue of Libery Property','mgeller5@gmail.com','LGA',19);
INSERT INTO is_close_to VALUES
('Los Angeles Property','arthurread@gmail.com','LAX',9);
INSERT INTO is_close_to VALUES
('LA Kings House','arthurread@gmail.com','LAX',12);
INSERT INTO is_close_to VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','SJC',8);
INSERT INTO is_close_to VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','LAX',30);
INSERT INTO is_close_to VALUES
('LA Lakers Property','lebron6@gmail.com','LAX',6);
INSERT INTO is_close_to VALUES
('Chicago Blackhawks House','hwmit@gmail.com','ORD',11);
INSERT INTO is_close_to VALUES
('Chicago Romantic Getaway','mj23@gmail.com','ORD',13);
INSERT INTO is_close_to VALUES
('Beautiful Beach Property','msmith5@gmail.com','MIA',21);
INSERT INTO is_close_to VALUES
('Family Beach House','ellie2@gmail.com','MIA',19);
INSERT INTO is_close_to VALUES
('Texas Roadhouse','mscott22@gmail.com','DFW',8);
INSERT INTO is_close_to VALUES
('Texas Longhorns House','mscott22@gmail.com','DFW',17);


DROP TABLE IF EXISTS reserve;
CREATE TABLE reserve (
	property_name char(30),
	property_email char(200),
    customer_email char(200),
    start_date date,
    end_date date,
    guests_num char(10),
    PRIMARY KEY(property_email, property_name , customer_email),
	CONSTRAINT FOREIGN KEY(property_email ,property_name) REFERENCES properties(email , property_name),
    CONSTRAINT FOREIGN KEY(customer_email) REFERENCES customers(email)
)ENGINE=InnoDB;
INSERT INTO reserve VALUES
('House near Georgia Tech','gburdell3@gmail.com','swilson@gmail.com','2021-10-19','2021-10-25','3');
INSERT INTO reserve VALUES
('New York City Property','cbing10@gmail.com','aray@tiktok.com','2021-10-18','2021-10-23','2');
INSERT INTO reserve VALUES
('New York City Property','cbing10@gmail.com','cdemilio@tiktok.com','2021-10-24','2021-10-30','2');
INSERT INTO reserve VALUES
('Statue of Libery Property','mgeller5@gmail.com','bshelton@gmail.com','2021-10-28','2021-10-22','4');
INSERT INTO reserve VALUES
('Los Angeles Property','arthurread@gmail.com','lbryan@gmail.com','2021-10-19','2021-10-25', '2');
INSERT INTO reserve VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','tswift@gmail.com','2021-10-19','2021-10-22','10');
INSERT INTO reserve VALUES
('LA Lakers Property','lebron6@gmail.com','jseinfeld@gmail.com','2021-10-19','2021-10-24','4');
INSERT INTO reserve VALUES
('Chicago Blackhawks House','hwmit@gmail.com','maddiesmith@gmail.com','2021-10-19','2021-10-23','2');
INSERT INTO reserve VALUES
('Chicago Romantic Getaway','mj23@gmail.com','aray@tiktok.com','2021-11-1','2021-11-7','2');
INSERT INTO reserve VALUES
('Beautiful Beach Property','msmith5@gmail.com','cbing10@gmail.com','2021-10-18','2021-10-25','2');
INSERT INTO reserve VALUES
('Family Beach House','ellie2@gmail.com','hwmit@gmail.com','2021-10-18','2021-10-28','5');



DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
    property_name char(30),
    property_email char(200),
    customer_email char(200),
    content varchar(500),
    score decimal(1,0)
    Check(score BETWEEN 0 AND 5),
    PRIMARY KEY(property_email ,property_name, customer_email),
	CONSTRAINT FOREIGN KEY(property_email , property_name) REFERENCES properties(email , property_name),
    CONSTRAINT FOREIGN KEY(customer_email) REFERENCES customers(email)
)ENGINE=InnoDB;

INSERT INTO reviews VALUES
('House near Georgia Tech','gburdell3@gmail.com','swilson@gmail.com',"This was so much fun. I went and saw the coke factory, the falcons play, GT play, and the Georgia aquarium. Great time! Would highly recommend!",5);
INSERT INTO reviews VALUES
('New York City Property','cbing10@gmail.com','aray@tiktok.com',"This was the best 5 days ever! I saw so much of NYC!",5);
INSERT INTO reviews VALUES
('Statue of Libery Property','mgeller5@gmail.com','bshelton@gmail.com',"This was truly an excellent experience. I really could see the Statue of Liberty from the property!",4);
INSERT INTO reviews VALUES
('Los Angeles Property','arthurread@gmail.com','lbryan@gmail.com',"I had an excellent time!",4);
INSERT INTO reviews VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','tswift@gmail.com',"We had a great time, but the house wasn't fully cleaned when we arrived",3);
INSERT INTO reviews VALUES
('LA Lakers Property','lebron6@gmail.com','jseinfeld@gmail.com',"I was disappointed that I did not meet lebron james",2);
INSERT INTO reviews VALUES
('Chicago Blackhawks House','hwmit@gmail.com','maddiesmith@gmail.com',"This was awesome! I met one player on the chicago blackhawks!",5);


DROP TABLE IF EXISTS bookings;
CREATE TABLE bookings(
	customer_email char(200),
	fligh_number decimal(5 , 0),
	name_airlines char(70),
    num_seats decimal(5 , 0),
    PRIMARY KEY(customer_email , name_airlines ,fligh_number),
	CONSTRAINT FOREIGN KEY(customer_email) REFERENCES customers(email),
	CONSTRAINT FOREIGN KEY(name_airlines , fligh_number) REFERENCES flights(name_airlines , fligh_number)
)ENGINE=InnoDB;

INSERT INTO bookings VALUES
('swilson@gmail.com',	5,	'JetBlue Airways',	3);
INSERT INTO bookings VALUES
('aray@tiktok.com',	1,	'Delta Airlines',	2);
INSERT INTO bookings VALUES
('bshelton@gmail.com',	4,	'United Airlines',	4);
INSERT INTO bookings VALUES
('lbryan@gmail.com',	7,	'WestJet',	2);
INSERT INTO bookings VALUES
('tswift@gmail.com',	7,	'WestJet',	2);
INSERT INTO bookings VALUES
('jseinfeld@gmail.com',	7,	'WestJet',	4);
INSERT INTO bookings VALUES
('maddiesmith@gmail.com',	8,	'Interjet',	2);
INSERT INTO bookings VALUES
('cbing10@gmail.com',	2,	'Southwest Airlines',	2);
INSERT INTO bookings VALUES
('hwmit@gmail.com',	2,	'Southwest Airlines',	5);



DROP TABLE IF EXISTS amenities;
CREATE TABLE amenities (
	property_name char(30),
	property_email char(200),
    amenities_description char(200),
    PRIMARY KEY(property_email , property_name , amenities_description),
	CONSTRAINT FOREIGN KEY(property_email , property_name ) REFERENCES properties(email , property_name)
)ENGINE=InnoDB;

INSERT INTO amenities VALUES
('Atlanta Great Property','scooper3@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Atlanta Great Property','scooper3@gmail.com','Pets allowed');
INSERT INTO amenities VALUES
('Atlanta Great Property','scooper3@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Atlanta Great Property','scooper3@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('House near Georgia Tech','gburdell3@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('House near Georgia Tech','gburdell3@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('House near Georgia Tech','gburdell3@gmail.com','Full Kitchen');
INSERT INTO amenities VALUES
('New York City Property','cbing10@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('New York City Property','cbing10@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Statue of Libery Property','mgeller5@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Statue of Libery Property','mgeller5@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Los Angeles Property','arthurread@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Los Angeles Property','arthurread@gmail.com','Pets allowed');
INSERT INTO amenities VALUES
('Los Angeles Property','arthurread@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('LA Kings House','arthurread@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('LA Kings House','arthurread@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('LA Kings House','arthurread@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('LA Kings House','arthurread@gmail.com','Full Kitchen');
INSERT INTO amenities VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','Pets allowed');
INSERT INTO amenities VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('Beautiful San Jose Mansion','arthurread@gmail.com','Full Kitchen');
INSERT INTO amenities VALUES
('LA Lakers Property','lebron6@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('LA Lakers Property','lebron6@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('LA Lakers Property','lebron6@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('LA Lakers Property','lebron6@gmail.com','Full Kitchen');
INSERT INTO amenities VALUES
('Chicago Blackhawks House','hwmit@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Chicago Blackhawks House','hwmit@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Chicago Blackhawks House','hwmit@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('Chicago Blackhawks House','hwmit@gmail.com','Full Kitchen');
INSERT INTO amenities VALUES
('Chicago Romantic Getaway','mj23@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Chicago Romantic Getaway','mj23@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Beautiful Beach Property','msmith5@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Beautiful Beach Property','msmith5@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Beautiful Beach Property','msmith5@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('Family Beach House','ellie2@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Family Beach House','ellie2@gmail.com','Pets allowed');
INSERT INTO amenities VALUES
('Family Beach House','ellie2@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Family Beach House','ellie2@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('Family Beach House','ellie2@gmail.com','Full Kitchen');
INSERT INTO amenities VALUES
('Texas Roadhouse','mscott22@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Texas Roadhouse','mscott22@gmail.com','Pets allowed');
INSERT INTO amenities VALUES
('Texas Roadhouse','mscott22@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Texas Roadhouse','mscott22@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('Texas Longhorns House','mscott22@gmail.com','A/C & Heating');
INSERT INTO amenities VALUES
('Texas Longhorns House','mscott22@gmail.com','Pets allowed');
INSERT INTO amenities VALUES
('Texas Longhorns House','mscott22@gmail.com','Wifi & TV');
INSERT INTO amenities VALUES
('Texas Longhorns House','mscott22@gmail.com','Washer and Dryer');
INSERT INTO amenities VALUES
('Texas Longhorns House','mscott22@gmail.com','Full Kitchen');



DROP TABLE IF EXISTS attractions;
CREATE TABLE attractions (
    airport_id char(20),
    attraction_description char(200),
    PRIMARY KEY(airport_id ,attraction_description),
    CONSTRAINT FOREIGN KEY(airport_id) REFERENCES airport(airport_id)
)ENGINE=InnoDB;

INSERT INTO attractions VALUES
('ATL',	'The Coke Factory');
INSERT INTO attractions VALUES
('ATL',	'The Georgia Aquarium');
INSERT INTO attractions VALUES
('JFK',	'The Statue of Liberty');
INSERT INTO attractions VALUES
('JFK',	'The Empire State Building');
INSERT INTO attractions VALUES
('LGA',	'The Statue of Liberty');
INSERT INTO attractions VALUES
('LGA',	'The Empire State Building');
INSERT INTO attractions VALUES
('LAX',	'Lost Angeles Lakers Stadium');
INSERT INTO attractions VALUES
('LAX',	'Los Angeles Kings Stadium');
INSERT INTO attractions VALUES
('SJC',	'Winchester Mystery House');
INSERT INTO attractions VALUES
('SJC',	'San Jose Earthquakes Soccer Team');
INSERT INTO attractions VALUES
('ORD',	'Chicago Blackhawks Stadium');
INSERT INTO attractions VALUES
('ORD',	'Chicago Bulls Stadium');
INSERT INTO attractions VALUES
('MIA',	'Crandon Park Beach');
INSERT INTO attractions VALUES
('MIA',	'Miami Heat Basketball Stadium');
INSERT INTO attractions VALUES
('DFW',	'Texas Longhorns Stadium');
INSERT INTO attractions VALUES
('DFW',	'The Original Texas Roadhouse');

