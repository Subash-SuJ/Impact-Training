Create Database Sample;
Use Sample;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,  -- Unique ID for each customer
    name VARCHAR(100),            -- Customer's name
    city VARCHAR(50)              -- City where the customer lives
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,      -- Unique ID for each order
    customer_id INT,               -- ID linking to the customer
    order_date DATE,               -- Date the order was placed
    amount DECIMAL(10, 2),         -- Amount of the order
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)  -- Foreign key to link orders to customers
);

INSERT INTO Customers (customer_id, name, city) VALUES
(1, 'John Doe', 'New York'),
(2, 'Jane Smith', 'Chicago'),
(3, 'Emily Davis', 'Los Angeles'),
(4, 'Mike Brown', 'Seattle');


INSERT INTO Orders (order_id, customer_id, order_date, amount) VALUES
(1001, 1, '2024-10-15', 500),
(1002, 2, '2024-10-18', 250),
(1003, 2, '2024-11-01', 300),
(1004, 1, '2024-11-10', 400);  -- Note: Customer with ID 5 does not exist in the Customers table

SELECT customers.name, orders.order_date, orders.amount
FROM customers
INNER JOIN orders ON customers.customer_id = orders.customer_id;

SELECT customers.name, orders.order_date, orders.amount
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

SELECT customers.name, orders.order_date, orders.amount
FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id;

-- SELECT customers.name, orders.order_date, orders.amount
-- FROM customers
-- FULL JOIN orders ON customers.customer_id = orders.customer_id;  {Full Join is not efficiently work in MySql}

-- Simulating FULL JOIN with LEFT JOIN and RIGHT JOIN using UNION
SELECT customers.name, orders.order_date, orders.amount
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id

UNION

SELECT customers.name, orders.order_date, orders.amount
FROM customers
RIGHT JOIN orders ON customers.customer_id = orders.customer_id;


SELECT customers.name, orders.order_date, orders.amount
FROM customers
CROSS JOIN orders;



