use sakila
;
select first_name, last_name from actor
;
select upper(concat(first_name, ' ', last_name)) as 'Actor Name' from actor
;
select actor_id, first_name, last_name from actor
where first_name = "Joe"
;
select actor_id, first_name, last_name from actor
where last_name like "%GEN%"
;
select actor_id, last_name, first_name from actor
where last_name like "%LI%"
;
select country_id, country from country
where country in ('Afghanistan', 'Bangladesh', 'China')
;
alter table actor
add column middle_name varchar(25) after first_name
;
alter table actor
drop column middle_name
;
select last_name, count(*) as 'Number of Actors'
from actor group by last_name having count(*) >=2
;
update actor 
set first_name = 'HARPO'
where first_name = "Groucho" and last_name = "Williams"
;
update actor
set first_name = 'GROUCHO'
where actor_id = 172
;
describe sakila.address
;
select first_name, last_name, address
from staff s
join address a
on s.address_id = a.address_id
;
select payment.staff_id, staff.first_name, staff.last_name, payment.amount, payment.payment_date
from staff inner join payment on
staff.staff_id = payment.staff_id and payment_date like '2005-08%'
;
select f.title as 'Film Title', count(fa.actor_id) as 'Number of Actors'
from film_actor fa
inner join film f on fa.film_id = f.film_id
group by f.title
;
select title, (
select count(*) from inventory
where film.film_id = inventory.film_id
) as 'Number of Copies'
from film
where title = "Hunchback Impossible"
;
select last_name, first_name, sum(amount) as 'Total Paid'
from sakila.customer c, sakila.payment p
where c.customer_id = p.customer_id
group by last_name, first_name
order by last_name, first_name
;
select title
from sakila.film f, sakila.language l
where f.language_id = l.language_id and l.name like '%ENGLISH%' and (f.title like 'Q%' or f.title like 'K%')
order by title asc
;
select distinct concat(last_name,', ', first_name)
from sakila.film f, sakila.film_actor fa, sakila.actor a
where f.film_id = fa.film_id and fa.actor_id = a.actor_id and f.title like 'Alone Trip'
;
select cus.first_name, cus.last_name, cus.email 
from customer cus
join address a 
on (cus.address_id = a.address_id)
join city cty
on (cty.city_id = a.city_id)
join country
on (country.country_id = cty.country_id)
where country.country= 'Canada'
;
select title, description 
from film f, film_category fc, category c
where c.category_id = fc.category_id and f.film_id = fc.film_id and c.category_id in (2, 3, 8)
;
select f.title, count(rental_id) as 'Times Rented'
from rental r
join inventory i
on (r.inventory_id = i.inventory_id)
join film f
on (i.film_id = f.film_id)
group by f.title
order by `Times Rented` desc
;
select s.store_id, sum(amount) as 'Revenue'
from payment p
join rental r
on (p.rental_id = r.rental_id)
join inventory i
on (i.inventory_id = r.inventory_id)
join store s
on (s.store_id = i.store_id)
group by s.store_id
;
select s.store_id, cty.city, country.country 
from store s
join address a 
on (s.address_id = a.address_id)
join city cty
on (cty.city_id = a.city_id)
join country
on (country.country_id = cty.country_id)
;
select c.name as 'Genre', sum(p.amount) as 'Gross' 
from category c
join film_category fc 
on (c.category_id=fc.category_id)
join inventory i 
on (fc.film_id=i.film_id)
join rental r 
on (i.inventory_id=r.inventory_id)
join payment p 
on (r.rental_id=p.rental_id)
group by c.name order by Gross desc limit 5 
;
create view genre_revenue as
select c.name as 'Genre', sum(p.amount) as 'Gross' 
from category c
join film_category fc 
on (c.category_id=fc.category_id)
join inventory i 
on (fc.film_id=i.film_id)
join rental r 
on (i.inventory_id=r.inventory_id)
join payment p 
on (r.rental_id=p.rental_id)
group by c.name order by Gross desc limit 5
;
select * from genre_revenue
;
drop view genre_revenue
;













