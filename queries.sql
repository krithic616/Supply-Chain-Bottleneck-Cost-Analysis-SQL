
 Supply Chain Bottleneck & Cost Analysis (SQL)


 1. Identify bottleneck suppliers (high lead time)

 SELECT supplier_name, lead_time_days
 FROM suppliers
 WHERE lead_time_days > 7;


 2. Products at risk of stockout (low stock)

SELECT p.product_name, i.stock_quantity, i.reorder_level
FROM inventory i
JOIN products p ON i.product_id = p.product_id
WHERE i.stock_quantity < i.reorder_level;


 3. High shipping cost orders

 SELECT order_id, product_id, shipping_cost
 FROM orders
 WHERE shipping_cost > 7000;


 4. Average supplier lead time (KPI)

SELECT AVG(lead_time_days) AS avg_lead_time_days
FROM suppliers;


 5. Total inventory value by warehouse

SELECT i.warehouse_location,
 SUM(i.stock_quantity * p.unit_price) AS total_inventory_value
FROM inventory i
JOIN products p ON i.product_id = p.product_id
GROUP BY i.warehouse_location;


 6. Supplier performance ranking (CORRECTED QUERY)

SELECT supplier_name, lead_time_days, cost_per_unit
FROM suppliers
ORDER BY lead_time_days ASC;


 7. Orders with long delivery time (delay risk)

SELECT order_id, product_id, order_date, delivery_date,
       DATEDIFF(delivery_date, order_date) AS delivery_days
FROM orders
WHERE DATEDIFF(delivery_date, order_date) > 10;


 8. Most expensive products

SELECT product_name, unit_price
FROM products
ORDER BY unit_price DESC;


 9. Inventory gap analysis (stock vs reorder level)

SELECT p.product_name,
       i.stock_quantity,
       i.reorder_level,
       (i.stock_quantity - i.reorder_level) AS stock_gap
FROM inventory i
JOIN products p ON i.product_id = p.product_id;


 10. Total shipping cost (overall cost metric)

SELECT SUM(shipping_cost) AS total_shipping_cost
FROM orders;


 11. Supplier-wise product count

SELECT s.supplier_name, COUNT(p.product_id) AS total_products
FROM suppliers s
JOIN products p ON s.supplier_id = p.supplier_id
GROUP BY s.supplier_name;


 12. Warehouse-wise stock summary

SELECT warehouse_location, SUM(stock_quantity) AS total_stock
FROM inventory
GROUP BY warehouse_location;
