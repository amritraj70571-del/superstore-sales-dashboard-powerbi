# SuperStore Sales Dashboard — Power BI Capstone Project

## Objective
To contribute to the success of a business by utilizing data analysis techniques, specifically focusing on **time series analysis**, to provide valuable insights and accurate **sales forecasting**.

## Dataset
- **File:** `data/SuperStore_Sales_Dataset.csv`
- **Records:** 5,901 orders
- **Period:** January 2019 – December 2020
- **Source:** SuperStore retail sales data — USA

## Dashboard Pages
1. **Super Store Sales Dashboard** — KPIs, regional analysis, category breakdown, payment mode, map
2. **Sales Forecast - 15 Days** — Time series line chart with 15-day forecast + state-wise sales

## DAX Measures
- Total Sales, Total Profit, Total Orders, Total Quantity
- Avg Ship Days, Profit Margin, Avg Order Value
- Calculated columns: Order Month, Order Month Num, Order Year, Ship Days

## Key Insights
- California leads with $0.34M in sales
- West region = 33% of total sales
- Consumer segment = 48% of revenue
- Office Supplies is top category ($0.64M)
- Q4 is peak sales season (Oct–Dec)
- 15-day forecast shows continued upward trend

## Tech Stack
- Microsoft Power BI Desktop
- DAX (Data Analysis Expressions)
- Power Query (M Language)
- Built-in Forecast (Analytics Pane)

## How to Run
1. Open Power BI Desktop
2. Get Data → CSV → load `SuperStore_Sales_Dataset.csv`
3. Transform Data → set date column types → Close & Apply
4. Add calculated columns and measures from `dax/DAX_and_Steps.txt`
5. Build Page 1 and Page 2 as per steps file
6. Save as `SuperStore_Sales_Dashboard.pbix`

## Author
- Amrit Raj
