# 📊 Credit Card Complaints Analytics & Monitoring Dashboard

I was curious in understanding and working on a financial data so i have worked on the credit card csv dataset from kaggle and generated this dashboard, a end-to-end Business Intelligence project developed in **Tableau Desktop** and **Excel** on April 2026 analyzing consumer credit card complaints across the United States. This interactive dashboard provides financial operations leaders, compliance teams, and customer experience managers with real-time visibility into complaint volume velocity, top dispute drivers, resolution response efficacy, and channel bottlenecks.

---

##  Tech Stack 

- **Business Intelligence Tool:** Tableau Public Desktop
- **Data Prep :** Microsoft Excel (`.xlsx`)

---

## 📁 Repository Structure
```text
Credit Card Complaints Analytics & Monitoring/
│
├── visuals/
│   └── CREDIT CARD COMPLAINT DASHBOARD.png   # Full-resolution export of the Tableau dashboard
│
├── data/
│   └── CreditCardDataset.xlsx                    # Cleaned underlying complaints dataset (Excel)
│
├── CreditCardComplaintsAnalysis.twb          # Packaged Tableau Workbook
└── README.md                                 # Comprehensive project documentation
```
---

## Key Features & Analytical Views

1. **Executive KPI Summary Cards**
**Total Complaints:** Tracks the macro-level complaint volume at 86,893 total logged entries.   
**Timely Response Performance:** Measures organizational responsiveness, showing an exceptional 98.90% Timely Response Rate, which equates to 85,934 resolved on time.   
**Pending & In-Progress Metrics:** Highlights active caseloads, noting 329 company responses pending or under review, representing 0.38% of total volume currently in progress. 

2. **Temporal Trend Analysis (Trend in Complaints)**
Displays the historical timeline of complaint volume from 2016 through 2021.   
Features a dynamic average line that benchmarks baseline fluctuations, indicating steady complaint generation with occasional spikes over the multi-year span.   

3. **Geographic Complaint Density (Complaint Density Map)**
Utilizes a geospatial Mapbox visualization to plot complaint distribution globally and domestically across the United States.   
Highlights high-density urban and regional clusters while accounting for unmapped or international logs (246 unknown). 

4. **Root Cause Category Breakdown (Top Issues)**
A descending horizontal bar chart isolating the top driver categories behind consumer grievances.   
Identifies Billing disputes as the leading complaint category by a wide margin (14,688 complaints), followed by Other (9,049), Identity theft / Fraud (8,244), Closing/Cancelling account (6,230), and APR or interest rate (5,426).   

5. **Operational Heatmap (Daily Complaints)**
A weekly matrix mapping out distribution volume across days of the month and days of the week (Sunday through Saturday).   
Exposes cyclical high-activity intervals (such as heavier concentrations on specific calendar dates/weeks like the 1st, 8th, and 28th) to assist in workforce scheduling and customer support staffing optimization. 

---

## 💡 Key Strategic Takeaways & Outcomes
- **Exceptional SLA Compliance:** Despite a massive volume of over 86K complaints, customer support and compliance teams maintain a stellar 98.9% timely response rate, proving high operational efficiency and adherence to regulatory timeframes.   

- **Billing Disputes as the Primary Friction Point:** Billing-related grievances dominate consumer complaints (14,688 issues), outperforming the next highest category by more than 60%. Financial institutions should audit current billing transparency, statement clarity, and dispute resolution workflows to curb this primary source of friction.   

- Fraud and Account Management Vulnerabilities: Significant complaint volumes are tied to Identity theft / Fraud (8,244) and Closing/Cancelling accounts (6,230). Proactive security alerts and streamlined self-service account closure options can alleviate these specific pain points. 

- **Predictable Temporal Load Patterns:** Daily and monthly distribution heatmaps reveal recurrent surge cycles. Customer service management can leverage these patterns to dynamically scale support agent shifts ahead of peak volume windows, preventing backlogs and maintaining sub-1% in-progress rates.