# 📦 Superstore Sales & Profitability Performance Analysis (Python + PostgreSQL)

An end-to-end data analytics project investigating revenue growth, discount elasticity, regional performance, and product profitability for a multi-region retail superstore. Built using **Python (Pandas)** for data cleansing and analysis, combined with **PostgreSQL** for complex business intelligence queries and analytical reporting.i was worked on this project from July - September 2026 and in this time i have worked on learning more about data analysis using python and refining my sql skills along.

---

## 📌 Executive Summary

While top-line gross sales showed consistent year-over-year expansion across retail operations, operating profit margins exhibited severe variance across product lines and regions. This project diagnoses the root causes behind profit leaks, assesses customer lifetime behavior, and evaluates the diminishing returns of aggressive promotional discounting.

---

## 🛠️ Tech Stack & Methods

- **Data Processing & EDA:** Python (`pandas`, `sqlalchemy`, `psycopg2`)
- **Relational Database:** PostgreSQL 14+
- **SQL Techniques:** Common Table Expressions (CTEs), Window Functions (`DENSE_RANK()`, `ROW_NUMBER()`, `LAG()`, `LEAD()`), Multi-table Self-Joins, `CASE WHEN` logic, and date arithmetic.

---

## 📁 Repository Structure

```text
Superstore_Performance_Analysis/
│
├── superstore/
│   ├── data/
│   │   └── superstore.csv                             # Raw & standardized transactional dataset
│   │
│   ├── SuperstoreAnalysisPython.ipynb                 # Interactive Jupyter Notebook for EDA & cleaning 
│   ├── SuperstoreAnalysis_QueryScriptPostgreSQL.sql   # 20 business queries & window functions
│   │
│   └── visuals/
│       ├── Python/                                    # missing value checks, summary stats
│       │   ├── ColumnsPreview.png
│       │   ├── DatasetCleaning.png
│       │   ├── DatasetLoading(1).png
│       │   ├── DatasetLoading(2).png
│       │   ├── MissingValue.png
│       │   ├── Overview(sales&profit).png
│       │   ├── QuickView.png
│       │   └── SummaryStatistics.png 
│       │   ├── SuperstoreAnalysisPython.html                  # Static HTML export of the notebook execution
        │
│       └── sql/                                       # Query execution outputs & result grids(17 images for a quick glance)
│           ├── PostgreSQL_question4.png
│           ├── PostgreSQL_question5.png
│           ├── ...
│           └── PostgreSQL_question20.png
│
└── README.md                                          # Project documentation
```

---

## 🔍 Key Business Inquiries & SQL Implementations

The SQL suite (`SuperstoreAnalysis_QueryScriptPostgreSQL.sql`) answers 20 operational questions, organized into four strategic pillars:
- What is the overall macro-level performance of the Superstore in terms of total revenue, profitability, and order volume across the analyzed timeframe?   
- What is the structural condition of the raw dataset, and what data cleaning procedures are necessary to prepare the data for downstream querying and PostgreSQL integration?   
- What new temporal and operational attributes can be engineered to extract granular insights regarding delivery speeds and profit margins?   
- What do the baseline statistical distributions (such as means, standard deviations, and quartiles) reveal about sales dispersion, discounting, and fulfillment timelines?

### Data Maintenance & Hygiene: 
- How can database records be dynamically managed, such as inserting new corporate clients, adjusting promotional discounts for low-selling items, and purging orphaned records?   

###  Profitability & Margin Segmentation: 
- How can transactions be categorized into distinct performance tiers (High Margin, Breakeven, Loss Making) to pinpoint financial health?   

### Category & Sub-Category Optimization: 
- Which product categories and sub-categories yield the highest net profits, and conversely, which sub-categories drive heavy financial losses?   

### Logistics & Fulfillment Efficiency: 
- Which regional territories experience average shipping delivery lags exceeding 4 days, and how do shipping mode preferences vary across customer segments?   

### Customer Value & Segmentation: 
- Who are the high-value customers generating substantial lifetime spend, and how can customers be effectively distributed into spend quartiles using advanced window functions like NTILE?   

### Advanced Temporal Trends: 
- What do monthly cumulative revenues, Month-over-Month (MoM) growth rates (LAG), and Year-over-Year (YoY) segment comparisons reveal about business trajectory?   

### Discount Impact & Margin Leakage: 
- How do varying discount thresholds (from 0% up to >40%) directly impact gross profit margins and overall profitability?   

### Product Concentration & Cross-Selling: 
- Which key products drive 80% of total revenue in alignment with the Pareto Principle, and which product categories are most frequently co-purchased?   

### Geographic Anomalies: 
- Which cities record high sales volumes yet suffer from negative net margins, highlighting localized pricing or discounting inefficiencies?   

---

## 📋 Summary of Findings

1. **Data Scale & Foundation:** Processed 9,994 retail transactions (2015–2018) with complete data integrity (0 missing values), engineering advanced features like delivery days and profit margins.   

2. **Macro Financial Health:** Generated $2,297,201 in total sales and $286,397 in net profit, achieving an overall 12.5% profit margin across 5,009 orders and 793 unique customers.   

3. **Advanced Segmentation & Ranking:** Applied SQL window functions (DENSE_RANK, NTILE) to isolate top-tier products and group customers into spend quartiles for targeted engagement.   

4. **Profit Leakage & Discounts:** Uncovered severe margin erosion from heavy discounting (>40%) and identified specific loss-making sub-categories and cities with negative net returns.  

5. **Operations & Concentration:** Tracked a 4.0-day average delivery lag, utilized Pareto analysis to confirm revenue concentration among top products, and identified high-value customers exceeding $10,000 in lifetime spend. 

---

## 🚀 How to Run the Project

### Prerequisites
- Python 3.9+
- Jupyter Notebook / JupyterLab
- PostgreSQL database client (pgAdmin, DBeaver, or psql)

### Step 1: Run the Python Analysis
```bash
git clone https://github.com/your-username/Superstore_Performance_Analysis.git
cd Superstore_Performance_Analysis/superstore
pip install pandas jupyter sqlalchemy 
jupyter notebook SuperstoreAnalysisPython.ipynb
```

### Step 2: Run the PostgreSQL Analysis
1. Open your PostgreSQL client and create a database:
   ```sql
   CREATE DATABASE superstore_db;
   ```
2. Import `Superstore_Performance_Analysis/data/superstore.csv` into a table named `superstore`.
3. Open and execute `SuperstoreAnalysis_QueryScriptPostgreSQL.sql` to generate the analytical reporting outputs.

---