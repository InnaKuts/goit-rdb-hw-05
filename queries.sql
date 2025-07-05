-- Завдання 1: Відображення order_details та customer_id з orders за допомогою вкладеного запиту в SELECT
SELECT 
    od.*,
    (SELECT o.customer_id FROM orders o WHERE o.id = od.order_id) AS customer_id
FROM order_details od;

-- Завдання 2: Фільтрація order_details за умовою shipper_id=3 за допомогою вкладеного запиту в WHERE
SELECT od.*
FROM order_details od
WHERE od.order_id IN (SELECT o.id FROM orders o WHERE o.shipper_id = 3);

-- Завдання 3: Вкладений запит в FROM для знаходження середнього quantity для quantity>10, групування за order_id
SELECT 
    order_id,
    AVG(quantity) AS avg_quantity
FROM (
    SELECT * FROM order_details WHERE quantity > 10
) AS filtered_details
GROUP BY order_id;

-- Завдання 4: Використання оператора WITH для створення тимчасової таблиці temp
WITH temp AS (
    SELECT * FROM order_details WHERE quantity > 10
)
SELECT 
    order_id,
    AVG(quantity) AS avg_quantity
FROM temp
GROUP BY order_id;

-- Завдання 5: Створення функції для ділення двох параметрів типу FLOAT
DROP FUNCTION IF EXISTS divide_floats;

DELIMITER //
CREATE FUNCTION divide_floats(a FLOAT, b FLOAT) 
RETURNS FLOAT
DETERMINISTIC
BEGIN
    DECLARE result FLOAT;
    SET result = a / b;
    RETURN result;
END //
DELIMITER ;

-- Застосування функції до атрибута quantity з order_details
SELECT 
    id,
    order_id,
    product_id,
    quantity,
    divide_floats(quantity, 2.0) AS quantity_divided_by_2
FROM order_details;
