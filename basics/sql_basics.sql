/*
########################  Basic concepts  ########################
*/

--------------------------------- Order of execution ---------------------------------

select a.identifier, count(*) as total_count
from table_A a
    join table_B b on b.id = a.id
where a.something = b.something
group by a.identifier
order by total_count;

-- SLIDES!

/*
########################  NULL!!  ########################
*/

--------------------------------- Tables for NULL ---------------------------------

create table if not exists country(
    country_id serial primary key,
    country_name text
);

---------------------------------

create table if not exists person(
    person_id int primary key,
    jmbg text constraint uq_identifier unique,
    person_name text,
    country_id int references country(country_id),
    salary numeric check(salary >= 800)
);

--------------------------------- Sample data for country ---------------------------------

insert into country (country_name)
values ('Bosnia and Herzegovina'),
       ('Uzbekistan'),
       ('Palestine');

--------------------------------- Sample data for person ---------------------------------

insert into person(person_id, jmbg, person_name, country_id, salary)
values (1, '129hffbv0vqpas', 'Edis', 1,  800),
       (2, '09vnksadvj89', 'Farhad',  2, 1500),
       (3, '12q84ywvuhjffg', 'Abdullah', 3,  2000);

---------------------------------

update person set
    person_id = null
where person_name = 'Edis';

---------------------------------

update person set
    jmbg = null
where person_name = 'Edis';

---------------------------------

update person set
    jmbg = null;

---------------------------------

update person set
    country_id = null
where person_name = 'Edis';

---------------------------------

update person set
    salary = null
where person_name = 'Edis';

---------------------------------

update person set
    salary = 10000,
    country_id = 1,
    jmbg = 'bestIdentifier'
where person_name = 'Edis';

---------------------------------

select null
union
select null;

---------------------------------

create table if not exists edis(
    left_leg text,
    left_arm text,
    head text not null,
    right_arm text,
    right_leg text
);

--------------------------------------------------------------------

create table if not exists the_void(
    left_leg text default null,
    left_arm text default null,
    head text default null,
    right_arm text default null,
    right_leg text default null
);
insert into edis values(null, null, 'Head', null, null);
insert into the_void values(null, null, null, null, null);

--------------------------------------------------------------------

select *
from edis e
         join the_void tv on e.left_arm = tv.left_arm;

---------------------------------

select left_arm
from edis

intersect

select left_arm
from the_void;

---------------------------------

select *
from edis

intersect

select *
from the_void;

---------------------------------

select *
from edis

except

select *
from the_void;

---------------------------------

select *
from edis
where edis.left_arm in (select the_void.left_arm from the_void);

---------------------------------

select *
from edis
where edis.left_arm not in (select the_void.left_arm from the_void);


/*
########################  New SQL Concepts  ########################
*/

--------------------------------- Subqueries vs CTEs ---------------------------------

explain analyze
with base_1 as (
    select 1
),
base_2 as (
    select 1
),
base_3 as (
    select 1
)
select *
from base_1
    join base_2 b2a on b2a = base_1
    join base_2 b2b on b2b = base_1
    join base_3 on base_3 = base_1
where base_1 in (select base_3 from base_3);

explain analyze
select *
from (values (1)) base_1
    join (values (1)) b2a on b2a = base_1
    join (values (1)) b2b on b2b = base_1
    join (values (1)) base_3 on base_3 = base_1
where base_1 in (select base_3 from (values (1)) base_3);

/*
########################  DON'T DO THIS!!!!!!  ########################
*/

create table testing_new_shit (
    some_timestamp timestamptz,
    some_char char(5)
);

insert into testing_new_shit(some_timestamp, some_char)
values  (now(), 'some'),
        (date_trunc('day',now()),'hello');

-- explain analyze
select *
from testing_new_shit
where some_timestamp between '2025-04-09' and '2025-04-19';

---------------------------------

select 1
where 1 in (1,null);

select 1
where 1 not in (2,null);

select 1
where not (1 in (2,null));

---------------------------------





