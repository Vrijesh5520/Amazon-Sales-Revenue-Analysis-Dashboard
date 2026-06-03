CREATE TABLE amazon_sales (
    order_id VARCHAR(50),
	order_date DATE ,
    product_id VARCHAR(50),
    product_category VARCHAR(100),
    price NUMERIC(10,2),
    discount_percent NUMERIC(5,2),
    quantity_sold INTEGER,
    customer_region VARCHAR(100),
    payment_method VARCHAR(50),
	rating NUMERIC(3,2),
    review_count INTEGER,
	discounted_price NUMERIC(12,2),
    total_revenue NUMERIC(12,2),
    year INTEGER,
	month VARCHAR(20),
    quarter VARCHAR(10)
);

-- Checking missing values
select * from amazon_sales where total_revenue is null;

-- Checking duplicate orders
select order_id,
count(*) from amazon_sales 
group by order_id having count(*) >1;

-- Checking negative values
select * from amazon_sales where total_revenue < 0;

-- 1) Total revenue 
select sum(total_revenue) as total_revenue from amazon_sales;

-- 2) Total orders
select count(order_id) from amazon_sales;

-- 3) Category-wise revenue
select product_category , sum(total_revenue) from amazon_sales
group by product_category order by 2 DESC;

-- 4) Quantity sold by category
select product_category , sum(quantity_sold) from amazon_sales
group by product_category order by 2 DESC;

-- 5) Revenue by region
select customer_region , sum(total_revenue) from amazon_sales
group by customer_region order by 2 DESC;

-- 6) Revenue by payment method 
select payment_method , sum(total_revenue) from amazon_sales
group by payment_method;

-- 7) Monthly revenue trend
select year , month , sum(total_revenue) from amazon_sales
group by year , month order by year , month;

-- 8) Quarterly revenue
select year , quarter , sum(total_revenue) from amazon_sales
group by year, quarter;

-- 9) Customer rating
select product_category , avg(rating) from amazon_sales
group by product_category order by 2 desc;

-- 10) Discount impact
select discount_percent , sum(total_revenue) from amazon_sales
group by discount_percent order by discount_percent;

-- Advanced SQL Analysis

-- Top 10 products :
select product_id , sum(total_revenue) as revenue 
from amazon_sales group by product_id order by revenue desc
limit 10 ;

-- Revenue contribution %
select product_category ,
round(sum(total_revenue)*100/(sum(sum(total_revenue)) over()),2) as revenue_percent
from amazon_sales group by product_category;
