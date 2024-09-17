Great! You can showcase the interactivity of your Tableau dashboard with the screenshots you mentioned. Here's an updated version of the README file that includes sections for these images:

---

# Data Cleaning and Analysis: SQL & Tableau

## Project Overview
This project demonstrates data cleaning, analysis, and visualization using SQL for preprocessing and Tableau for dashboarding. The data used was sourced from Kaggle and represents sales and financial records for products across various countries and segments. The objective of this project is to clean the dataset using SQL and visualize key insights through an interactive Tableau dashboard.

## Dataset Description
The dataset contains information about sales, profits, units sold, product segments, and more across multiple regions. Key fields include:
- **Segment**: Product segments such as Consumer, Corporate, and Home Office.
- **Country**: Geographic sales distribution.
- **Product**: Individual product information.
- **Units Sold**: The number of units sold.
- **Profit**: Calculated profit for each sale.
- **Discounts**: Discounts applied to the products.
- **COGS**: Cost of Goods Sold.
- **Date**: Sales date, broken down into year, month, and day.

<h3>Tableau Dashboard Visualization</h3>

<p align="center">
  <img src="Tableau/Images/Dashboard.png" alt="Tableau Dashboard" style="max-width: 70%; height: auto;">
</p>

You can view the Tableau dashboard here:  
[Interactive Tableau Dashboard](https://mrayane.github.io/Data-Cleaning-Analysis-SQL-Tableau/)

### Tableau Interactivity

1. **Main Dashboard View**:
   <p align="center">
     <img src="Tableau/Images/Dashboard.png" alt="Main Dashboard View" style="max-width: 70%; height: auto;">
   </p>

2. **Tooltip Functionality**:
   <p align="center">
     <img src="Tableau/Images/Tooltip.png" alt="Tooltip Screenshot" style="max-width: 70%; height: auto;">
   </p>

3. **Filter Options - 1**:
   <p align="center">
     <img src="images/Options_Filters_1.jpg" alt="Filter Options 1" style="max-width: 70%; height: auto;">
   </p>

4. **Filter Options - 2 (After Clicking)**:
   <p align="center">
     <img src="images/Filters_2.jpg" alt="Filter Options 2" style="max-width: 70%; height: auto;">
   </p>

5. **Bar Chart Interaction**:
   <p align="center">
     <img src="images/Bar_Chart_Interaction.jpg" alt="Bar Chart Interaction" style="max-width: 70%; height: auto;">
   </p>

These screenshots highlight the interactivity of the dashboard, showing how tooltips, filters, and clicks on chart elements update the entire visualization dynamically.

## Data Cleaning Process
SQL was used extensively to clean the dataset before it was visualized in Tableau. Some of the key steps include:

1. **Removed Special Characters**:
   - Removed `$` sign and `-` from columns where they were present to clean monetary values.
   
2. **Changed Data Types**:
   - Adjusted the data types of relevant columns to accurately represent the underlying data (e.g., converting string fields to numeric).

3. **Removed Thousand Separators**:
   - Commas used as thousand separators in numerical fields were removed for easier analysis.

4. **Handled Missing or Inconsistent Data**:
   - Dealt with missing values and standardized inconsistent entries.

## Installation and Requirements
To replicate the SQL cleaning process and Tableau dashboard, you'll need the following tools:
- SQL Server Management Studio (SSMS) or another SQL environment.
- Tableau Public or Tableau Desktop for visualization.

### SQL Process
The SQL scripts used to clean the dataset are provided in the repository under the `SQL` folder. These scripts include:
- Cleaning monetary values
- Removing unwanted characters
- Changing data types
- Standardizing the dataset for analysis

### Tableau Dashboard
The Tableau workbook (`.twb` or `.twbx`) can be found in the `Tableau` folder. You can open this file using Tableau Desktop to view and interact with the visualizations.

Alternatively, you can view the embedded Tableau dashboard via the provided [index.html](https://mrayane.github.io/Data-Cleaning-Analysis-SQL-Tableau/) page.

## Key Insights
Some of the key analyses and insights derived from this project include:
- Total Sales and Profit by Country
- Segment Performance across regions
- Discount Utilization and its impact on sales
- Year-over-year Sales Growth and Profit Trends

## Authors
Rayane Mehires - rayanemehires@gmail.com

Project Link: [GitHub - Data Cleaning and Analysis with SQL & Tableau](https://github.com/MRayane/Data-Cleaning-Analysis-SQL-Tableau)

## Thank You

---

This version highlights your Tableau interactivity with screenshots while keeping the README structured and informative.
