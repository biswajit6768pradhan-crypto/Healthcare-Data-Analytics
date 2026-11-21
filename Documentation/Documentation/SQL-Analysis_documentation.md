# SQL Analysis Documentation
## Healthcare Data Analytics Project

## 1. Project Overview

This document explains the SQL analysis performed for the Healthcare Data Analytics project. The objective is to analyse hospital operations, patient visits, laboratory performance, pharmacy transactions, revenue, and inpatient admissions using MySQL.

The project uses **synthetic healthcare data** created for learning and portfolio demonstration. It does not contain real patient records and must not be used for clinical decision-making.

## 2. Database Overview

**Database:** `healthcaredata`

The project works with seven main tables:

| Table | Purpose |
|---|---|
| Patients | Patient demographic and registration information |
| Doctors | Doctor details and department information |
| Visits | Patient visits and hospital service information |
| Lab_Tests | Laboratory test details, results, costs and turnaround time |
| Pharmacy | Medicine transactions, quantities and sales |
| Billing | Billing and payment information |
| Admissions | Inpatient admission and length-of-stay information |

These tables are connected through patient, doctor, and visit identifiers. The relationships allow analysis across different hospital activities.

## 3. Data Setup and Import

The SQL script includes:

- Database and table creation.
- Primary key and foreign key definitions.
- Table structure inspection using `DESCRIBE`.
- CSV data imports using `LOAD DATA LOCAL INFILE`.
- Date and timestamp conversion using `STR_TO_DATE`.
- Initial data exploration and validation.

**Environment note:** The script contains a database creation statement for `HealthcareAnalytics` and a later `USE Healthcaredata` statement. These names should be made consistent before the script is shared as a fully reproducible setup.

The CSV import paths refer to local Windows folders. Other users must update those paths to match their own environment.

## 4. SQL Analysis Phases

### Phase 1: Database Setup and Initial Exploration

The initial phase prepares the database and explores the imported tables.

Key activities:
- Creating database tables.
- Defining keys and relationships.
- Importing CSV files.
- Inspecting table structures.
- Checking records and understanding available columns.

### Phase 2: Patient and Hospital Operations Analysis

This phase examines patient demographics, hospital visits, and operational performance.

Analysis includes:
- Gender distribution.
- Average patient age.
- Patient age-group distribution.
- Patient distribution by city and hospital branch.
- Insurance-provider distribution.
- Self-pay patient percentage.
- Returning and one-time patient analysis.
- Average visits per patient.
- Department-wise visit volume.
- Monthly patient visit trends.
- Doctor visit volume.
- Average daily patient visits.
- Patient volume by gender and department.
- Department-level repeat-patient rates.

**Business purpose:** Understand patient demographics, service demand, department workload, and patient-return patterns.

### Phase 3: Laboratory Analytics

This phase analyses laboratory workload, test turnaround time, abnormal results, and laboratory revenue.

Analysis includes:
- Test volume by test name.
- Test category and test-cost analysis.
- Laboratory workload analysis.
- Average, minimum, and maximum turnaround time.
- Tests with higher average turnaround time.
- Turnaround-time variability using standard deviation.
- Normal, abnormal, and critical result distribution.
- Abnormal and critical result percentages.
- Daily and monthly laboratory workload.
- Turnaround time by branch and test category.
- Laboratory revenue by test and department.
- Average revenue per test.
- High-volume and low-revenue test analysis.
- Potential laboratory bottlenecks.

**Business purpose:** Identify workload patterns, turnaround-time challenges, abnormal-result distribution, and revenue opportunities.

### Phase 4: Pharmacy Analytics

This phase evaluates medicine sales and pharmacy revenue.

Analysis includes:
- Total pharmacy transactions.
- Most frequently sold medicines.
- Medicine quantities sold.
- Medicine category-wise sales.
- Gross and net sales.
- Total pharmacy revenue.
- Average transaction value.
- Discounted transaction percentage.
- Average discount percentage.
- Discount impact by medicine.
- Monthly pharmacy revenue.
- Pharmacy revenue by hospital branch.

**Business purpose:** Understand medicine demand, pharmacy sales performance, discount patterns, and branch-level revenue.

### Phase 5: Billing, Revenue and Insurance Analysis

This phase focuses on hospital financial performance.

Analysis includes:
- Total billed revenue.
- Average revenue per visit.
- Median revenue per visit.
- Consultation, laboratory, and pharmacy revenue components.
- Laboratory and pharmacy share of total revenue.
- Department-wise revenue.
- Branch-wise revenue.
- Monthly revenue trends.
- Revenue by payer type.
- Revenue by insurance provider.
- Average revenue for insured and self-pay visits.
- Department comparison based on visit volume and revenue per visit.

**Business purpose:** Evaluate revenue contribution, payment patterns, insurance performance, and department-level financial performance.

### Phase 6: Admissions and Inpatient Analytics

This phase examines inpatient admissions and length of stay.

Analysis includes:
- Total admissions.
- Admissions by department.
- Admissions by hospital branch.
- Average length of stay.
- Median length of stay.
- Minimum and maximum length of stay.
- Room-type distribution.
- Average length of stay by room type.
- Department-level length-of-stay comparison.

**Business purpose:** Understand inpatient demand, room utilisation patterns, and length-of-stay performance.

### Phase 7: Integrated Healthcare Analysis

This phase combines information from multiple tables to create a broader view of hospital performance.

Analysis includes:
- Department-level visits, laboratory workload, pharmacy sales, and billing revenue.
- Branch-level visits and admissions.
- Revenue per visit by department.
- Average laboratory turnaround time by department.
- Daily visit volume and laboratory workload.
- Patient segmentation by age, gender, and insurance.
- Repeat-patient analysis.
- Laboratory workload and revenue comparison.
- Abnormal-result patterns across branches.
- Revenue contribution from laboratory and pharmacy services.
- Monthly demand and revenue trends.
- Identification of departments with higher workload and turnaround time.

Common Table Expressions (CTEs) and aggregated subqueries are used in integrated analysis to combine data from multiple tables.

**Business purpose:** Connect operational and financial indicators to support a more complete view of hospital performance.

### Phase 8: Advanced SQL Analysis and Business Questions

The final phase demonstrates advanced SQL techniques through business-oriented questions.

Examples include:
- Multi-table joins across patients, doctors, and visits.
- OPD, IPD, and emergency visit percentage analysis.
- Monthly visit and revenue trends.
- Top-performing laboratory tests.
- Abnormal-result percentage calculations.
- Average turnaround time by test.
- Department-level KPI comparisons using CTEs.
- Doctor ranking within departments using `DENSE_RANK()`.
- Test ranking within categories.
- Department revenue contribution.
- Month-over-month revenue changes using `LAG()`.
- Month-over-month admission changes.
- Patients with multiple visits using `HAVING`.
- Top patients based on visit count and billed amount.
- Departments with average turnaround time above the hospital average.

**Business purpose:** Demonstrate the use of advanced SQL for ranking, trend analysis, KPI calculation, and operational decision support.

## 5. SQL Concepts and Functions Used

The project demonstrates the following SQL concepts:

| SQL Concept | Application |
|---|---|
| SELECT | Retrieving required information |
| WHERE | Filtering records |
| ORDER BY | Sorting results |
| GROUP BY | Summarising data |
| HAVING | Filtering aggregated results |
| INNER JOIN | Combining related tables |
| LEFT JOIN | Retaining records from the left table where applicable |
| CASE WHEN | Conditional classification |
| Aggregate functions | COUNT, SUM, AVG, MIN, MAX |
| Common Table Expressions | Breaking complex analysis into smaller steps |
| Subqueries | Supporting nested calculations |
| ROW_NUMBER() | Assigning row numbers |
| DENSE_RANK() | Ranking doctors and tests |
| LAG() | Comparing current and previous periods |
| Date functions | Monthly and daily trend analysis |
| STDDEV() | Measuring turnaround-time variability |
| COALESCE() and NULLIF() | Handling null values and division calculations where used |

## 6. Data Quality and Interpretation Checks

The following points should be considered when interpreting the SQL results:

1. **Database naming:** The database creation and database selection statements should use the same name.
2. **CSV paths:** Local import paths must be adjusted for different computers.
3. **Age groups:** The age-group query should group by the age-band expression rather than raw age if one row per age group is intended.
4. **Top-five tests:** A query intended to find the five most frequently ordered tests must sort by test count in descending order, not by test name.
5. **Test-category volume:** Test volume should be calculated using a count of tests. Summing test cost measures revenue or cost, not volume.
6. **Department workload:** A department workload analysis must group by department rather than only by test category or test name.
7. **Turnaround-time median:** A query returning minimum, maximum, and average turnaround time does not calculate the median.
8. **Repeat patients:** A department-level repeat-patient calculation may differ from a hospital-wide repeat-patient calculation.
9. **Result status:** Normal, abnormal, and critical status values should use consistent spelling and capitalisation.
10. **Billing grain:** The number of billing records per visit should be checked before calculating revenue per visit.
11. **Integrated joins:** One-to-many tables should be aggregated to the appropriate level before joining to avoid duplicated totals.
12. **Missing values:** Null values and missing dates should be checked before final analysis.

These checks help improve the reliability and interpretation of the analysis.

## 7. Connection with the Power BI Dashboard

The SQL analysis supports the development of a Power BI dashboard for hospital performance monitoring.

The dashboard includes seven key performance indicators:

1. Total Visits
2. Unique Patients
3. Total Revenue
4. Revenue per Visit
5. Total Lab Tests
6. Average Lab TAT
7. Abnormal Percentage

Additional dashboard visuals include:
- Revenue compared with the previous year.
- Visits by department.
- Average laboratory turnaround time by test category.
- Abnormal tests by category.
- Admissions by department.
- Average length of stay by department.
- Revenue by hospital branch.
- Monthly patient visit trends.

The dashboard also includes slicers for hospital branch, department, and date.

SQL analysis and Power BI measures should be reconciled using consistent date fields, filters, table relationships, and calculation definitions.

## 8. Project Limitations

- The dataset is synthetic and created for educational purposes.
- The results do not represent the actual performance of a hospital.
- Some SQL queries require refinement to ensure that their labels and calculations match.
- Revenue calculations depend on the underlying billing-table structure.
- Local CSV paths may not work on another computer without modification.
- The dashboard is intended for portfolio demonstration and not real hospital operations.

## 9. Conclusion

This SQL project demonstrates how healthcare operational and financial data can be explored using MySQL.

It covers patient analysis, hospital operations, laboratory performance, pharmacy sales, billing, insurance, admissions, and integrated healthcare KPIs.

The project also demonstrates practical SQL skills, including joins, aggregations, conditional calculations, CTEs, subqueries, and window functions.

By connecting SQL analysis with Power BI visualisation, the project demonstrates an end-to-end approach to healthcare data analytics.

---

**Project:** Healthcare Data Analytics  
**Database:** MySQL  
**Visualisation Tool:** Microsoft Power BI  
**Dataset:** Synthetic healthcare data  
**Purpose:** Learning and portfolio demonstration
