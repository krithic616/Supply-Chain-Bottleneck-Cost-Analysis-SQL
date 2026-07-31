# Analysis Results

These results are generated from the representative records in `sample_data.sql`. They demonstrate how the SQL analyses can support operational reviews; they are not production-company figures.

## KPI Summary

| Metric | Result |
|---|---:|
| Average supplier lead time | 8.83 days |
| Total shipping cost | 73,400.00 |
| Average shipping cost per order | 6,116.67 |
| Total orders analysed | 12 |
| Products below reorder level | 4 |
| Suppliers above 7-day lead-time threshold | 3 |

## Key Findings

### Supplier bottlenecks

- Eastern Logistics Supply has the highest configured lead time at 14 days.
- Coastal Manufacturing follows at 12 days.
- Bharat Industrial Supplies records a 9-day lead time.
- These three suppliers exceed the project's seven-day bottleneck threshold.

### Inventory risk

Four products fall below their reorder levels:

| Product | Warehouse | Stock | Reorder level | Shortage |
|---|---|---:|---:|---:|
| Control Sensor | Bengaluru | 18 | 30 | 12 |
| Cooling Fan | Bengaluru | 15 | 25 | 10 |
| Valve Assembly | Hyderabad | 9 | 18 | 9 |
| Hydraulic Pump | Chennai | 12 | 20 | 8 |

### Warehouse inventory value

| Warehouse | Total units | Inventory value |
|---|---:|---:|
| Chennai | 80 | 967,600.00 |
| Bengaluru | 68 | 673,650.00 |
| Hyderabad | 69 | 249,600.00 |

Chennai holds the highest inventory value, making data quality and stock-availability monitoring especially important at that location.

### Shipping and delivery exceptions

- Orders with shipping cost above 7,000 are surfaced for cost review.
- Orders taking more than 10 days are surfaced for delivery-risk review.
- The exception query combines these measures and classifies orders as `Critical`, `Delivery Risk`, `Cost Risk`, or `Normal`.

## Recommended Business Actions

1. Review service-level expectations and corrective plans with suppliers whose lead times exceed seven days.
2. Prioritize replenishment for products below reorder levels, beginning with the largest shortage quantities and highest shortage values.
3. Investigate high-cost shipments by product, supplier, quantity, and delivery duration before changing sourcing or shipping policies.
4. Use warehouse inventory value together with stock-gap analysis to avoid overstocking healthy products while shortage risks remain unresolved.
5. Track average lead time, delayed-order count, stockout-risk count, and shipping cost in a recurring weekly or monthly business review.

## Reproducing the Results

Run the scripts in this order:

```sql
SOURCE schema.sql;
SOURCE sample_data.sql;
SOURCE queries.sql;
```

In MySQL Workbench, the same files can be opened and executed sequentially.
