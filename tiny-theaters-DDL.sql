drop database if exists tiny_theaters;
create database tiny_theaters;
use tiny_theaters;


create table theater (
	theater_id int primary key
);

create table performance (
	performance_id int primary key
);

create table customer (
	customer_id int primary key
);

create table reservation (
	reservation_id int primary key
);

create table address (
	address_id int primary key
);

create table email (
	email_id int primary key
);

create table phone (
	phone_id int primary key
);

create table theater_seat (
	theater_seat_id int primary key
);


