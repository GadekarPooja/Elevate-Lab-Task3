create database Elevate_Lab;
use Elevate_Lab;

#SELECT
select * from ecommercepk1;

#WHERE
SELECT  day ,amount_spent
FROM  ecommercepk1
WHERE amount_spent > 2000;

#ORDER BY AMOUNT DESC
SELECT day, amount_spent
FROM ecommercepk1
ORDER BY amount_spent DESC;

#GROUP BY Day (Total spent per day)

SELECT day, SUM(amount_spent) AS total_spent
FROM ecommercepk1
group by  day
ORDER BY day;

#B. JOINS (INNER / LEFT / RIGHT)

#Create second table:

CREATE TABLE page_details (
   page_name VARCHAR(50),
   category VARCHAR(50)
);

# insert values

INSERT INTO page_details (page_name, category)
VALUES
('censored', 'Shopping'),
('ABC Store', 'Grocery'),
('XYZ Ads', 'Electronics');

select * from page_details;

#INNER JOIN

SELECT ecommercepk1.day, ecommercepk1.amount_spent, page_details .category
FROM ecommercepk1 
INNER JOIN page_details 
ON ecommercepk1.page_name = page_details .page_name;

#LEFT JOIN

SELECT a.*, p.category
FROM ecommercepk1 a
LEFT JOIN page_details p
ON a.page_name = p.page_name;

#RIGHT JOIN

SELECT a.*, p.category
FROM ecommercepk1 a
RIGHT JOIN page_details p
ON a.page_name = p.page_name;

#SUB QEURY

SELECT *FROM ecommercepk1
WHERE amount_spent > (SELECT AVG(amount_spent) FROM ecommercepk1);

#AGGREGATE FUNCTION

#SUM

SELECT SUM(amount_spent) AS total_spending
FROM ecommercepk1;

#AVERAGE

SELECT AVG(amount_spent) AS avg_spending
FROM ecommercepk1;

#MAX MIN

SELECT MAX(amount_spent), MIN(amount_spent)
FROM ecommercepk1;

#CREATE VIEW FOR analyze

CREATE VIEW high_spend_days AS
SELECT page_name, day, amount_spent
FROM ecommercepk1
WHERE amount_spent > 2000;

SELECT * FROM high_spend_days;

#CREATE INDEX FOR OPTIMIZATION

CREATE INDEX idx_day ON  ecommercepk1 (day(10));

CREATE INDEX idx_amount ON  ecommercepk1 (amount_spent );

SHOW INDEXES FROM ecommercepk1;