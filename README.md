
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
  <img src="images/Tableau_Dashboard.png" alt="Tableau Dashboard" style="max-width: 70%; height: auto;">
</p>

You can view the Tableau dashboard here:  
[Interactive Tableau Dashboard](https://mrayane.github.io/Data-Cleaning-Analysis-SQL-Tableau/)

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

This README provides a structured overview of your project and highlights key components like the Tableau dashboard and SQL cleaning process. Let me know if you’d like to adjust anything further!
