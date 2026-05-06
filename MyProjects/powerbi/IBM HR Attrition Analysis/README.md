 IBM HR Attrition Dashboard-
> Tool: I have used Power BI Desktop application to create this dashboard.
> Dataset: In this IBM HR Dataset there are 1,470 employees with 35 columns. 
> Skills:Power Query, DAX, star schema, Key Influencers AI visual.

---
 Project overview:
The IBM HR dataset is a classic for attrition analysis in this case, and Power BI's Key Influencers visual makes it genuinely more insightful than Excel or Python for this specific use case where it automatically finds which factors most increase the probability of an employee leaving, without you having to test each variable manually.
The dashboard covers three angles: overall attrition breakdown, Salary and overtime analysis, and the key influencers using the AI visual.

---
Steps for preparing this dashboard chronologically:
Step 1. Loading the data:
    1. Get Data -> Text/CSV -> select `IBM_HR_DATA.txt` from data folder,
    2. Power BI should detect tab delimiter and UTF-16 encoding automatically,
    3. Made first row to headers, go to Transform -> use First Row as Headers.

Step 2 — Power Query cleaning:
In Power Query Editor:
 Removed constant valued columns like columns with no value:
 - Deleted `EmployeeCount`, `Over18`, `StandardHours` — right-click each -> Remove

 Changed data types:
 - `MonthlyIncome`, `Age`, `YearsAtCompany` -> Whole Number

 Added AttritionFlag column:
 - Add Column -> Custom Column -> Named the column name as `AttritionFlag`,
 - Formula used for this custom column: = if [Attrition] = "Yes" then 1 else 0.

 Added Risk Category column:
 - Add Column -> Custom Column -> Named this column as `RiskCategory`,
 - Formula:  = if [OverTime] = "Yes" and [JobSatisfaction] <= 2 then "High Risk"
               else if [OverTime] = "Yes" or [JobSatisfaction] <= 2 then "Medium Risk"
               else "Low Risk".

After these steps, clicked Close & Apply to make these changes applied.

Step 3 — Created DAX measures:
these DAX measures help us to make representation of the data more easy to implement and simpler to use for visuals like card,comparisons etc.
1.Total Employees = COUNTROWS('IBM_HR_DATA')

2.Employees Left = CALCULATE(COUNTROWS('IBM_HR_DATA'), 'IBM_HR_DATA'[Attrition] = "Yes")

3.Attrition Rate = DIVIDE([Employees Left], [Total Employees], 0)

4.Avg Monthly Income = AVERAGE('IBM_HR_DATA'[MonthlyIncome])

5.Avg Income Leavers = 
                       CALCULATE(
                                 AVERAGE('IBM_HR_DATA'[MonthlyIncome]),
                                 'IBM_HR_DATA'[Attrition] = "Yes"
                        )

6.Avg Income Stayers = 
                       CALCULATE(
                                 AVERAGE('IBM_HR_DATA'[MonthlyIncome]),
                                 'IBM_HR_DATA'[Attrition] = "No"
                        )

7.Income Gap = [Avg Income Stayers] - [Avg Income Leavers]

8.High Risk Count = CALCULATE(COUNTROWS('IBM_HR_DATA'), 'IBM_HR_DATA'[RiskCategory] = "High Risk")

9.Overtime Attrition Rate = CALCULATE([Attrition Rate], 'IBM_HR_DATA'[OverTime] = "Yes")

Step 4 — Building the report pages:
 Page 1 — Attrition Overview-
  * Added Card visual,placed Attrition Rate measure in value field of the visual,Formatted as % with 1 decimal place value- this shows Attrition rate of the company,
  * Added Card visual and placed Employees Left measure in value field of the visual,formatted data as Plain number,
  * Added Card — High Risk Count in value field, gave this card Red background colour to indicate risk level(impact),
  * Added Donut chart, placed Attrition in Legend, Total Employees in Values fields,
  * Added Clustered bar chart, placed Department in Axis, Attrition Rate in Values fields,
  * Added Clustered bar chart, placed Gender in Axis, Attrition Rate in Values fields,
  * Used Slicer to filter the Department,
  * Added another Slicer for  filtering JobRole.
  This slicer make only show selected criteria of the slicer in all visuals that narrows data in the report page accordingly.

 Page 2 — Salary & Overtime Analysis**
  * Added Clustered column chart, Two bars showing comparison between Avg Income Leavers vs Avg Income Stayers,
  * Added Card visual,placed Income Gap in value field,this  Shows salary difference between stayers and leavers of the company,
  * Addded Clustered bar chart, placed OverTime in Axis, Attrition Rate in Values(shows ~30% vs ~10%),
  * Added Scatter plot chart,kept MonthlyIncome in X, YearsAtCompany in Y, Attrition in Legend,
  * Added Bar chart, placed JobSatisfaction in Axis, Attrition Rate in Values,
  * Added Slicer to filter the OverTime(Yes/No toggle).

Page 3 — Key Influencers (AI Visual):
  1.Added key influencers visual- Insert -> Key Influencers visual,
  2.For Analyzing: Attrition was set to "Yes",
  3.Explain by: added all relevant columns — OverTime, JobSatisfaction, MonthlyIncome, Department, Age, YearsAtCompany, WorkLifeBalance, JobRole in value field of the visual,
  4.Power BI automatically ranks which factors most increase the probability of Attrition = "Yes".
Top influencers: OverTime = Yes, JobSatisfaction = Low, MonthlyIncome has lower values.
Switch to Top Segments view — This shows you which employee combinations have the highest attrition rates.

---
Key findings from the dashboard:
The Overall attrition rate is  16.1%,
the Overtime attrition is  ~30.5% (vs 10.4% without overtime),
the Income gap is of the Leavers who are earning ~$2,000/month less than the stayers,
the Worst department is  Sales because this department has most attrition,
the Strongest predictor (Key Influencers) is age is 21 or less(3.57x) followed by overtime="yes"(2.93x) likelihood in attrition increase,
the High risk employees(Employees:153,Attrition Rate:36.6%) leave at 4.3x the rate of low risk employees(Employees:638,Attrition Rate:8.5%).

---
Power BI skills demonstrated:
- Power Query: custom columns, data type changes, column removal,
- DAX: CALCULATE, DIVIDE, AVERAGE with filters,
- Key Influencers AI visual -automated driver analysis,  
- Conditional formatting on cards,  
- Cross-filter interactions between visuals,  
- Buttons for navigating across pages,
- Multi-page report with consistent theme.  

---
 Files:
  1. `data/IBM_HR_DATA.txt`- Source file used to build the dashboard.
  2. `data/IBM_DASHBOARD.pbix` in PowerBI_IBM_HR/data folder.This is power bi file which has dashboards. 
  3. Visuals - images of dashboard for quick view(preview).
  4. Readme file
