drop database if exists tiny_theaters;
create database tiny_theaters;
use tiny_theaters;

create table seat (
	seat_id int primary key auto_increment,
    seat_name varchar(5) not null
);

create table address (
	address_id int primary key auto_increment,
    home_address varchar(45) not null
);

create table email (
	email_id int primary key auto_increment,
    email_address varchar(75) not null
);

create table phone (
	phone_id int primary key auto_increment,
    phone_number varchar(15) not null
);

create table performance (
	performance_id int primary key auto_increment,
    performance_title varchar(45) not null
);

create table theater (
	theater_id int primary key auto_increment,
    `name` varchar(45) not null,
    address_id int not null,
    email_id int not null,
    phone_id int not null,
    seat_id int not null,
    constraint fk_theater_address_id
		foreign key (address_id)
        references address(address_id),
	constraint fk_theater_email_id
		foreign key (email_id)
        references email(email_id),
	constraint fk_theater_phone_id
		foreign key (phone_id)
        references phone(phone_id),
	constraint fk_theater_seat_id
		foreign key (seat_id)
        references seat(seat_id),
	constraint uq_name_email
		unique (`name`, email_id)
);

create table customer (
	customer_id int primary key auto_increment,
    first_name varchar(45) not null,
    last_name varchar(45) not null,
    address_id int null,
    email_id int not null,
    phone_id int null,
    constraint fk_customer_address_id
		foreign key (address_id)
        references address(address_id),
	constraint fk_customer_email_id
		foreign key (email_id)
        references email(email_id),
	constraint fk_customer_phone_id
		foreign key (phone_id)
        references phone(phone_id),
	constraint uq_last_name_email
		unique (last_name, email_id)
);

create table theater_performance (
	theater_performance_id int primary key auto_increment,
	theater_id int not null,
    performance_id int not null,
    `date` date not null,
    cost decimal(4,2) not null,
    constraint fk_theater_id
		foreign key (theater_id)
        references theater(theater_id),
	constraint fk_performance_id
		foreign key (performance_id)
        references performance(performance_id),
	constraint uq_theater_performance_date
		unique (theater_id, performance_id, `date`)
    );
    
    create table reservation (
	reservation_id int primary key auto_increment,
    theater_performance_id int not null,
    customer_id int not null,
    seat_id int not null,
    constraint fk_reservation_theater_performance_id
		foreign key (theater_performance_id)
        references theater_performance(theater_performance_id),
	constraint fk_reservation_customer_id
		foreign key (customer_id)
        references customer(customer_id),
	constraint fk_reservation_seat_id
		foreign key (seat_id)
        references seat(seat_id),
	constraint uq_theater_performance_customer_seat
		unique (theater_performance_id, customer_id, seat_id)
);





