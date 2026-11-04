-- Create database 
create database sql_project_1;
use sql_project_1;

-- Create table 
create table sales_projects
( 
  order_id int primary key,
  order_date date,
  customer_id int ,
  product_category varchar(15),
  region varchar(10),
  quantity int ,
  unit_price float,
  discount	float,
  payment_method  varchar(15),
  delivery_days	int, 
  customer_rating float,
  revenue float
);

select * from sales_projects;

-- Check for the null values across the database
select * from sales_projects 
where 
    order_date is null or customer_id is null 
    or product_category is null or region is null 
    or quantity is null or unit_price is null 
    or discount is null or payment_method is null 
    or delivery_days is null or customer_rating is null 
    or revenue is null ;
    
-- deleting null values 
delete from sales_projects 
where order_id between 10001 and 15000
  and(
    order_date is null or customer_id is null 
    or product_category is null or region is null 
    or quantity is null or unit_price is null 
    or discount is null or payment_method is null 
    or delivery_days is null or customer_rating is null 
    or revenue is null) ;
    
-- Data Exploration

/* KPI-> Total order, distinct customers, distinct categories,total revenue, avg order, 
   avg customer rating, total quantity sold */
select
    count(*) as Total_orders,
    count(distinct customer_id) as Unique_Customers,
	count(distinct product_category) as Category,
    round(sum(revenue),2) as Total_revenue,
    round(avg(revenue),2) as Avg_order_value,
    round(avg(customer_rating),2) as avg_customer_rating,
    sum(quantity) as total_quantity_sold
from sales_projects;

-- Monthly revenue trends 
select 
   year(order_date) as Order_year,
   month(order_date) as Order_month,
   round(sum(revenue),2) as Total_revenue,
   count(order_id) as Total_orders 
from sales_projects 
group by year(order_date),month(order_date)
order by year(order_date),month(order_date) asc;

-- Category-wise and region-wise sales analysis
select
   product_category as Category,
   region as Region,
   count(order_id) as Total_orders,
   round(sum(revenue),2) as Total_revenue
from sales_projects
group by product_category, region 
order by Total_revenue desc;

-- Find the top 10 customers by revenue.
with cte as (
  select 
     customer_id as Customer_id,
     round(sum(revenue),2) as Total_revenue
    from sales_projects
    group by customer_id
    order by sum(revenue) desc, customer_id asc
    limit 10
)

select * from cte
order by Total_revenue desc, Customer_id asc;

-- Rank regions by revenue.
with region_rev as (
    select 
       region as Region,
       round(sum(revenue),2)as Total_revenue
	from sales_projects
    group by region 
)
select
 Region,
 Total_revenue,
 dense_rank() over(
       order by Total_revenue desc
       ) as Region_rank
from region_rev;

-- Which product category receives the highest average discount?
select 
   product_category as Category,
   round(avg(discount)*100,2) as Average_discount_Percentage
from sales_projects
group by Category
order by  avg(discount) desc;

-- Calculate each category's percentage contribution to revenue.
select 
    product_category as Category,
    round(sum(revenue),2) as Revenue,
	round(
        (sum(revenue)*100)/ 
        (select sum(revenue) from sales_projects)
        ,2) as Percentage_contribution 
from sales_projects 
group by product_category
order by round(sum(revenue),2) desc;

-- average delivery time by region.
select 
   region,
   round(avg(delivery_days),2) as avg_delivery_time
from sales_projects
group by region
order by avg_delivery_time asc;

-- Compare customer ratings across delivery-time groups.
select    
    round(avg(customer_rating),2) as avg_customer_rating,
    case
       when delivery_days between 1 and 2 then '1-2 days'
       when delivery_days between 3 and 5 then '3-5 days'
       else 'More than 5 days'
	end as delivery_group,
    count(*) as total_orders
from sales_projects
group by delivery_group
order by avg_customer_rating desc;

-- Which customers have purchased more than once?
select
    customer_id,
    count(*) as total_orders,
    round(sum(revenue),2) as total_revenue
from sales_projects
group by customer_id
having count(*)>1
order by total_revenue desc;


-- Which payment methods generate the most revenue, and do customer ratings differ by method?
select 
   payment_method,
   round(sum(revenue),2) as total_revenue,
   round(avg(revenue),2) as avg_revenue,
   round(avg(customer_rating),2) as avg_rating
from sales_projects 
group by payment_method
order by total_revenue desc;

-- Month-over-month revenue growth
with ce1 as (
   select 
       date_format(order_date,'%Y-%m') as month_,
       round(sum(revenue),2) as total_revenue
	from sales_projects
    group by date_format(order_date,'%Y-%m')
),
ce2 as (
	select 
        month_,
        total_revenue,
        lag(total_revenue) over(
           order by month_
		)as previous_month_revenue
	from ce1
)
select 
   month_,
   total_revenue,
   previous_month_revenue,
   round(
     (total_revenue - previous_month_revenue)/
     nullif(previous_month_revenue,0)*100,2) as percentage_change
from ce2
order by month_;

-- Best-selling product categories by quantity
select 
    product_category as category,
    sum(quantity) as total_quantity,
    round(sum(revenue),2) as total_revenue
from sales_projects 
group by category
order by total_quantity desc;