create database restaurant_db;
use restaurant_db;

create table waiters(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50)  NOT NULL,
email VARCHAR(50) NOT NULL,
phone VARCHAR(50),
salary DECIMAL(10,2)
);

create table tables(
id INT AUTO_INCREMENT PRIMARY KEY,
floor INT  NOT NULL,
reserved TINYINT(1),
capacity INT  NOT NULL
);

create table products(
id INT AUTO_INCREMENT PRIMARY KEY,
name VARCHAR(30) NOT NULL UNIQUE,
type VARCHAR(30)  NOT NULL,
price DECIMAL(10,2) NOT NULL
);

create table clients(
id INT AUTO_INCREMENT PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50)  NOT NULL,
birthdate DATE NOT NULL,
card VARCHAR(50),
review TEXT
);

create table orders(
id INT AUTO_INCREMENT PRIMARY KEY,
table_id INT NOT NULL,
waiter_id INT NOT NULL,
order_time TIME NOT NULL,
payed_status TINYINT(1),
CONSTRAINT fk_waiters FOREIGN KEY (waiter_id)
REFERENCES waiters (id),
CONSTRAINT fk_tables FOREIGN KEY (table_id)
REFERENCES tables (id)
);


create table orders_products(
order_id INT,
product_id INT,
CONSTRAINT fk_orders FOREIGN KEY (order_id)
	REFERENCES orders (id),
CONSTRAINT fk_products FOREIGN KEY (product_id)
	REFERENCES products (id)
);

create table orders_clients(
order_id INT,
client_id INT,
CONSTRAINT fk_orders_1 FOREIGN KEY (order_id)
	REFERENCES orders (id),
CONSTRAINT fk_clients FOREIGN KEY (client_id)
	REFERENCES clients (id)
);

-- 02. Insert

insert into products (name, type, price)
(select concat(last_name, ' specialty'), 'Cocktail', CEIL(salary/100) from waiters where id>6 );

-- 03. Update

update orders set table_id=table_id-1 where id = 12 or id = 13 or id = 14 or id = 15 or id = 16 or id = 17 or id = 18
or id = 19 or id = 20 or id = 21 or id = 22 or id =23 ;

-- 04. Delete

delete from waiters where id in (
select a.* from (select waiters.id from waiters  left join orders on waiters.id=orders.waiter_id  where orders.waiter_id is null) a
);

DELETE w
FROM waiters AS w
LEFT JOIN orders AS o
ON w.id=o.waiter_id
WHERE o.waiter_id IS NULL;

-- 05. Clients

select id, first_name, last_name, birthdate, card, review
from clients order by birthdate desc, id desc;

-- 06. Birthdate

select first_name, last_name, birthdate, review from clients
where card is null and YEAR(birthdate)  between '1978' and '1993'
order by last_name desc, id
limit 5;

-- 07. Accounts

select concat(last_name, first_name, length(first_name), 'Restaurant') username,
reverse((substr(email, 2,12))) password
from waiters
where salary is not null
order by password desc;

-- 08. Top from menu

select products.id, products.name, count(orders_products.product_id) as count
from products join orders_products on products.id = orders_products.product_id
group by products.id
having count(orders_products.product_id)>=5
order by count desc, name
;

-- 09. Availability

SELECT 
    id, capacity, count_clients,
    
    case 
    when  (capacity = count_clients) then 'Full'
    when (capacity > count_clients) then 'Free seats'
    when (capacity < count_clients)  then 'Extra seats'
 end as availability
FROM
    (SELECT 
        tables.id,
            tables.capacity,
            COUNT(orders_clients.client_id) count_clients
    FROM
        tables, orders, orders_clients
    WHERE
        tables.id = orders.table_id
            AND orders.id = orders_clients.order_id
            AND tables.floor = 1
    GROUP BY tables.id) b
ORDER BY id DESC

-- 10. Extract bill


DELIMITER $$
CREATE FUNCTION udf_client_bill(full_name VARCHAR(50)) 
RETURNS DECIMAL(19,2)
DETERMINISTIC
BEGIN
   DECLARE total_price DECIMAL(19,2);
   SET total_price := (
   
   select sum(products.price)
   from clients, orders_clients, orders_products, products

   where clients.id=orders_clients.client_id
   and orders_clients.order_id=orders_products.order_id
   and orders_products.product_id=products.id
   and concat(first_name, ' ', last_name) = full_name
   
   );
   RETURN total_price;
END$$

-- 11. Happy hour

DELIMITER $$

create procedure udp_happy_hour(type VARCHAR(50))
begin

update products set products.price = products.price - products.price*20/100
where products.price>=10 and products.type = type;

end $$

DELIMITER ;

