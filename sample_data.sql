-- Representative sample data for the Supply Chain Bottleneck & Cost Analysis project
USE supply_chain_analytics;

INSERT INTO suppliers (supplier_id, supplier_name, city, lead_time_days, cost_per_unit) VALUES
(1, 'Apex Components', 'Chennai', 5, 420.00),
(2, 'Bharat Industrial Supplies', 'Bengaluru', 9, 510.00),
(3, 'Coastal Manufacturing', 'Coimbatore', 12, 465.00),
(4, 'Delta Tech Parts', 'Hyderabad', 7, 620.00),
(5, 'Eastern Logistics Supply', 'Kolkata', 14, 390.00),
(6, 'Frontline Components', 'Pune', 6, 550.00);

INSERT INTO products (product_id, product_name, category, supplier_id, unit_price) VALUES
(101, 'Drive Motor', 'Electrical', 1, 12500.00),
(102, 'Control Sensor', 'Electronics', 2, 4800.00),
(103, 'Hydraulic Pump', 'Mechanical', 3, 18200.00),
(104, 'Power Relay', 'Electrical', 4, 3200.00),
(105, 'Cooling Fan', 'Mechanical', 5, 2750.00),
(106, 'Circuit Module', 'Electronics', 2, 8900.00),
(107, 'Valve Assembly', 'Mechanical', 3, 6400.00),
(108, 'Battery Pack', 'Electrical', 6, 15600.00);

INSERT INTO inventory (inventory_id, product_id, stock_quantity, reorder_level, warehouse_location) VALUES
(1001, 101, 40, 25, 'Chennai'),
(1002, 102, 18, 30, 'Bengaluru'),
(1003, 103, 12, 20, 'Chennai'),
(1004, 104, 60, 35, 'Hyderabad'),
(1005, 105, 15, 25, 'Bengaluru'),
(1006, 106, 28, 22, 'Chennai'),
(1007, 107, 9, 18, 'Hyderabad'),
(1008, 108, 35, 20, 'Bengaluru');

INSERT INTO orders (order_id, product_id, order_date, quantity, delivery_date, shipping_cost) VALUES
(5001, 101, '2026-01-03', 10, '2026-01-09', 3000.00),
(5002, 102, '2026-01-05', 25, '2026-01-17', 8500.00),
(5003, 103, '2026-01-08', 8, '2026-01-22', 7200.00),
(5004, 104, '2026-01-10', 30, '2026-01-15', 2500.00),
(5005, 105, '2026-01-12', 20, '2026-01-27', 9100.00),
(5006, 106, '2026-01-15', 15, '2026-01-23', 6800.00),
(5007, 107, '2026-01-16', 12, '2026-02-01', 10500.00),
(5008, 108, '2026-01-18', 6, '2026-01-24', 2000.00),
(5009, 101, '2026-02-02', 7, '2026-02-10', 3400.00),
(5010, 102, '2026-02-04', 18, '2026-02-16', 7900.00),
(5011, 103, '2026-02-06', 5, '2026-02-21', 9800.00),
(5012, 104, '2026-02-09', 22, '2026-02-14', 2700.00);
