Netflix Content Analysis — Excel Project

> Tool: Microsoft Excel Desktop Application 
> Dataset: netflix_titles.csv(8,807 titles). 
> Skills: Data cleaning · PivotTables · COUNTIFS · dashboard design

---
Project goal:
If Netflix wants to understand its content library to make better investment decisions like — what types of content to commission, which countries are most productive, and how the library has grown over time.Similarly,these type of business questions are answered in this project to get insights and understanding in various trends.In this project, i implemented my excel skills like data cleaning,transforming the data(data format,conditional formatting etc),pivot tables and chart,formulas like countifs(),rank(),etc that are used and Answered the business Problems that are given by my trainer during my course at besant technologies.

---
Steps in preparation of this project:
Step 1 — Importing the data:
1. Open Excel -> Data -> From Text/CSV -> select `netflix_titles.csv`
2. Make sure the delimiter is set to comma
3. Used this data for further analysis.

Step 2 — Data Cleaning:
 Q1.Handled missing values-
    - Select column D(director) -> Find & Select -> Go To Special -> Blanks -> type `Unknown`.
    - Did the same for Column E(cast) -> type `Not Listed`
    - Did the same for Column F(country) -> type `Unknown`

 Q2.Splitted genres (Text to Columns) to avoid noise-
    - Copied Column L (listed_in) to a new area then,
    - Data -> Text to Columns -> Delimited -> comma.
    - Deleted listed_in column and Labelled the new columns: Genre1, Genre2, Genre3 and placed them in listed_in(column L). 
    - Some titles list multiple countries in country column so i split that column and retained only first column and named it primary country.

 Fixed date_added column-
    - Convertting format: `=DATEVALUE(G2)` in a helper column, then paste as values in original column,
    - Formatted as Date,because the column was in text format.

Step 3 — Analysis:
Answered the business questions of word document in data folder.
 Q3. Movies vs TV Shows distribution:
    - Inserted PivotTable, placed `type` in rows and COUNT of `show_id` in values, 
    - then,right-click value -> Show Values As, choose % of Grand Total

 Q4. Top 10 countries:
    - Inserted PivotTable placed -> rows: `country` and values: COUNT of `show_id`,then
    - Sorted in descending order and  filtered top 10 values.

 Q5. Content growth by year:
    - Inserted PivotTable placed -> rows: `release_year` and values: COUNT of `show_id`,then
    - Filtered years from range of 2000 - 2021 to remove noise.

 Q6. Most common genres:
    - Used the Genre1 column,
         PivotTable -> rows: Genre1 and values: COUNT of `show_id`,then
    - Sorted in descending order.

 Q7. Rating distribution:
    - Inserted PivotTable, placed ->  rows: `rating` and values: COUNT of `show_id`,then
    - sorted in descending order.

Step 4 — Advanced Excel tasks:
 Q8. Created Content Age column-
    - Added column after `release_year`: `=YEAR(TODAY())-[@release_year]`
    - Named it `Content_Age`,this will help to see how many years have finished since its released in netflix.

 Q10. COUNTIFS — TV Shows released after 2018-
    - =COUNTIFS(B:B,"TV Show",H:H,">"&2018) and additionally  i also implemented countifs which act as KPIs.

 Q11. Rank countries by content count-
    - Used Q4 PivotTable (country count table),
    - Created a Rank column using RANK formula: `=RANK(B2,$B$2:$B$11,0)` to rank the countries in that pivot table.

Step 5 — Dashboard
    Created a new sheet called **Dashboard** and included:
        1. Doughnut chart: Shows Movies vs TV Shows share from Q3 PivotTable,
        2. Column chart: Displays Top 10 Countries from Q4 PivotTable and added type,release_year as filtered for further analysis,
        3. line chart: Showcase Year-wise Trend from Q5 PivotTable,
        4. Bar chart: Shows Genre Distribution from Q6 PivotTable and added release_year as filtered for further analysis on that chart.

---
Key findings:
- ~70% of Netflix content is movies, ~30% TV shows,
- USA produces by far the most content, followed by India,
- Content additions peaked in 2017–2019,
- TV-MA is the most common rating highlights that  Netflix target adults primarily,
- Dramas is the top genre category(only for primary genre).

---
Files:
| 1.`data/Netflix_Dataset.xlsx`
  2.`data/Netflix Project.docx`
  3.Visuals - images of the dashboard for quick glance.
  4.Readme file.