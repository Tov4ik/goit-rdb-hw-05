SELECT 
    order_details.*, 
    (SELECT customer_id 
     FROM orders 
     WHERE orders.id = order_details.order_id) AS customer_id
FROM order_details;

SELECT * FROM order_details 
WHERE order_id IN (
    SELECT id 
    FROM orders 
    WHERE shipper_id = 3
);

SELECT 
    order_id, 
    AVG(quantity) AS avg_quantity
FROM 
    (SELECT * FROM order_details WHERE quantity > 10) AS temp_table
GROUP BY 
    order_id;

WITH temp AS (
    SELECT * FROM order_details 
    WHERE quantity > 10
)
SELECT 
    order_id, 
    AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

DROP FUNCTION IF EXISTS divide_numbers;

DELIMITER //

CREATE FUNCTION divide_numbers(a FLOAT, b FLOAT) 
RETURNS FLOAT
DETERMINISTIC 
BEGIN
    RETURN a / b;
END //

DELIMITER ;

SELECT 
    order_id, 
    quantity, 
    divide_numbers(quantity, 2) AS divided_quantity
FROM order_details;