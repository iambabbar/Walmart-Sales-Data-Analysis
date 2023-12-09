CREATE DATABASE IF NOT EXISTS salesdatawalmart;

Create table if not exists sales(
invoice_id varchar(30) not null primary key,
branch varchar(5) not null,
city varchar(30) not null,
customer_type varchar(30) not null,
gender varchar(30) not null,
product_line varchar(100) not null,
unit_price DECIMAL(10, 2) not null,
quantity INT not null,
VAT Float(6, 4) not null, 
Total Decimal(12, 4) not null, 
date datetime not null,
time TIME not null,
payment_method Varchar(15) not null, 
cogs Decimal(10, 2) not null, 
gross_margin_pct  FLOAT(11, 9),
gross_income Decimal (12, 4) not null,
rating FLoat(2, 1)
)
Select * from salesdatawalmart.sales;




-- feature engineering --
-- time_of_day --
select
time,
(case 
when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'time' between "12:01:00" and "16:00:00" then "Afternoon"
Else "Evening"
END)
AS time_of_date
from sales;

Alter table sales add column time_of_day varchar(20);
Select * from salesdatawalmart.sales;
update sales
SET time_of_day = (case 
when 'time' between "00:00:00" and "12:00:00" then "Morning"
when 'time' between "12:01:00" and "16:00:00" then "Afternoon"
Else "Evening"
END
);
-- day name -- 
select
   date,
   dayname(date) AS day_name
from sales;
alter table sales add column day_name varchar(10);
update sales
set day_name = dayname(date)

select*from salesdatawalmart.sales

-- month name --
select
	date,
    monthname(date)
    from sales;
    
    alter table sales add column month_name varchar(10)

update sales 
set month_name = monthname(date);

-- how many unique cities does the data have? --

select distinct city
from sales;

-- in which city is each branch ? --
select distinct branch
from sales;

select distinct city,
branch
from sales;

-- how many unique product lines does the data have? --
select distinct product_line
from sales;

select count(distinct product_line)
from sales;

-- what is the most common payment method? --

select 
payment_method,
count(payment_method) AS Cnt
from sales
group by payment_method
order by Cnt DEsc;

-- what is the most selling product line? --
select 
product_line,
count(product_line) AS Cnt
from sales
group by product_line
order by Cnt DEsc;

-- what is the total revenue by month? --
select month_name AS month,
SUM(total) AS Total_revenue
from sales
Group by month_name
order by  total_revenue DESC;


-- what month had the largest COGS? --

select
month_name as month,
sum(COGS) as cogs_total
from sales
group by month_name
order by cogs_total;

-- which product line had the largest revenue? --


select
product_line,
sum(total) as total_revenue
from sales
group by product_line
order by total_revenue DESC;

-- what is the city with the largest revenue? --

select
branch,
city,
sum(total) as total_revenue
from sales
group by city, branch
order by total_revenue DESC;

-- what product line had the largest VAT? --
select 
product_line,
AVG(VAT) as avg_tax
from sales
group by product_line
order by avg_tax DESC;

-- which branch sold more products than average product sold? --
select 
branch,
sum(quantity) as qty
from sales
group by Branch
having sum(quantity) > (Select AVG(quantity) from sales);

-- what is the most common product line by gender? --

select  gender,
product_line,
count(gender) as total_cnt
from sales
group by gender, product_line
order by total_cnt DESC;

-- what is the average rating of each product line? --

select 
	round(avg(rating), 2) AS avg_rating,
	product_line
from sales
group by product_line
order by avg_rating DESC;

-- number of sales made in each time of the day per weekday -- 

select time_of_day,
count(*) AS total_sales
from sales
where day_name = "monday"
group by time_of_day
order by total_sales

-- which of the customer types brings the most revenue? --

select 
	customer_type,
    SUM(total) AS total_rev
    from sales
    group by customer_type
    order by total_rev DESC
    
    -- which city has the largest tax percent/VAT? -- 
    
    select
		city,
        SUM(VAT) AS VAT
        from sales
        group by city
        order by VAT DESC
        
-- which customer type pays the most in VAT --

Select
	customer_type,
    SUM(VAT) AS VAT_Total
     from sales
    group by customer_type
    order by VAT_Total DEsc
    
    
-- how many unique customer types does the data have? --

Select
	distinct customer_type
    from sales;
    
-- how many unique payment methods does the data have? --

select
	distinct payment_method
    from sales;
    
-- what is the most common customer type? --

select
	distinct customer_type
    from sales;
    
-- which customer type buys the most? --

	select
		customer_type,
		count(*) as cst_count
		from sales
		group by customer_type
        
-- what is the gender of most of the customers? -- 

select 
	gender,
    count(gender) as gender_cnt
    from sales
    group by gender
    order by gender_cnt DESC
    
-- what is the gender distribution per branch? -- 

select 
	gender,
    count(gender) as gender_cnt
    from sales
    where branch = "A"
    group by gender
    order by gender_cnt DESC
    
-- what time of the day do customers give most ratings? -- 

select
	time_of_day,
	avg(rating) as avg_rating
    from sales
    group by time_of_day
    order by avg_rating;
    
-- which time of the day do customers give most ratings per branch? -- 

select
	time_of_day,
	avg(rating) as avg_rating
    from sales
    where branch = "c"
    group by time_of_day
    order by avg_rating;

-- which day of the week has the best avg rating? -- 

select
	day_name,
    AVG(rating) as avg_rating
    from sales
    group by day_name
    order by avg_rating desc;
    
-- which day of the week has the best average ratings per branch? -- 

select
	day_name,
    AVG(rating) as avg_rating
    from sales
    where branch = "a"
    group by day_name
    order by avg_rating desc;

   