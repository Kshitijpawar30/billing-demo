drop database if exists billing_demo;
create database billing_demo;
use billing_demo;



create table products(
    product_id int primary key auto_increment,
    product_name varchar(60) not null,
    category varchar(30),
    price decimal(8,2) not null,
    stock int not null default 0

);

create table bills(
    bill_id int primary key auto_increment,
    customer_name varchar(60) not null,
    phone varchar(15),
    payment_mode enum('cash','upi','card')not null,
    bill_date datetime default current_timestamp,
    total_amount decimal(12,2) default 0
);

-- Detail table: one row per product on a bill (filled by the web page)

CREATE TABLE bill_items (
    item_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    unit_price DECIMAL(8,2) NOT NULL,  -- price at the time of sale
    line_total DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (bill_id) REFERENCES bills(bill_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);


alter table bills auto_increment = 1001;


insert into products(product_name,category,price,stock) values
('Classmate Notebook 200 pg','Notebooks',  60.00, 120),

('Long Notebook 100 pg','Notebooks',35.00, 150),

('Blue Ball Pen','Pens',10.00, 300),

('Gel Pen (Black)','Pens', 20.00, 200),

('HB Pencil (Pack of 10)','Pencils',50.00,  80),

('Geometry Box','Instruments',180.00, 40),

('Scientific Calculator','Instruments',650.00, 15),

('A4 Sheets (100)','Paper',120.00, 60),

('Highlighter Set', 'Art', 90.00,  50),

('School Bag','Bags', 899.00, 10);

-- check 10 products 0 bills 0 items
select 'products' as table_name,count(*) as row_count from products
union all select 'bills', count(*) from bills
union all select 'bill_itmes',count(*) from bill_items;




