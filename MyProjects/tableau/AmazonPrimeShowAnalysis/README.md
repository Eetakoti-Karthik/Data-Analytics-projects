Amazon Prime TV Analysis - Tableau Dashboard project.
> Tool: Tableau Desktop  
> Dataset: I used AmazonPrime_Dataset.xlsx which has 393 shows(393 rows,8 fields).
---

Why  Amazon Prime dataset?
I wanted to do something that wasn't Netflix since it's been used beforehand in my other project.This Amazon Prime dataset has a more interesting regional mix- a large chunk of Hindi content sits alongside English shows, and the IMDb ratings vary wildly between genres.This dataset was taken from kaggle where we can find various interesting datasets that we can use them for our Analysis.I done basic data cleaning in excel.so excel cleaning part is not included in this explanation file.
---

columns in the dataset:
 Column - Description 
*************************
1.Name of the show - has Title of the shows,
2.Year of release - has Release year (2000-2022) of the shows,
3.No of seasons available - has Season count of the shows,
4.Language - has which Languages is the shows belongs to  like English, Hindi, Japanese, French, Russian,..etc,
5.Genre -  has Genres like Action, comedy, Adventure etc,
6.IMDb rating -  has Show IMBd Ratings(out of 10),
7.Age of viewers - show rating,content for which age group people should watch(7+, 13+, 16+, 18+).
---

Connect the data
  1. Opened Tableau -> Connect -> Microsoft Excel -> select `AmazonPrime_Dataset.xlsx`,
  2. Drag `Sheet1` to the canvas for making charts,
  3. Checked data types like for Year of release = Number, IMDb rating = Number etc.

Fixed the Genre field (multi-value):
  Some rows have multi-values like "Drama, Comedy" in Genre. 
  To handle this properly:
  - In Tableau, go to the data pane -> right-click Genre -> Split,
  - This creates Genre-Split-1, Genre-Split-2 etc.
  - I Used Genre-Split-1 as the primary genre for most charts so it avoids confusion.

Created Calculated fields for measure values:
 1.Average IMDb rating = AVG([IMDb rating])

 2.Shows released after 2018 = IF [Year of release] >= 2018 THEN "Recent" ELSE "Older" END

 3.High rated flag =
      IF [IMDb rating] >= 8 THEN "High (8+)"
      ELSEIF [IMDb rating] >= 7 THEN "Good (7-8)"
      ELSE "Average (<7)" END.

Steps to build  sheets in Tableau for **Dashboards** that was built later(what's in it):
For Dashboard 1 - **Content Overview**:
  # Sheet1 - Bar chart: Number of shows column by Language-> Placed Language in Columns, COUNT of Name of the show in Rows, Sorted in descending order - this chart shows that English and Hindi language are having more shows compared to other languages,
  # Sheet2 - Bar chart: Average number of seasons by Primary_Genre- Genre having most Average no.of seasons is Documeentary followed by Adventure.  
  
For Dashboard 2 - **Ratings Analysis**:
  # Sheet1- Scatter plot: IMDb rating vs Year of release->kept Year of release in Columns, IMDb rating in Rows in Language in Colour - Older shows tend to rate higher than newer shows; Can see survivorship bias at play.
  # Sheet2 - Bar chart: Average IMDb rating by Age of viewers category- 18+ content is the having highest Average IMBd ratings compared to other age group ratings.
  # Sheet3 - Circle chart: Average IMDb rating by Genre -> Drag-dropped primary_genre(Genre-Split-1) in Rows, AVG(IMDb rating) in Columns, Added reference line for overall average - This chart shows that Animation and Sports consistently rate highest in relevance to primary genre.
  
For Dashboard 3 - **Season & Time Analysis**:
  # Sheet1 - Line chart: Shows added by Year of release (2010–2022)-> placed Year of release in Columns (continuous), COUNT in Rows ,Change to Line - shows Clear growth from 2012 onwards.
  # Sheet2 - Treemap: Show count by Language x Genre combination.

---
Steps in Designing  the Dashboard:
  1. KPI text: KPI cards are added,which are:
     · Total shows · Avg IMDb rating · Year range · Language count,
  2. New Dashboards -> dragged 2-3 sheets onto canvas and created 3 dashobard + 1 dashboard as home page to navigate to other dashboards,
  3. Added Title text box: At top of the dashboards ,titles are added like "Content Analysis", "Amazon Prime Video Content Analytics", etc,
  4. Added filter actions: clicking a Language bar filters all other charts,
  5. Added legend for colour encoding for visuals.

---
Key findings:
  Top language is English (majority), followed by  Hindi in second,
  Highest rated genre is Animation and Sports which are avg above 8.0(only in primary_genre consideration),
  Content growth has Sharp increase from 2012-2015 onwards,
  Age targeting audience of Amazon Prime is 18+ content which is the largest category,
  Seasons- Documentary and Adventure genre shows most average number of seasons released.
---

Tableau features used in this project:
  - Calculated fields (IF/THEN logic, AVG),
  - Field splitting for multi-value columns (Genre), 
  - Reference lines and average lines on charts,
  - Dashboard actions (filter on click,buttons to navigate to other dashboard pages),
  - Multiple chart types: bar, scatter, line, treemap are used in this project.
---

Files:
1.`data/AmazonPrime_Dataset.xlsx`- It is Source dataset connected and used directly in Tableau.
2.`data/AmazonPrimeAnalysismain.twb`- Tableau file where i done my dashboard project.
3.Visuals - Dashboard visuals for quick view. 
4..Readme file
