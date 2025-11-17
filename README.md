# Elevate-Lab-Task3
SQL for Data Analysis

1.CREATE DATABASE
CREATE DATABASE Elevate_Lab;

Creates a new database named Elevate_Lab.
A database is like a container for tables.
Used to keep all project-related tables in one place.
If the database already exists, MySQL may show an error unless you use:
CREATE DATABASE IF NOT EXISTS Elevate_Lab;

2.USE Database
USE Elevate_Lab;

Selects the database where you want to run all upcoming SQL commands.
Without USE, SQL does not know which database's tables you are trying to access.

3.SELECT All Data
SELECT * FROM ecommercepk1;

Fetches all rows and all columns from the table.
 means every column.Useful for checking data, but not recommended in production (slower + unnecessary data).

4.WHERE Clause (Filter Results)
SELECT day, amount_spent
FROM ecommercepk1
WHERE amount_spent > 2000;

Shows only those rows where amount_spent is greater than 2000.
To filter data using conditions.Works with operators like >, <, >=, =, !=.
Rows with NULL in amount_spent will not be included (because NULL cannot be compared with >).

5.ORDER BY (Sort Data)
SELECT day, amount_spent
FROM ecommercepk1
ORDER BY amount_spent DESC;

Sorts the data in descending order of spending.

DESC = highest to lowest
ASC = lowest to highest (default)

6.GROUP BY (Aggregate per Day)
SELECT day, SUM(amount_spent) AS total_spent
FROM ecommercepk1
GROUP BY day
ORDER BY day;

Groups rows by day.Calculates total spending per day using SUM().
All non-aggregated columns in SELECT must appear in GROUP BY.
Used for reporting, analytics, dashboards.

7.Create Second Table
CREATE TABLE page_details (
    page_name VARCHAR(50),
    category VARCHAR(50)
);

Creates a new table to store page names and their categories.
VARCHAR(50) stores text up to 50 characters.
This table will later be joined with ecommercepk1.

8.Insert Data
INSERT INTO page_details (page_name, category)
VALUES
('censored', 'Shopping'),
('ABC Store', 'Grocery'),
('XYZ Ads', 'Electronics');

Adds three rows into page_details.
You can insert multiple rows at once.Data types must match column types.

9.INNER JOIN
SELECT e.day, e.amount_spent, p.category
FROM ecommercepk1 e
INNER JOIN page_details p
ON e.page_name = p.page_name;

Returns only the rows where page_name matches in both tables.
Shows common data (intersection).If page_name does not match, the row is not included.

10.LEFT JOIN
SELECT e.*, p.category
FROM ecommercepk1 e
LEFT JOIN page_details p
ON e.page_name = p.page_name;

Returns all rows from ecommercepk1, even if category is missing.
Non-matching rows will show category = NULL.Useful to identify missing category mappings.

11.RIGHT JOIN
SELECT e.*, p.category
FROM ecommercepk1 e
RIGHT JOIN page_details p
ON e.page_name = p.page_name;

Returns all rows from page_details, even if they do not exist in ecommercepk1.
Opposite of LEFT JOIN.Less commonly used; LEFT JOIN is preferred.

12.SUBQUERY
SELECT *
FROM ecommercepk1
WHERE amount_spent > (SELECT AVG(amount_spent) FROM ecommercepk1);

Shows rows where amount_spent is greater than the average of the table.
(SELECT AVG(...)) returns a single value.The outer query compares each row to this value.

13.Aggregate Functions
SUM
SELECT SUM(amount_spent) AS total_spending
FROM ecommercepk1;

 Returns total amount spent.

AVG
SELECT AVG(amount_spent) AS avg_spending
FROM ecommercepk1;

 Returns average spending.

MAX and MIN
SELECT MAX(amount_spent), MIN(amount_spent)
FROM ecommercepk1;

Returns highest and lowest spending amounts.
These functions ignore NULL values.

14.Create View
CREATE VIEW high_spend_days AS
SELECT page_name, day, amount_spent
FROM ecommercepk1
WHERE amount_spent > 2000;

Creates a virtual table showing high-spend rows only.

SELECT * FROM high_spend_days;

Used to view data inside the view.Views save time by storing commonly used queries.
They do not store data physically.

15.Create Index
CREATE INDEX idx_day ON ecommercepk1 (day(10)); 
CREATE INDEX idx_amount ON ecommercepk1 (amount_spent);

Indexes improve the speed of searches, sorting, and filtering.
idx_day → makes searching by day fasteridx_amount → makes filtering/order by amount faster

Indexes store sorted copies of columns internally
Too many indexes slow down INSERT/UPDATE operations.

16.Show Indexes
SHOW INDEXES FROM ecommercepk1;
Displays all indexes on the table.
