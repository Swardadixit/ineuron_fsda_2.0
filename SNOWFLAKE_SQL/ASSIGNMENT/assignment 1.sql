
create or replace table sales_sd 
(   order_id string not null primary key,
    order_date string,
    ship_date string,
    ship_mode varchar(50),
    customer_name char(100),
    segment varchar(50),
    state varchar(50),
    country char(50),
    market char(50),
    region char (50),
    product_id string,
    category varchar(50),
    sub_category char(50),
    product_name varchar(150),
    sales int,
    quantity int,
    discount number,
    profit number,
    shipping_cost number,
    order_price varchar(20),
    year_ int
);
---- create a copy of table ------
create or replace table sd_sales_copy as
select *from sales_sd;
select *from sd_sales_copy;
select *from sales_sd;

--------Check the data type for Order date and Ship date and mention in what data type it should be?
create or replace table sd_sales_copy as
select *,to_char(date(order_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') as order_date2
from sd_sales_copy;
create or replace table sd_sales_copy as
select*,
to_char(date(ship_date, 'yyyy-mm-dd'), 'yyyy-mm-dd') as ship_date2
from sd_sales_copy;
-------Create a new column called order_extract and extract the number after the last‘–‘from Order ID column.
create or replace table sd_sales_copy as
select *,substring(order_id, 4) as order_extract
from sd_sales_copy;
-------Create a new column called Discount Flag and categorize it based on discount. Use ‘Yes’ if the discount is greater than zero else ‘No’.
create or replace table sd_sales_copy as
select*,case
        when discount > 0 then 'yes'
        else 'no'
    end as discount_flag
from sd_sales_copy;
------Create a new column called process days and calculate how many days it takes for each order id to process from the order to its shipment.
create or replace table sd_sales_copy as
select *, datediff('day', order_date2, ship_date2) as process_date
from sd_sales_copy;
--------Create a new column called Rating and then based on the Process dates give rating like given below.
create or replace table sd_sales_copy as
select *,
    case
        when process_date < 3 or process_date = 3 then '5'
        when process_date between 4 and 6 then '4'
        when process_date between 7 and 10 then '3'
        else '2'
    end as rating
from
    sd_sales_copy;
