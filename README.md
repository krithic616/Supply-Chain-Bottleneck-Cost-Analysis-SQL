&nbsp;Supply Chain Bottleneck \& Cost Analysis (SQL)



&nbsp;Project Overview



This project analyzes supply chain operations data to identify bottlenecks, cost drivers, and inventory risks using SQL. The goal is to support business decision-making by detecting delay-prone suppliers, high-cost orders, and low-stock products.



&nbsp;Objectives



\- Identify suppliers causing delivery delays (bottlenecks)

\- Detect products at risk of stockout

\- Analyze high shipping cost orders

\- Rank suppliers based on lead time and cost

\- Evaluate warehouse-wise inventory value

\- Generate operational KPIs using SQL queries



&nbsp;Database Tables



\- suppliers (supplier\_id, supplier\_name, city, lead\_time\_days, cost\_per\_unit)

\- products (product\_id, product\_name, category, supplier\_id, unit\_price)

\- inventory (inventory\_id, product\_id, stock\_quantity, reorder\_level, warehouse\_location)

\- orders (order\_id, product\_id, order\_date, quantity, delivery\_date, shipping\_cost)



&nbsp;Key SQL Analytics



\- Bottleneck supplier analysis using lead time thresholds

\- Inventory risk detection using stock vs reorder level

\- Cost analysis using shipping and unit price data

\- Supplier performance ranking

\- Warehouse-wise inventory valuation

\- Delivery delay analysis using date difference functions



&nbsp;Tools Used



\- MySQL

\- MySQL Workbench



&nbsp;Business Value



This project helps organizations:

\- Reduce delivery delays by identifying slow suppliers

\- Control operational costs by highlighting expensive shipments

\- Prevent stockouts through inventory risk analysis

\- Improve supply chain efficiency using data-driven insights



&nbsp;Files Included



\- queries.sql : SQL queries used for analysis

\- README.md : Project documentation





