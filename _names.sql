-- In the Analyzing American Baby Name Trends project, you'll study data provided by the 
--U.S. Social Security Administration containing first names, 
--which were given to over 5,000 American babies each year for the period of 101 years. 
--The main goal is to understand how American baby name tastes changed by investigating trends of popularity. 
--In particular, you're going to discover:

-- Classic American names for over 100 years
-- The type of popularity for each name: timeless vs. trendy
-- The top 10 female names
-- The most popular female name ending in "a" since 2015
--The most popular male names by year
-- The most popular male name for the largest number of years
-- For this advanced project, you can find helpful the Data Manipulation in SQL course.


-- Create a database that will house the table that has names
create database people_names

-- Creating a table for people details

create table _names (
	year int,  -- take the integer data type as the values dont span to over a million
	first_name text, -- this is byte senstive does not 
	gender text, -- for byte reasons
	num int 
)

-- Copying data into the table
copy _names
from 'C:\Users\KEVIN\Desktop\_names\usa_baby_names.csv'
with (format csv, header)

-- View the top 5 rows of the dataset
select *
from _names
limit 5

-- confirm if the names span to 101 years
select
max(year) - min(year) as year_duration
from _names


--The type of popularity for each name: timeless vs. trendy

select 
	first_name,
	count(first_name)
from _names
group by first_name
having count(first_name) >= 100
order by  count(first_name) desc --, year desc

-- Most common names that have been used over and over include.
-- 547 unique names across
	-- Elizabeth
	-- Charles
	-- James
	-- Thomas
	-- William
	-- David
	-- Joseph
	-- John
-- there names that are pretty unique names that have been used less than 5 times for the entire period
-- Selected unique names include - Jocelyn peyton

-- Timeless trendy

select 
	first_name,
	case 
	when count(first_name)>= 10 then 'timeless'
	else 'trendy'
	end as classification
from _names
group by first_name
select 
	first_name,
	count(first_name)
from _names
group by first_name
-- having count(first_name) >= 100
--order by  count(first_name) desc

-- timelessness
-- Subquerying, Nesting a query inside another query
select 
	distinct(year)
from _names
where first_name in (select
	first_name
from (select 
	first_name,
	count(first_name)
from _names
group by first_name))


select
	first_name
from (select 
	first_name,
	count(first_name)
from _names
group by first_name)

-- Top 10 Female names
select 
	first_name,
	count(first_name)
from _names
where gender ='F'
group by first_name
order by count(first_name) desc
limit 10

-- Top 10 names include
	-- Elizabeth, Mary, Patricia, Maria, Rebecca, Anna, Katherine, Barbara, Margaret, Jennifer
	
-- The most popular female name ending in "a" since 2015

select 
	first_name
from _names
where first_name like '%a' and year = 2015 and gender = 'F'

-- 17 names with ending character a

-- Most popular name male gender

select
	first_name,
	year,
	count(first_name)
from _names
where gender = 'M'
group by first_name, year
order by count(first_name) desc

-- 

select 
	first_name,
	count(first_name)
from _names
where gender = 'M' and year = 1920
group by first_name
order by count(first_name)

--  The most popular male name for the largest number of years

select 
	--year,
	first_name,
	count(first_name)
from _names
where gender  = 'M'
group by first_name
order by count(first_name) desc
-- 240 names have used again and but top 7 names are 
-- David, James, Charles, Joseph, William, John, Thomas


