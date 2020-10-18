use tiny_theaters;

-- Find all performances in the last quarter of 2021 (Oct. 1, 2021 - Dec. 31 2021).
select
	tp.theater_performance_id,
    tp.`date`,
    t.`name` as theater_name,
    p.performance_title
from theater_performance tp
inner join theater t on t.theater_id = tp.theater_id
inner join performance p on p.performance_id = tp.performance_id
where tp.`date` between '2021-10-01' and '2021-12-31';

-- List customers without duplication.
select
	*
from customer;

-- Find all customers without a .com email address.
select
	c.customer_id,
    concat(c.first_name, " ", c.last_name) as full_name,
    e.email_address
from customer c
inner join email e on e.email_id = c.email_id
where e.email_address not like "%.com";

-- Find the three cheapest shows.
select
	t.`name`,
    p.performance_title,
    tp.cost
from theater_performance tp
inner join theater t on t.theater_id = tp.theater_id
inner join performance p on p.performance_id = tp.performance_id
order by cost
limit 3;

-- List customers and the show they're attending with no duplication.
select
	distinct r.customer_id,
    concat(c.first_name, " ", c.last_name) as full_name,
    r.theater_performance_id
from reservation r
inner join customer c on c.customer_id = r.customer_id
order by customer_id, theater_performance_id;

-- List customer, show, theater, and seat number in one query.
select
	concat(c.first_name, " ", c.last_name) as customer_full_name,
    p.performance_title,
    t.`name`,
    s.seat_name
from reservation r
inner join customer c on c.customer_id = r.customer_id
inner join theater_performance tp on tp.theater_performance_id = r.theater_performance_id
inner join theater t on t.theater_id = tp.theater_id
inner join performance p on p.performance_id = tp.performance_id
inner join seat s on s.seat_id = r.seat_id
order by reservation_id;
	
-- Find customers without an address.
select
	c.customer_id,
    concat(c.first_name, " ", c.last_name) as customer_full_name,
    c.address_id,
    a.home_address
from customer c
left outer join address a on a.address_id = c.address_id
where a.home_address = "";

-- Recreate the spreadsheet data with a single query.
select
	customer_first,
    customer_last,
    customer_email,
    customer_phone,
    customer_address,
    seat,
    `show`,
    ticket_price,
    `date`,
    theater,
    theater_address,
    theater_phone,
    theater_email
from excel_data;

-- Count total tickets purchased per customer.
select
	r.customer_id,
    concat(c.first_name, " ", c.last_name) as customer_full_name,
	count(r.reservation_id) as number_of_tickets_purchased
from reservation r
inner join customer c on c.customer_id = r.customer_id
group by r.customer_id;

-- Calculate the total revenue per show based on tickets sold.
select
	p.performance_title,
	count(r.reservation_id) as number_of_tickets_purchased,
    tp.cost as ticket_price_$,
    count(r.reservation_id) * tp.cost as performance_revenue_$
from reservation r
inner join theater_performance tp on tp.theater_performance_id = r.theater_performance_id
inner join performance p on p.performance_id = tp.performance_id
group by p.performance_title, tp.cost;

-- Calculate the total revenue per theater based on tickets sold.
select
	t.`name` as theater_name,
	count(r.reservation_id) as number_of_tickets_purchased,
    tp.cost as ticket_price_$,
    tp.cost * count(r.reservation_id) as theater_revenue_$
from reservation r
inner join theater_performance tp on tp.theater_performance_id = r.theater_performance_id
inner join theater t on t.theater_id = tp.theater_id
group by t.`name`, tp.cost;

-- Who is the biggest supporter of RCTTC? Who spent the most in 2021?
select
	c.customer_id,
	count(r.reservation_id) as number_of_tickets_purchased,
    tp.cost as ticket_price_$,
    count(r.reservation_id) * tp.cost as customer_spent_$
from reservation r
inner join customer c on c.customer_id = r.customer_id
inner join theater_performance tp on tp.theater_performance_id = r.theater_performance_id
inner join performance p on p.performance_id = tp.performance_id
where year(tp.`date`) = '2021' 
group by r.customer_id, tp.cost
order by r.customer_id;


