# Supply Chain Bottleneck & Cost Analysis — SQL

## Project Overview

This project uses MySQL to analyse representative supply-chain operations data across suppliers, products, inventory, warehouses, and orders. It identifies supplier bottlenecks, stockout exposure, costly shipments, delivery delays, and warehouse inventory concentration so that operational teams can make evidence-based decisions.

The repository is designed to be reproducible: it includes the database schema, sample data, analytical queries, and documented results.

## Business Questions

- Which suppliers create lead-time bottlenecks?
- Which products are below their reorder levels?
- Which orders have unusually high shipping costs?
- Which deliveries exceed the expected duration?
- How much inventory value is held at each warehouse?
- Which suppliers perform best on lead time and cost?
- What operational exceptions should be prioritised for review?

## Data Model

The project uses four related tables:

| Table | Purpose |
|---|---|
| `suppliers` | Supplier location, lead time, and unit-cost information |
| `products` | Product category, supplier relationship, and unit price |
| `inventory` | Stock quantity, reorder level, and warehouse location |
| `orders` | Order quantity, dates, and shipping cost |

Relationships:

- One supplier can supply multiple products.
- One product can have inventory records and multiple orders.
- Foreign keys enforce consistency across the model.

## SQL Analysis Included

The query set covers:

- Supplier bottleneck detection using lead-time thresholds
- Product stockout-risk and shortage-quantity analysis
- High-shipping-cost order identification
- Average lead-time and shipping-cost KPIs
- Warehouse-level stock and inventory valuation
- Supplier ranking with SQL window functions
- Delivery-delay analysis using `DATEDIFF`
- Inventory status classification using `CASE`
- Supplier-level delivery and shipping performance
- Estimated inventory value exposed to shortages
- Order exception classification for business review

## Tools and Techniques

- MySQL 8.0+
- MySQL Workbench
- SQL joins and aggregations
- Common KPI calculations
- Window functions
- Conditional logic
- Date analysis
- Data validation through keys and constraints

## Repository Structure

```text
.
├── README.md          # Project documentation
├── schema.sql         # Database, tables, keys, and indexes
├── sample_data.sql    # Representative records for reproducible analysis
├── queries.sql        # Fifteen business-focused SQL analyses
└── RESULTS.md         # Findings, KPI summary, and recommendations
```

## How to Run the Project

### MySQL command line

```sql
SOURCE schema.sql;
SOURCE sample_data.sql;
SOURCE queries.sql;
```

### MySQL Workbench

1. Open and execute `schema.sql`.
2. Open and execute `sample_data.sql`.
3. Open and execute `queries.sql`.
4. Compare the outputs with `RESULTS.md`.

The schema script drops and recreates the project tables, so it can be rerun safely against the project database.

## Example KPI Results

The included representative dataset produces:

| KPI | Result |
|---|---:|
| Average supplier lead time | 8.83 days |
| Total shipping cost | 73,400.00 |
| Products below reorder level | 4 |
| Suppliers above the 7-day threshold | 3 |

Detailed outputs and interpretations are documented in [`RESULTS.md`](RESULTS.md).

## Business Recommendations

- Review corrective actions with suppliers exceeding agreed lead-time thresholds.
- Prioritise replenishment using shortage quantity and estimated shortage value.
- Investigate orders that combine high shipping cost with long delivery duration.
- Monitor inventory value and stock gaps together to balance availability and working capital.
- Include lead time, shipping cost, stockout risk, and delayed-order metrics in recurring operational reviews.

## Business Value

This analysis demonstrates how SQL can help teams:

- Reduce delivery delays
- Detect inventory risks before stockouts occur
- Control shipping and operating costs
- Compare supplier performance
- Improve warehouse visibility
- Convert operational data into actionable recommendations

## Data Note

The records in `sample_data.sql` are synthetic and included only to demonstrate the analysis. The project does not represent confidential or production data from any organisation.
