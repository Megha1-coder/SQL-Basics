# Q 1: Write the SQL query to create the employee table with all constraints.

CREATE TABLE employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,  
    salary DECIMAL DEFAULT 30000
);

# Q 2: Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
# examples of common types of constraints.

# A 2: Database constraints are rules that ensure data accuracy, consistency, and reliability by restricting the type and range of data that can be entered into a table. They help maintain data integrity by enforcing business rules and preventing invalid data from being inserted, updated, or deleted. 
#Here are some common types of constraints and how they help maintain data integrity:
#Primary Key:
#Uniquely identifies each record in a table, ensuring no two rows have the same primary key value. 
#Foreign Key:
#Establishes a relationship between two tables by referencing the primary key of another table, ensuring referential integrity. 
#Unique:
#Ensures that the values in a specified column (or set of columns) are unique and cannot be duplicated. 
#Not Null:
#Prevents a column from containing null values, ensuring that a value is always present in that column. 
#Check:
#Defines a condition that must be true for data in a column, enforcing data validity and consistency. 
#Default:
#Specifies a default value for a column if no value is provided during insertion, ensuring data consistency. 

# Q 3: Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify
#your answer.

#A 3: You apply a NOT NULL constraint to a column to ensure that it always contains a value, preventing null values from being inserted or updated. A primary key, by definition, cannot contain null values because it uniquely identifies each row, and null values would violate this uniqueness requirement. 

# Q 4: Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
# example for both adding and removing a constraint.

# A 4: n SQL, you can add or remove constraints on an existing table using ALTER TABLE statements. These commands allow you to modify the structure of an existing table without needing to drop and recreate it.

# Steps to Add a Constraint:
# Use the ALTER TABLE statement to modify the existing table.

#Specify the type of constraint you want to add (e.g., PRIMARY KEY, FOREIGN KEY, CHECK, UNIQUE, NOT NULL).

#Provide the necessary details for the constraint (e.g., column names, condition).

# Example to Add a Constraint:
ALTER TABLE employees
ADD CONSTRAINT chk_age CHECK (age >= 18);

# Steps to Remove a Constraint:
#Use the ALTER TABLE statement to modify the existing table.

#Specify the constraint type you want to remove and the constraint name.

#If the constraint has a specific name, you must reference it when removing it.

#Example to Remove a Constraint:
ALTER TABLE employees
DROP CONSTRAINT chk_age;

# Q 5: Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
# Provide an example of an error message that might occur when violating a constraint.

# A 5: Attempting to insert, update, or delete data that violates a constraint will result in the operation failing, and an error message will be displayed, preventing data inconsistencies and maintaining data integrity. 
# Example of Violating Constraints:
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INT CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL DEFAULT 30000
);

# Example 1: Violating the PRIMARY KEY Constraint
-- Attempting to insert duplicate emp_id
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, 'John Doe', 30, 'john.doe@example.com', 40000);

-- Attempting to insert a row with the same emp_id (which is the primary key)
INSERT INTO employees (emp_id, emp_name, age, email, salary)
VALUES (1, 'Jane Doe', 28, 'jane.doe@example.com', 35000);

#Error Message (for the second insert):
#ERROR 1062 (23000): Duplicate entry '1' for key 'PRIMARY'

# Q 6: You created a products table without constraints 
CREATE TABLE products (
    product_id INT PRIMARY KEY,  -- Primary key constraint
    product_name VARCHAR(50),
    price DECIMAL(10, 2) DEFAULT 50.00  -- Default value for price
);

# Q 7: Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
-- Create the 'classes' table
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50)
);

-- Create the 'students' table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

-- Insert data into the 'classes' table
INSERT INTO classes (class_id, class_name)
VALUES
    (101, 'Math'),
    (102, 'Science'),
    (103, 'History');

-- Insert data into the 'students' table
INSERT INTO students (student_id, student_name, class_id)
VALUES
    (1, 'Alice', 101),
    (2, 'Bob', 102),
    (3, 'Charlie', 101);
    
SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c ON s.class_id = c.class_id;

# Q 8: Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
#listed even if they are not associated with an order Hint: (use INNER JOIN and LEFT JOIN)5
DROP TABLE IF EXISTS products;
-- Drop the foreign key constraint from the 'orders' table
ALTER TABLE orders DROP FOREIGN KEY orders_ibfk_1;

-- Now drop the 'customers' table
DROP TABLE IF EXISTS customers;
SHOW CREATE TABLE orders;
ALTER TABLE orders DROP FOREIGN KEY fk_orders_customers;
DROP TABLE IF EXISTS customers;


-- Create the 'customers' table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100)
);

-- Create the 'orders' table
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Create the 'products' table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    order_id INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

# Q 9: Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

SELECT 
    p.product_name,
    SUM(oi.quantity * oi.price_per_unit) AS total_sales
FROM 
    products p
INNER JOIN 
    order_items oi ON p.product_id = oi.product_id
GROUP BY 
    p.product_name;
    
# Q 10: Write a query to display the order_id, customer_name, and the quantity of products ordered by each
# customer using an INNER JOIN between all three tables.

SELECT 
    o.order_id,
    c.customer_name,
    oi.quantity
FROM 
    orders o
INNER JOIN 
    customers c ON o.customer_id = c.customer_id
INNER JOIN 
    order_items oi ON o.order_id = oi.order_id;
    
# SQL Commands

# 1-Identify the primary keys and foreign keys in maven movies db. Discuss the differences
# A: In the Maven Movies database, primary keys uniquely identify each record within a table, while foreign keys establish relationships between tables by referencing the primary keys of other tables. 

# 2- List all details of actors
SELECT * FROM actors;

# 3 -List all customer information from DB.
SELECT * FROM customers;
SELECT customer_id, first_name, last_name, email, phone FROM customers;
DESCRIBE customers;
SELECT customer_id, name, surname, email, phone FROM customers LIMIT 0, 1000;

# 4 -List different countries.
SELECT DISTINCT country FROM city;

# 5 -Display all active customers.
SELECT * FROM customers WHERE is_active = 1;

# 6 -List of all rental IDs for customer with ID 1.
SELECT rental_id FROM rentals WHERE customer_id = 1;

# 7 - Display all the films whose rental duration is greater than 5 .
SELECT * FROM films WHERE rental_duration > 5;

# 8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
SELECT COUNT(*) FROM films WHERE replacement_cost > 15 AND replacement_cost < 20;

# 9 - Display the count of unique first names of actors.
SELECT COUNT(DISTINCT first_name) FROM actors;

# 10- Display the first 10 records from the customer table .
SELECT * FROM customers LIMIT 10;

#11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
SELECT * FROM customers WHERE first_name LIKE 'B%' LIMIT 3;

# 12 -Display the names of the first 5 movies which are rated as ‘G’.
SELECT movie_title FROM movies WHERE rating = 'G' LIMIT 5;

# 13-Find all customers whose first name starts with "a".
SELECT * FROM customers WHERE first_name LIKE 'A%';

#14- Find all customers whose first name ends with "a".
SELECT * FROM customers WHERE first_name LIKE '%a';

# 15- Display the list of first 4 cities which start and end with ‘a’ .
SELECT city_name FROM cities WHERE city_name LIKE 'a%' AND city_name LIKE '%a' LIMIT 4;

# 16- Find all customers whose first name have "NI" in any position.
SELECT * FROM customers WHERE first_name LIKE '%NI%';

# 17- Find all customers whose first name have "r" in the second position .
SELECT * FROM customers WHERE first_name LIKE '_r%';

# 18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
SELECT * FROM customers WHERE first_name LIKE 'A%' AND LENGTH(first_name) >= 5;

# 19- Find all customers whose first name starts with "a" and ends with "o".
SELECT * FROM customers WHERE first_name LIKE 'A%o';

# 20 - Get the films with pg and pg-13 rating using IN operator.
SELECT * FROM films WHERE rating IN ('PG', 'PG-13');

# 21 - Get the films with length between 50 to 100 using between operator.
SELECT * FROM films WHERE length BETWEEN 50 AND 100;

# 22 - Get the top 50 actors using limit operator.
SELECT * FROM actors LIMIT 50;

#23 - Get the distinct film ids from inventory table.
SELECT DISTINCT film_id FROM inventory;


#Functions
# Basic Aggregate Functions:
#Question 1: Retrieve the total number of rentals made in the Sakila database. Hint: Use the COUNT() function.
SELECT COUNT(*) AS total_rentals FROM rental;

# Question 2: Find the average rental duration (in days) of movies rented from the Sakila database. Hint: Utilize the AVG() function.	

SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

# Question 3: Display the first name and last name of customers in uppercase. Hint: Use the UPPER () function.		
SELECT UPPER(first_name) AS first_name_upper, UPPER(last_name) AS last_name_upper
FROM customers;

# Question 4: Extract the month from the rental date and display it alongside the rental ID. Hint: Employ the MONTH() function.
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

#Question 5: Retrieve the count of rentals for each customer (display customer ID and the count of rentals). Hint: Use COUNT () in conjunction with GROUP BY.

SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;

# Question 6: Find the total revenue generated by each store. Hint: Combine SUM() and GROUP BY.

SELECT store_id, SUM(amount) AS total_revenue
FROM rental
GROUP BY store_id;

# Question 7: Determine the total number of rentals for each category of movies. Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.

SELECT c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
JOIN rental r ON f.film_id = r.film_id
GROUP BY c.category_id;

# Question 8: Find the average rental rate of movies in each language. Hint: JOIN film and language tables, then use AVG () and GROUP BY.

SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM language l
JOIN film f ON l.language_id = f.language_id
GROUP BY l.language_id;

# Joins

# Questions 9 - Display the title of the movie, customer s first name, and last name who rented it. Hint: Use JOIN between the film, inventory, rental, and customer tables.

SELECT f.title AS movie_title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

# Question 10: Retrieve the names of all actors who have appeared in the film "Gone with the Wind." Hint: Use JOIN between the film actor, film, and actor tables.

SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

# Question 11:Retrieve the customer names along with the total amount they've spent on rentals.Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.

SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id;


# Question 12: List the titles of movies rented by each customer in a particular city (e.g., 'London'). Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.

SELECT c.first_name, c.last_name, f.title AS movie_title
FROM customer c
JOIN address a ON c.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London'
ORDER BY c.first_name, c.last_name, f.title;


# Advanced Joins and GROUP BY:

# Question 13: Display the top 5 rented movies along with the number of times they've been rented. Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.

SELECT f.title AS movie_title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.film_id
ORDER BY rental_count DESC
LIMIT 5;

# Question 14: Determine the customers who have rented movies from both stores (store ID 1 and store ID 2). Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id IN (1, 2)
GROUP BY c.customer_id
HAVING COUNT(DISTINCT i.store_id) = 2;

# Windows Function:

# 1. Rank the customers based on the total amount they've spent on rentals.

SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
JOIN rental r ON p.rental_id = r.rental_id
GROUP BY c.customer_id
ORDER BY customer_rank;

# 2. Calculate the cumulative revenue generated by each film over time.

SELECT f.title AS movie_title, 
       p.payment_date,
       SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY p.payment_date) AS cumulative_revenue
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
JOIN payment p ON r.rental_id = p.rental_id
ORDER BY f.film_id, p.payment_date;

# 3. Determine the average rental duration for each film, considering films with similar lengths.

SELECT f.title AS movie_title, 
       f.length AS film_length,
       AVG(rr.rental_duration) AS avg_rental_duration
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental rr ON i.inventory_id = rr.inventory_id
GROUP BY f.length
ORDER BY f.length;

# 4. Identify the top 3 films in each category based on their rental counts.

WITH FilmRentalCounts AS (
    SELECT f.film_id, f.title AS movie_title, c.name AS category_name,
           COUNT(r.rental_id) AS rental_count,
           RANK() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS film_rank
    FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY f.film_id, c.category_id
)
SELECT movie_title, category_name, rental_count
FROM FilmRentalCounts
WHERE film_rank <= 3
ORDER BY category_name, film_rank;

# 5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.

WITH CustomerRentalCounts AS (
    SELECT c.customer_id, 
           c.first_name, 
           c.last_name, 
           COUNT(r.rental_id) AS total_rentals
    FROM customer c
    JOIN rental r ON c.customer_id = r.customer_id
    GROUP BY c.customer_id
),
AverageRentalCount AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM CustomerRentalCounts
)
SELECT crc.customer_id, 
       crc.first_name, 
       crc.last_name, 
       crc.total_rentals, 
       arc.avg_rentals,
       (crc.total_rentals - arc.avg_rentals) AS rental_difference
FROM CustomerRentalCounts crc
CROSS JOIN AverageRentalCount arc
ORDER BY rental_difference DESC;


# 6. Find the monthly revenue trend for the entire rental store over time.

SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY year, month;


# 7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.

WITH CustomerSpending AS (
    SELECT c.customer_id, 
           c.first_name, 
           c.last_name, 
           SUM(p.amount) AS total_spending
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
),
SpendingThreshold AS (
    SELECT PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY total_spending DESC) AS threshold
    FROM CustomerSpending
)
SELECT cs.customer_id, 
       cs.first_name, 
       cs.last_name, 
       cs.total_spending
FROM CustomerSpending cs, SpendingThreshold st
WHERE cs.total_spending >= st.threshold
ORDER BY cs.total_spending DESC;


# 8. Calculate the running total of rentals per category, ordered by rental count.
WITH CategoryRentalCounts AS (
    SELECT c.name AS category_name, 
           COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category fc ON i.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.category_id
)
SELECT category_name, 
       rental_count,
       SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
FROM CategoryRentalCounts
ORDER BY rental_count DESC;


# 9. Find the films that have been rented less than the average rental count for their respective categories.

WITH FilmRentalCounts AS (
    SELECT f.film_id,
           f.title,
           c.name AS category_name,
           COUNT(r.rental_id) AS rental_count
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY f.film_id, f.title, c.category_id
),
CategoryAverageRentalCounts AS (
    SELECT category_name,
           AVG(rental_count) AS avg_rental_count
    FROM FilmRentalCounts
    GROUP BY category_name
)
SELECT frc.film_id,
       frc.title,
       frc.category_name,
       frc.rental_count,
       cac.avg_rental_count
FROM FilmRentalCounts frc
JOIN CategoryAverageRentalCounts cac
  ON frc.category_name = cac.category_name
WHERE frc.rental_count < cac.avg_rental_count
ORDER BY frc.category_name, frc.rental_count;


# 10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.

SELECT 
    YEAR(p.payment_date) AS year,
    MONTH(p.payment_date) AS month,
    SUM(p.amount) AS total_revenue
FROM payment p
GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
ORDER BY total_revenue DESC
LIMIT 5;

# Normalisation & CTE

# 1. First Normal Form (1NF): a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.

# First Normal Form (1NF) Definition:
# A table is in First Normal Form (1NF) if: All columns contain atomic values (each value in a column is indivisible). There are no repeating groups or arrays in the table.
# Each record (row) is unique.

CREATE TABLE film_actors_normalized (
    film_id INT,
    actor_id INT,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id)
);
-- Insert actor-film relationships for each actor of a film
INSERT INTO film_actors_normalized (film_id, actor_id)
VALUES
(1, 1),  -- John in "The Great Adventure"
(1, 2),  -- Alice in "The Great Adventure"
(1, 3),  -- Bob in "The Great Adventure"
(2, 4),  -- Tom in "Space Odyssey"
(2, 5),  -- David in "Space Odyssey"
(3, 2),  -- Alice in "The Lost World"
(3, 3);  -- Bob in "The Lost World"

# 2. Second Normal Form (2NF): a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.

CREATE TABLE rental (
    rental_id INT PRIMARY KEY,
    rental_date DATETIME,
    return_date DATETIME,
    staff_id INT,
    amount DECIMAL(5, 2),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);
CREATE TABLE rental_customer (
    rental_id INT,
    customer_id INT,
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    PRIMARY KEY (rental_id, customer_id)
);
CREATE TABLE rental_inventory (
    rental_id INT,
    inventory_id INT,
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    PRIMARY KEY (rental_id, inventory_id)
);


# 3. Third Normal Form (3NF): a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies  present and outline the steps to normalize the table to 3NF.

CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    rental_id INT,
    amount DECIMAL(5, 2),
    payment_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);
-- Create the customer table (normalized)
CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    address_id INT,
    FOREIGN KEY (address_id) REFERENCES address(address_id)
);

-- Create the payment table (normalized)
CREATE TABLE payment (
    payment_id INT PRIMARY KEY,
    customer_id INT,
    staff_id INT,
    rental_id INT,
    amount DECIMAL(5, 2),
    payment_date DATETIME,
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);


# 4. Normalization Process: a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.

CREATE TABLE customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    customer_address VARCHAR(100)
);
CREATE TABLE film (
    film_id INT PRIMARY KEY,
    film_title VARCHAR(255),
    rental_duration INT
);
CREATE TABLE rental (
    rental_id INT PRIMARY KEY,
    rental_date DATETIME,
    customer_id INT,
    film_id INT,
    staff_id INT,
    payment_amount DECIMAL(5,2),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


# 5. CTE Basics: a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they  have acted in from the actor and film_actor tables.

WITH actor_film_count AS (
    SELECT 
        a.first_name || ' ' || a.last_name AS actor_name, 
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id
)
SELECT actor_name, film_count
FROM actor_film_count
ORDER BY film_count DESC;


# 6. CTE with Joins: a. Create a CTE that combines information from the film and language tables to display the film title,  language name, and rental rate.

WITH film_language_info AS (
    SELECT 
        f.title AS film_title, 
        l.name AS language_name, 
        f.rental_rate
    FROM film f
    JOIN language l ON f.language_id = l.language_id
)
SELECT film_title, language_name, rental_rate
FROM film_language_info;


# 7. CTE for Aggregation: a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments)  from the customer and payment tables.

WITH customer_revenue AS (
    SELECT 
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM customer c
    JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id
)
SELECT customer_id, first_name, last_name, total_revenue
FROM customer_revenue
ORDER BY total_revenue DESC;

# 8\ CTE with Window Functions: a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.


WITH ranked_films AS (
    SELECT 
        title AS film_title,
        rental_duration,
        RANK() OVER (ORDER BY rental_duration DESC) AS rank
    FROM film
)
SELECT film_title, rental_duration, rank
FROM ranked_films
ORDER BY rank;


# 9\ CTE and Filtering: a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the  customer table to retrieve additional customer details.

WITH rental_count AS (
    SELECT 
        customer_id,
        COUNT(*) AS rental_count
    FROM rental
    GROUP BY customer_id
    HAVING COUNT(*) > 2
)
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    c.phone,
    rc.rental_count
FROM customer c
JOIN rental_count rc ON c.customer_id = rc.customer_id
ORDER BY rc.rental_count DESC;


# 10 CTE for Date Calculations: a. Write a query using a CTE to find the total number of rentals made each month, considering the  rental_date from the rental table


WITH monthly_rentals AS (
    SELECT 
        YEAR(rental_date) AS rental_year,
        MONTH(rental_date) AS rental_month,
        COUNT(*) AS total_rentals
    FROM rental
    GROUP BY YEAR(rental_date), MONTH(rental_date)
)
SELECT rental_year, rental_month, total_rentals
FROM monthly_rentals
ORDER BY rental_year DESC, rental_month DESC;

# 11: CTE and Self-Join: a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film  together, using the film_actor table.

WITH actor_pairs AS (
    SELECT 
        fa.actor_id,
        fa.film_id
    FROM film_actor fa
)
SELECT 
    a1.actor_id AS actor_1,
    a2.actor_id AS actor_2,
    ap1.film_id
FROM actor_pairs ap1
JOIN actor_pairs ap2 ON ap1.film_id = ap2.film_id AND ap1.actor_id < ap2.actor_id
ORDER BY ap1.film_id, actor_1, actor_2;


# 12. CTE for Recursive Search: a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager,  considering the reports_to column

WITH RECURSIVE employee_hierarchy AS (
    -- Anchor member: start with the manager (assume manager_id is 1, change as needed)
    SELECT 
        staff_id,
        first_name,
        last_name,
        reports_to
    FROM staff
    WHERE staff_id = 1  -- Replace 1 with the specific manager's staff_id

    UNION ALL

    -- Recursive member: find employees who report to the current employees
    SELECT 
        s.staff_id,
        s.first_name,
        s.last_name,
        s.reports_to
    FROM staff s
    INNER JOIN employee_hierarchy eh ON s.reports_to = eh.staff_id
)
-- Final select: return all employees who report to the manager
SELECT staff_id, first_name, last_name
FROM employee_hierarchy
WHERE staff_id != 1  -- Exclude the manager from the results
ORDER BY staff_id;




