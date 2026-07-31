-- Supply Chain Bottleneck & Cost Analysis
-- MySQL 8.0+

CREATE DATABASE IF NOT EXISTS supply_chain_analytics;
USE supply_chain_analytics;

-- Drop child tables first so the script can be rerun safely.
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS suppliers;

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    city VARCHAR(80) NOT NULL,
    lead_time_days INT NOT NULL,
    cost_per_unit DECIMAL(12, 2) NOT NULL
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(120) NOT NULL,
    category VARCHAR(80) NOT NULL,
    supplier_id INT NOT NULL,
    unit_price DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_products_supplier
        FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE inventory (
    inventory_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    stock_quantity INT NOT NULL,
    reorder_level INT NOT NULL,
    warehouse_location VARCHAR(80) NOT NULL,
    CONSTRAINT fk_inventory_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT NOT NULL,
    order_date DATE NOT NULL,
    quantity INT NOT NULL,
    delivery_date DATE NOT NULL,
    shipping_cost DECIMAL(12, 2) NOT NULL,
    CONSTRAINT fk_orders_product
        FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Indexes support the joins, filters, and date-based analyses in queries.sql.
CREATE INDEX idx_products_supplier_id ON products(supplier_id);
CREATE INDEX idx_inventory_product_id ON inventory(product_id);
CREATE INDEX idx_inventory_warehouse ON inventory(warehouse_location);
CREATE INDEX idx_orders_product_id ON orders(product_id);
CREATE INDEX idx_orders_order_date ON orders(order_date);
CREATE INDEX idx_orders_delivery_date ON orders(delivery_date);
