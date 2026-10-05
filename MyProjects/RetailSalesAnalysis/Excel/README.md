# Retail Sales & Margin Performance Dashboard - Microsoft Excel

> **Tool:** Microsoft Excel (Power Query, Pivot Tables, Pivot Charts, Slicers, Dynamic Formulas)  
> **Analysis Excel File:** `Retail_sales_analysis.xlsx`  
> **Data Input source:** `data/Sample - Superstore_Raw.csv` (9,994 records)

---

## Project Overview

This project delivers an interactive, lightweight, and scalable retail performance dashboard built entirely in Microsoft Excel on May-June 2026. It offers business stakeholders a single-screen executive control center to analyze sales velocity, regional profitability, sub-category performance, and promotional discount impacts without needing dedicated business intelligence server tools.

---

## Dataset Description

The analysis operates on standard multi-category retail transaction data covering 2014 through 2017:
* **Order Logistics:** `Order ID`, `Order Date`, `Ship Date`, `Ship Mode`.
* **Customer Demographics:** `Customer ID`, `Customer Name`, `Segment`, `City`, `State`, `Postal Code`, `Region`.
* **Product Catalog:** `Product ID`, `Category`, `Sub-Category`, `Product Name`.
* **Financial Metrics:** `Sales`, `Quantity`, `Discount`, `Profit`.

---

## Data Preparation & Engineering Workflow

1. **Table Normalization:** Imported raw CSV data into Excel Table structures (`Table_Superstore`) to allow formula autocompletion and dynamic chart range expansion.
2. **Formula-Driven Fields:**
   * **Fulfillment Turnaround:**
     ```excel
     =[@[Ship Date]] - [@[Order Date]]
     ```
   * **Profit Margin Ratio:**
     ```excel
     =IFERROR([@[Profit]] / [@[Sales]], 0)
     ```
   * **Order Year & Month Period:**
     ```excel
     =TEXT([@[Order Date]], "yyyy-mm")
     ```
   * **Discount Tier Grouping:**
     ```excel
     =IF([@[Discount]]=0, "None", IF([@[Discount]]<=0.2, "0-20%", IF([@[Discount]]<=0.5, "20-50%", ">50%")))
     ```
3. **Data Quality Checks:** Verified zero missing values across monetary columns, standardized currency number formatting, and verified consistency across region classifications.

---

## Excel Pivot Table Architecture

Multiple backend Pivot Tables were generated across dedicated calculation tabs to support the main dashboard:

1. **`pt_KPI_Summary`:** Computes gross sales, net margin, total unit volume, and unique orders.
2. **`pt_Monthly_Trend`:** Groups `Order Date` by Year and Month to track monthly revenue trajectory and holiday peaks.
3. **`pt_Category_Breakdown`:** Calculates Sales, Profit, and Profit Margin % across `Furniture`, `Office Supplies`, and `Technology`.
4. **`pt_SubCategory_Performance`:** Ranks all 17 sub-categories by net profit to highlight winners (Phones, Copiers) and margin leaks (Tables, Bookcases).
5. **`pt_Regional_Share`:** Summarizes revenue contribution across West, East, Central, and South regions.
6. **`pt_Segment_Split`:** Analyzes spend distribution between Consumer, Corporate, and Home Office buyers.

---

## 📊 Excel Retail Sales Dashboard Breakdown

The front-facing dashboard (`RETAIL_SALES_DASHBOARD.png`) features:

1. **Executive Summary KPIs**
Displays core macro-level metrics across the entire dataset: Total Sales ($47,63,385.04), Total Profit ($8,87,418.72), Total Cost ($38,75,966.32), and Total Orders (19,044).   

2. **Interactive Slicers**
**Region Slicer:** Allows users to dynamically filter performance across regions (Central, East, South, West, and N/A).   
**Month Name Slicer:** Enables granular monthly isolation ranging from January to December.   

3. **Regional Performance Analysis (Total Sales by Region)**
A clustered column chart comparing Total Sales against Total Profit across all four geographical zones.   
Highlights the West ($14,57,209.94 in sales / $2,85,636.46 in profit) and East ($14,13,751.54 in sales / $2,69,429.53 in profit) as the dominant regional revenue centers.   

4. **Seasonal Trend Analysis (Total Sales per Month)**
A line chart mapping the progression of sales velocity across the fiscal year.   
Illustrates consistent mid-year fluctuations followed by a sharp upward trajectory culminating in peak revenue months during November ($7,28,528) and December ($8,40,523).   

5. **Product Performance Matrix (Top 10 Products)** 
A horizontal dual-metric bar chart evaluating the top 10 revenue-generating inventory items based on Total Sales and Total Profit.  
Leads with high-performing products such as the GBC Ibimaster 500 Manual ProClick Binding System ($139,122.38 in sales) and identifies isolated margin erosion items (e.g., Chromcraft Bull-Nose Wood Oval Conference Tables & Bases reflecting a net loss).

---

## Key Business Findings & Outcomes

**Q4 Revenue Dependency & Seasonality:** Monthly trend lines prove that revenue heavily peaks toward the end of the calendar year (November and December accounting for over $1.56M combined). Inventory management and marketing campaigns should front-load stock in Q3 to fully capture this year-end surge.   
**Regional Dominance:** The West and East regions drive nearly 60% of total enterprise volume, whereas Central and South show lower performance conversions. Tailored regional marketing initiatives are recommended to stimulate demand in lagging territories.   
**Product-Level Profit Discrepancies:** While top-tier products like the GBC Ibimaster drive exceptional revenue and profit, specific items (such as certain conference tables) operate at a net loss. Auditing pricing strategies or discontinuing low-margin products will protect overall net returns.   
**Effective Financial Scale:** Maintaining an aggregate profit of ~$887K on ~$4.76M in sales translates to a healthy operational margin, supported by granular Excel-based slicing that provides immediate visibility into cost drivers.

---

## Included Files

* `Retail_sales_analysis.xlsx`: Interactive Excel workbook containing raw data, clean data tables, calculation pivot sheets, and the final dashboard.
* `visuals/RETAIL_SALES_DASHBOARD.png`: High-resolution capture of the interactive Excel dashboard.
* `data/Sample - Superstore_Raw.csv`: Source retail transaction dataset.