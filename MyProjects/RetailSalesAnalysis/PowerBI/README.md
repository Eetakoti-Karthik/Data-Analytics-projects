# Retail Sales & Profitability Analysis - Power BI

> **Tool:** Microsoft Power BI Desktop, Power Query, DAX  
> **Dataset:** `Sample - Superstore_Raw.csv` (9,994 transaction records, 21 fields) from kaggle
> **Model:** Star Schema (1 Fact Table, 5 Dimension Tables)

---

## Why This Retail Sales Project in Power BI?

I was very interested in exploring and performing data analysis on a sales dataset so i choose this Sample superstore csv dataset from kaggle on June-July 2026 and, While top-line gross revenue often looks impressive on surface-level reports, businesses succeed or fail on net operating margins and cash flow efficiency. I wanted to build an end-to-end analytical reporting suite that moves beyond cosmetic metrics to uncover **profit leakage, aggressive discounting traps, regional fulfillment disparities, and customer tier value**.

While this retail analysis was initially prototyped in Excel, transitioning to Power BI unlocked advanced capabilities like a robust star schema data model, interactive AI drilldowns, time-animated scatter plots, and seamless multi-dashboard navigation. 
Power BI's scalable architecture and dynamic filtering vastly improve performance and user engagement for complex enterprise-grade data visualization. Using Power BI, I engineered an enterprise-ready dimensional model (Star Schema) and built four interconnected reporting pages that enable stakeholders to drill from executive macro KPIs all the way down to individual SKU-level profitability.

---

## Dataset Schema & Field Descriptions

| Column | Data Type | Description |
| :--- | :--- | :--- |
| `Row ID` | Integer | Sequential transaction row index. |
| `Order ID` | String | Unique transactional purchase identifier. |
| `Order Date` | Date | Date when purchase was completed. |
| `Ship Date` | Date | Date when consignment was dispatched. |
| `Ship Mode` | String | Fulfillment speed tier (`Standard Class`, `Second Class`, `First Class`, `Same Day`). |
| `Customer ID` | String | Persistent unique identifier per customer. |
| `Customer Name`| String | Customer legal / registered name. |
| `Segment` | String | Target demographic (`Consumer`, `Corporate`, `Home Office`). |
| `Country` | String | Country jurisdiction (`United States`). |
| `City` | String | Delivery municipality. |
| `State` | String | US Destination State. |
| `Postal Code` | String | Postal code (stored as text with zero-padding). |
| `Region` | String | Geographic market division (`West`, `East`, `Central`, `South`). |
| `Product ID` | String | Unique product catalog SKU. |
| `Category` | String | Macro product division (`Technology`, `Furniture`, `Office Supplies`). |
| `Sub-Category` | String | Product group (`Chairs`, `Storage`, `Tables`, `Phones`, `Binders`, etc.). |
| `Product Name` | String | Complete SKU catalog description. |
| `Sales` | Decimal | Gross transaction revenue ($). |
| `Quantity` | Integer | Total unit volume per line item. |
| `Discount` | Decimal | Applied promotional discount rate (0.00 to 0.80). |
| `Profit` | Decimal | Net operating margin realized ($). |

---

## Data Transformation & Modeling (Power Query)

1. **Type Normalization & Postal Code Fixing:** Ensured `Postal Code` remained text to prevent dropped leading zeros. Converted date strings into ISO date types.
2. **Turnaround Duration Field:** Engineered `[Delivery Days] = DATEDIFF([Order Date], [Ship Date], DAY)`.
3. **Star Schema Architecture:**
   * **Fact Table (`Fact_Sales`):** Contains transactional keys (`Order ID`, `Customer ID`, `Product ID`, `Postal Code`, `Order Date`) and numeric metrics (`Sales`, `Profit`, `Discount`, `Quantity`, `Delivery Days`).
   * **Dimension Tables:**
     * `Dim_Customer` (`Customer ID`, `Customer Name`, `Segment`)
     * `Dim_Product` (`Product ID`, `Product Name`, `Category`, `Sub-Category`)
     * `Dim_Location` (`Postal Code`, `City`, `State`, `Region`, `Country`)
     * `Dim_Calendar` (Continuous Date table with Year, Quarter, Month, Weekday, Fiscal periods)
   * **Cardinality:** Strict 1-to-many ($1:*$) single-direction filter flows from dimensions to `Fact_Sales`.

---

## Core DAX Measures

```dax
// 1. Total Revenue
Total Sales = SUM(Fact_Sales[Sales])

// 2. Net Profit
Total Profit = SUM(Fact_Sales[Profit])

// 3. Margin Percentage
Profit Margin % = DIVIDE([Total Profit], [Total Sales], 0)

// 4. Order Volume
Total Orders = DISTINCTCOUNT(Fact_Sales[Order ID])

// 5. Average Order Value (AOV)
AOV = DIVIDE([Total Sales], [Total Orders], 0)

// 6. Average Delivery SLA
Avg Fulfillment Days = AVERAGE(Fact_Sales[Delivery Days])

```

---
## 📊  Data Modeling & Architecture
The project is built on a robust Star Schema architecture designed for optimal analytical performance and efficient querying:   
1. **Fact Table (Fact_Sales):** Positioned at the center, tracking transactional metrics including Sales, Profit, Quantity, Discount, Profit Margin, Order ID, Customer ID, and Product ID. 

2. **Dimension Tables:** Surrounding the fact table are clean dimension tables (Dim_Customer, Dim_Product, Dim_Location, Dim_Date, and Dim_Calendar) that establish clear one-to-many relationships for slicing and dicing data across categories, regions, and timelines.   

## 🖥️ Dashboard Breakdown
1. Home Dashboard: Retail Sales Analysis 
**Executive KPIs:** Displays high-level macro metrics including Total Sales ($4.77M), Total Cost ($4.16M), Total Profit ($611.4K), Total Orders (5.009K), and Average Profit ($122).   
**Sales Trends & Geography:** Features a monthly sales trajectory showing strong peaks toward year-end, a U.S. geographic map (Sales by State), and regional breakdowns (Sales by Region showing West at 31% and East at 30%).   
**Top Performance Elements:** Highlights the top 10 products (e.g., GBC Ibimaster leading at $139K) and top cities (New York City and Los Angeles leading revenue) alongside filters for Categories and Regions.   

2. Executive Sales & Profit Strategy Dashboard
**Profitability Health:** Focuses on core financial strategy, featuring a 12.8% Profit Margin alongside total sales and profit metrics.   
**Seasonal Trends & Category Distribution:** Includes a dual-metric seasonal trend line charting Total Sales vs. Total Profit, and a revenue distribution treemap categorized by Furniture, Technology, and Office Supplies.   
**AI Drilldown Insights:** Utilizes automated AI breakdown visuals to instantly decompose profit drivers by product category and regional performance.   

3. Customer Value & Inventory Optimization Dashboard 
**Customer Segmentation & VIP Tracking:** Features a dedicated Top 20 VIP Buyers table led by high-value customers like Adrian Barton ($136.22K in sales) and Bill Shonely ($70.42K).   
**Product Lifecycle & Scatter Analysis:** Implements a time-animated scatter plot to track product performance across multiple fiscal years (2014 to 2018).   

4. Operations, Logistics & Discount Audit Dashboard
**Fulfillment Efficiency:** Tracks operational friction with an Average Delivery Days metric of 3.96 days, breaking down delivery duration across shipping modes (Standard Class averaging 5 days, Second Class, First Class, and Same Day).   
**Margin Leakage & Discount Impact:** Uses a waterfall chart to display how discounts impact profitability across various sub-categories (Storage, Chairs, Phones, Accessories), offering clear visibility into profit erosion and margin leakage.   

---

## Key Strategic Takeaways & Outcomes
1. **Seasonality and Year-End Revenue Surges:** Sales data reveals sharp surges during the final months of the year (November and December hitting up to $0.84M in monthly sales), indicating that inventory stocking and marketing campaigns should be heavily ramped up in Q3 to maximize Q4 capture.   

2. **Geographic Revenue Concentration:** The West (31%) and East (30%) regions dominate the revenue share, with major metropolitan areas like New York City ($555K) and Los Angeles ($386K) acting as core revenue hubs. Regional logistics and marketing should prioritize strengthening supply chains in these primary corridors.   

3. **High-Value Customer Dependency:** A small tier of VIP buyers drives significant value (e.g., top consumer Adrian Barton generating over $136K). Implementing targeted loyalty tiers and personalized retention frameworks will safeguard these high-margin revenue streams.   

4. **Logistics Bottlenecks in Standard Shipping:** Standard Class handles the highest volume of fulfillment but suffers from a longer turnaround time averaging 5.00 days compared to First Class and Same Day options. Streamlining warehouse fulfillment workflows can significantly improve customer satisfaction ratings.   

5. **Discount-Induced Margin Leakage:** The discount audit waterfall chart uncovers specific sub-categories where aggressive discounting erodes net profitability. Establishing tighter discounting guardrails and dynamic pricing rules will help protect overall profit margins (currently sitting at 12.8%).

---

## Directory Files

* `Retail_sales_PowerBI.pbix` - Interactive multi-page Power BI report.
* `data/Sample - Superstore_Raw.csv` - Transactional source dataset.
* `visuals/All Dashbords.pdf` - High-resolution PDF export of all report pages.
* `visuals/DATA MODELLING-STAR SCHEMA.png` - Visual architecture of the relational schema(Data Model).
* `visuals/DASHBOARD 1-4.png` - Full-resolution page screenshots of Dashbords for quick review.