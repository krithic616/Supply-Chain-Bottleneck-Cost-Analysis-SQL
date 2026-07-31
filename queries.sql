-- Supply Chain Bottleneck & Cost Analysis
-- Run schema.sql and sample_data.sql before executing this file.
USE supply_chain_analytics;

-- 1. Identify bottleneck suppliers with lead times above seven days.
SELECT
    supplier_id,
    supplier_name,
    city,
    lead_time_days,
    cost_per_unit
FROM suppliers
WHERE lead_time_days > 7
ORDER BY lead_time_days DESC;

-- 2. Detect products at risk of stockout.
SELECT
    p.product_id,
    p.product_name,
    p.category,
    i.warehouse_location,
    i.stock_quantity,
    i.reorder_level,
    i.reorder_level - i.stock_quantity AS shortage_quantity
FROM inventory AS i
JOIN products AS p
    ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level
ORDER BY shortage_quantity DESC;

-- 3. Identify orders with shipping costs above the project threshold.
SELECT
    o.order_id,
    p.product_name,
    o.quantity,
    o.shipping_cost
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
WHERE o.shipping_cost > 7000
ORDER BY o.shipping_cost DESC;

-- 4. Calculate the average supplier lead-time KPI.
SELECT
    ROUND(AVG(lead_time_days), 2) AS average_lead_time_days
FROM suppliers;

-- 5. Calculate inventory value by warehouse.
SELECT
    i.warehouse_location,
    SUM(i.stock_quantity) AS total_units,
    ROUND(SUM(i.stock_quantity * p.unit_price), 2) AS total_inventory_value
FROM inventory AS i
JOIN products AS p
    ON i.product_id = p.product_id
GROUP BY i.warehouse_location
ORDER BY total_inventory_value DESC;

-- 6. Rank suppliers by lead time and cost per unit.
SELECT
    supplier_id,
    supplier_name,
    lead_time_days,
    cost_per_unit,
    DENSE_RANK() OVER (ORDER BY lead_time_days ASC) AS lead_time_rank,
    DENSE_RANK() OVER (ORDER BY cost_per_unit ASC) AS cost_rank
FROM suppliers
ORDER BY lead_time_rank, cost_rank;

-- 7. Identify orders with delivery times above ten days.
SELECT
    o.order_id,
    p.product_name,
    o.order_date,
    o.delivery_date,
    DATEDIFF(o.delivery_date, o.order_date) AS delivery_days,
    o.shipping_cost
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
WHERE DATEDIFF(o.delivery_date, o.order_date) > 10
ORDER BY delivery_days DESC, o.shipping_cost DESC;

-- 8. List the most expensive products.
SELECT
    product_id,
    product_name,
    category,
    unit_price
FROM products
ORDER BY unit_price DESC;

-- 9. Measure stock position against reorder levels.
SELECT
    p.product_id,
    p.product_name,
    i.warehouse_location,
    i.stock_quantity,
    i.reorder_level,
    i.stock_quantity - i.reorder_level AS stock_gap,
    CASE
        WHEN i.stock_quantity < i.reorder_level THEN 'At Risk'
        WHEN i.stock_quantity = i.reorder_level THEN 'At Threshold'
        ELSE 'Healthy'
    END AS inventory_status
FROM inventory AS i
JOIN products AS p
    ON i.product_id = p.product_id
ORDER BY stock_gap ASC;

-- 10. Calculate total and average shipping-cost KPIs.
SELECT
    ROUND(SUM(shipping_cost), 2) AS total_shipping_cost,
    ROUND(AVG(shipping_cost), 2) AS average_shipping_cost,
    COUNT(*) AS total_orders
FROM orders;

-- 11. Count products supplied by each supplier.
SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(p.product_id) AS total_products
FROM suppliers AS s
LEFT JOIN products AS p
    ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY total_products DESC, s.supplier_name;

-- 12. Summarize stock by warehouse.
SELECT
    warehouse_location,
    SUM(stock_quantity) AS total_stock,
    SUM(reorder_level) AS total_reorder_level,
    SUM(stock_quantity - reorder_level) AS net_stock_gap
FROM inventory
GROUP BY warehouse_location
ORDER BY total_stock DESC;

-- 13. Analyze supplier-level delivery and shipping performance.
SELECT
    s.supplier_id,
    s.supplier_name,
    COUNT(o.order_id) AS total_orders,
    ROUND(AVG(DATEDIFF(o.delivery_date, o.order_date)), 2) AS average_delivery_days,
    ROUND(SUM(o.shipping_cost), 2) AS total_shipping_cost,
    ROUND(AVG(o.shipping_cost), 2) AS average_shipping_cost
FROM suppliers AS s
JOIN products AS p
    ON s.supplier_id = p.supplier_id
JOIN orders AS o
    ON p.product_id = o.product_id
GROUP BY s.supplier_id, s.supplier_name
ORDER BY average_delivery_days DESC, total_shipping_cost DESC;

-- 14. Quantify the inventory value exposed to stockout risk.
SELECT
    i.warehouse_location,
    COUNT(*) AS at_risk_products,
    SUM(i.reorder_level - i.stock_quantity) AS total_shortage_units,
    ROUND(SUM((i.reorder_level - i.stock_quantity) * p.unit_price), 2) AS estimated_shortage_value
FROM inventory AS i
JOIN products AS p
    ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level
GROUP BY i.warehouse_location
ORDER BY estimated_shortage_value DESC;

-- 15. Create an order-level exception report for business review.
SELECT
    o.order_id,
    p.product_name,
    s.supplier_name,
    DATEDIFF(o.delivery_date, o.order_date) AS delivery_days,
    o.shipping_cost,
    CASE
        WHEN DATEDIFF(o.delivery_date, o.order_date) > 10
             AND o.shipping_cost > 7000 THEN 'Critical'
        WHEN DATEDIFF(o.delivery_date, o.order_date) > 10 THEN 'Delivery Risk'
        WHEN o.shipping_cost > 7000 THEN 'Cost Risk'
        ELSE 'Normal'
    END AS exception_status
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
JOIN suppliers AS s
    ON p.supplier_id = s.supplier_id
ORDER BY
    CASE
        WHEN DATEDIFF(o.delivery_date, o.order_date) > 10
             AND o.shipping_cost > 7000 THEN 1
        WHEN DATEDIFF(o.delivery_date, o.order_date) > 10 THEN 2
        WHEN o.shipping_cost > 7000 THEN 3
        ELSE 4
    END,
    delivery_days DESC;
