# Healthcare Data Analytics Project

**End-to-End Data Analytics | MySQL | Power BI | DAX**

## Project Overview

This project demonstrates an end-to-end healthcare data analytics workflow using MySQL and Microsoft Power BI.

The objective is to analyse synthetic hospital data and understand patient activity, hospital operations, laboratory performance, pharmacy transactions, revenue, and inpatient admissions.

The project transforms structured healthcare data into meaningful KPIs and interactive dashboard visualisations to support data-driven business decisions.

## Project Objectives

- Analyse patient demographics and hospital visit patterns.
- Evaluate department-wise and branch-wise hospital performance.
- Monitor laboratory workload and turnaround time.
- Understand abnormal laboratory result distribution.
- Analyse pharmacy sales and medicine transactions.
- Evaluate hospital revenue and payer contributions.
- Study inpatient admissions and length of stay.
- Build an interactive Power BI dashboard.

## Tools and Technologies

| Tool | Application |
|---|---|
| MySQL | Data storage, exploration, and SQL analysis |
| Microsoft Power BI | Interactive dashboard development |
| DAX | KPI calculations and measures |
| Microsoft Excel | Data inspection and spreadsheet analysis |
| GitHub | Project documentation and version control |

## Database Overview

The project uses seven relational tables:

1. Patients
2. Doctors
3. Visits
4. Lab_Tests
5. Pharmacy
6. Billing
7. Admissions

The dataset contains synthetic healthcare records created for educational and portfolio purposes.

## Key Dashboard KPIs

The Power BI dashboard presents seven major KPIs:

| KPI | Description |
|---|---|
| Total Visits | Total hospital visit records |
| Unique Patients | Distinct patients |
| Total Revenue | Total billed revenue |
| Revenue per Visit | Average revenue per visit |
| Total Lab Tests | Total laboratory test records |
| Average Lab TAT | Average laboratory turnaround time |
| Abnormal % | Percentage of abnormal laboratory tests |

## Dashboard Analysis

The dashboard includes:

- Revenue vs Last Year
- Visits by Department
- Average Lab TAT by Test Category
- Abnormal Tests by Category
- Admissions by Department
- Average Length of Stay by Department
- Revenue by Hospital Branch
- Monthly Patient Visits Trend

**Interactive filters:** Hospital Branch, Department, and Date.

## SQL Analysis

The SQL project covers eight analytical phases:

1. Database Setup and Initial Exploration
2. Patient and Hospital Operations Analysis
3. Laboratory Analytics
4. Pharmacy Analytics
5. Billing, Revenue and Insurance Analysis
6. Admissions and Inpatient Analytics
7. Integrated Healthcare Analysis
8. Advanced SQL Analysis and Business Questions

SQL concepts demonstrated include joins, aggregations, subqueries, CTEs, conditional calculations, and window functions.

## Project Documentation

Detailed documentation is available in the `Documentation` folder:

- [Project Overview](Documentation/Project_Overview.md)
- [Data Dictionary](Documentation/Data_Dictionary.md)
- [SQL Analysis Documentation](Documentation/Documentation/SQL_Analysis_Documentation.md)
- [Data Cleaning and Methodology](Documentation/Data_Cleaning_and_Methodology.md)
- [KPI Definitions](Documentation/KPI_Definitions.md)

## Project Files

- `01-data-exploration.sql` – SQL queries and analysis.
- `Healthcare-data-analytics-powerBI.pbix` – Power BI dashboard file.
- `Documentation/` – Project documentation.

## Business Applications

This project demonstrates how healthcare analytics can help organisations:

- Monitor patient demand and service utilisation.
- Understand department workload.
- Track laboratory turnaround time.
- Analyse revenue contribution.
- Monitor inpatient activity.
- Support operational performance reviews.

## Limitations

- The dataset is synthetic and does not represent an actual hospital.
- Findings from this project are for learning and demonstration only.
- Financial and operational metrics depend on the underlying data structure and calculation definitions.
- The project is not intended for clinical decision-making.

## Author

**Healthcare Data Analytics Portfolio Project**

Developed as a practical demonstration of SQL, data analysis, and business intelligence skills.

**Skills demonstrated:** MySQL | Data Analysis | Power BI | DAX | Data Visualisation | Healthcare Analytics
