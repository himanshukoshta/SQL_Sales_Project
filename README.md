# 📊 Sales Data Analysis Project (`sql_project_1`)

An end-to-end SQL data analysis project that explores retail sales performance, customer purchasing behavior, regional distribution, delivery efficiency, and financial growth trends using advanced SQL queries.

---

## 🛠️ Project Structure & Schema

The database contains a single main table, `sales_projects`, designed to capture transaction details, customer demographics, financial metrics, and operational performance.

---

### Table Schema:
CREATE TABLE sales_projects (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    product_category VARCHAR(15),
    region VARCHAR(10),
    quantity INT,
    unit_price FLOAT,
    discount FLOAT,
    payment_method VARCHAR(15),
    delivery_days INT,
    customer_rating FLOAT,
    revenue FLOAT
);

---

## 🧹 Data Cleaning & Preprocessing

Before diving into analysis, data integrity checks were performed to ensure robust results:
* **Null Value Inspection:** Scanned all critical columns for missing or null values.
* **Data Sanitization:** Cleaned and removed incomplete records within the `order_id` range of `10001` to `15000` where crucial fields contained null values.

---

## 📈 Key Performance Indicators (KPIs) & Business Insights

The project extracts core business metrics to evaluate overall health and performance:
* **Total Orders & Unique Customers:** Tracking customer reach and transaction volume.
* **Total Revenue & Average Order Value (AOV):** Monitoring financial inflow.
* **Total Quantity Sold & Category Variety:** Understanding product portfolio breadth.

### Key Analytical Queries Addressed:
1. **Monthly Revenue Trends:** Tracking seasonality and monthly revenue growth.
2. **Category & Regional Analysis:** Identifying top-performing product categories across different regions.
3. **Top 10 Customers:** Pinpointing high-value customers using CTEs and sorting limits.
4. **Regional Revenue Ranking:** Utilizing window functions (`DENSE_RANK()`) to rank regions by revenue contribution.
5. **Discount Analysis:** Determining which product categories receive the highest average discounts.
6. **Revenue Contribution %:** Calculating each category's relative percentage share of total revenue.
7. **Delivery Efficiency & Customer Satisfaction:** Assessing delivery times by region and correlating delivery duration brackets with customer ratings using conditional logic (`CASE`).
8. **Customer Retention:** Identifying repeat buyers who have placed more than one order.
9. **Payment Method Performance:** Evaluating revenue generation and customer satisfaction scores across different payment modes.
10. **Month-over-Month (MoM) Growth:** Calculating revenue growth trends using SQL window functions (`LAG()`).

---

## 🚀 Getting Started

To run these queries locally:
1. Clone or download the SQL script into your SQL environment (MySQL compatible).
2. Execute the database creation and table setup statements.
3. Import your dataset into the `sales_projects` table.
4. Run the data cleaning, KPI extraction, and exploratory data analysis scripts sequentially.
