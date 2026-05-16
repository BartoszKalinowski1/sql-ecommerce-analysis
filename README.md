# Brazilian E-Commerce Analysis (PostgreSQL)

## Project Overview
This project provides a comprehensive analysis of 100k+ orders from the Olist e-commerce platform in Brazil (2016-2018). The goal was to transform raw data into actionable business insights regarding sales performance, logistics, and customer behavior.

## Tech Stack
* **Database:** PostgreSQL
* **Infrastructure:** Docker & Docker Compose
* **Tools:** SQL, Git, Git Bash

## Key SQL Features Demonstrated
* **Advanced Joins & Aggregations:** Merging multiple tables to build a wide view of the business.
* **Window Functions:** Utilizing `DENSE_RANK()` to identify top-performing products within each category.
* **Time Series Analysis:** Using `DATE_TRUNC` and `EXTRACT` to find seasonal trends and peak shopping hours.
* **Common Table Expressions (CTEs):** Writing clean, modular, and readable SQL code.

## Key Insights & Results

### 1. Monthly Revenue Trend
The data reveals a massive spike in **November 2017**, corresponding to **Black Friday**, where revenue exceeded 1.18M BRL.
| Month | Total Orders | Monthly Revenue (BRL) |
|:--- |:--- |:--- |
| 2017-10-01 | 4,829 | 773,104.35 |
| **2017-11-01** | **7,826** | **1,187,224.36** |
| 2017-12-01 | 5,884 | 874,962.23 |

### 2. Logistics & Delivery Performance
Identified significant delivery delays in northern states. For example, **Alagoas (AL)** often shows higher late delivery percentages compared to southern regions due to distribution distance.

### 3. Peak Shopping Hours
The most active shopping window is between **10:00 AM and 2:00 PM**, suggesting that customers frequently shop during lunch breaks.

### 4. Top Products by Category (Window Function)
Using `DENSE_RANK()`, I identified the Top 3 products for over 70 categories. 
*Example for 'alimentos' (Food):*
| Category | Product ID | Units Sold | Rank |
|:--- |:--- |:--- |:--- |
| alimentos | 89321f94... | 119 | 1 |
| alimentos | ed2067a9... | 55 | 2 |
| alimentos | 73326828... | 54 | 3 |

### 5. Customer Lifetime Value (CLV)
Top 10 customers were identified based on their total historical spend, allowing for targeted VIP loyalty programs.

## How to Run
This project is fully containerized. To replicate the analysis:

1. **Start the database:**
   ```bash
   docker-compose up -d
2. **Execute all queries:**
    ```bash
    docker exec -it ecommerce_db_container psql -U user -d ecommerce_db -c "$(cat queries.sql)"

## Data Source
The dataset used is the [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce) available on Kaggle.