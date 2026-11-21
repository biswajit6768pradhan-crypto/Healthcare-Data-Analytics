# Data Cleaning and Methodology
## Healthcare Data Analytics Project

## 1. Introduction

This document explains the data preparation, validation approach, and analytical methodology used in the Healthcare Data Analytics project.

The project uses a synthetic healthcare dataset containing information about patients, doctors, hospital visits, laboratory tests, pharmacy transactions, billing, and admissions.

The purpose is to demonstrate how healthcare operational and financial data can be structured, validated, analysed, and transformed into meaningful business insights.

**Important:** The dataset is synthetic and intended only for educational and portfolio demonstration. It does not contain real patient information.

---

## 2. Data Sources

The project uses seven CSV datasets imported into MySQL.

| Dataset | Description |
|---|---|
| Patients.csv | Patient demographic and registration details |
| Doctors.csv | Doctor and department information |
| Visits.csv | Hospital visit records |
| Lab_Tests.csv | Laboratory test and result information |
| Pharmacy.csv | Medicine sales and transaction details |
| Billing.csv | Hospital billing and payment information |
| Admissions.csv | Inpatient admission and discharge records |

The datasets are connected through patient, doctor, and visit identifiers.

---

## 3. Data Preparation Process

The following workflow describes the preparation and validation approach for the project.

### Step 1: Database Preparation

MySQL was used to create the database and seven relational tables.

The table structures include:
- Primary keys for unique record identification.
- Foreign keys to establish relationships between tables.
- Appropriate data types for text, dates, timestamps, numbers, and financial values.

### Step 2: CSV Data Import

The CSV files were imported into MySQL using `LOAD DATA LOCAL INFILE`.

The import process includes:
- Identifying the source CSV file.
- Defining comma-separated fields.
- Handling quoted text values.
- Skipping the header row.
- Mapping CSV columns to database columns.

For laboratory timestamps, `STR_TO_DATE()` was used to convert imported text values into MySQL `DATETIME` values.

### Step 3: Structural Validation

Table structures were inspected using `DESCRIBE`.

The following checks are relevant:
- Confirming column names.
- Checking data types.
- Identifying primary and foreign keys.
- Reviewing whether date and timestamp columns use appropriate types.

### Step 4: Record Validation

Record counts can be checked to confirm that data has been imported into the expected tables.

Additional checks should include:
- Duplicate primary-key values.
- Missing identifiers.
- Null values in important fields.
- Invalid dates.
- Negative quantities or financial values.
- Unexpected result-status categories.
- Records that do not match their related parent records.

These checks should be completed and documented before claiming that all data-quality issues have been resolved.

---

## 4. Data Quality Considerations

The following data-quality areas are important for reliable healthcare analysis.

| Data Quality Area | Validation Approach | Importance |
|---|---|---|
| Missing Values | Check important columns for NULL values | Prevents incomplete calculations |
| Duplicate Records | Check primary-key uniqueness | Prevents duplicate counting |
| Data Types | Inspect column definitions | Ensures correct calculations |
| Date Consistency | Validate date and timestamp fields | Supports accurate trend analysis |
| Referential Integrity | Check patient, doctor, and visit relationships | Maintains relational accuracy |
| Financial Values | Review negative or unexpected amounts | Improves revenue analysis |
| Result Categories | Check status values for consistency | Supports abnormal-result analysis |
| Numeric Values | Review age, quantity, TAT, and length of stay | Prevents invalid metrics |

---

## 5. Data Transformation and Preparation

Data preparation is necessary before performing business analysis.

The project uses or may require the following preparation techniques depending on the condition of the imported data:

### Date and Time Conversion

Laboratory sample and result timestamps are converted into `DATETIME` values using `STR_TO_DATE()` during import.

Date fields are used for:
- Monthly patient visit analysis.
- Monthly revenue analysis.
- Daily laboratory workload.
- Admission and discharge analysis.

### Categorisation

Data can be grouped into meaningful business categories, such as:
- Patient age groups.
- Laboratory test categories.
- Medicine categories.
- Hospital departments.
- Visit types.
- Payer types.

### Null Handling

Missing values should be examined before deciding whether to retain, replace, or exclude them.

The treatment depends on the meaning of the field and the business question.

### Aggregation

Data is summarised using SQL aggregate functions such as:
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`

### Multi-table Integration

Related tables are joined using patient, doctor, and visit identifiers.

For tables containing multiple records per visit, aggregation should be performed at the correct level before joining. This helps prevent duplicated revenue and activity totals.

---

## 6. Analytical Methodology

The project follows a structured analytical approach.

### Patient and Operational Analysis

Patient and visit data are analysed to understand:
- Patient demographics.
- Visit distribution.
- Department workload.
- Branch performance.
- Repeat-patient patterns.
- Monthly patient demand.

### Laboratory Analysis

Laboratory records are analysed to evaluate:
- Test volume.
- Test category distribution.
- Turnaround time.
- Abnormal and critical result percentages.
- Laboratory revenue.
- Potential workload bottlenecks.

### Pharmacy Analysis

Pharmacy records are used to understand:
- Medicine sales.
- Quantity sold.
- Medicine category performance.
- Discount patterns.
- Pharmacy revenue.

### Financial Analysis

Billing information is analysed to evaluate:
- Total billed revenue.
- Revenue per visit.
- Revenue by department.
- Revenue by hospital branch.
- Insurance and self-pay contribution.
- Monthly revenue trends.

### Inpatient Analysis

Admission records are used to examine:
- Admission volume.
- Department-wise admissions.
- Room-type distribution.
- Length of stay.
- Branch-level admission patterns.

---

## 7. Tools and Technologies

| Tool | Application |
|---|---|
| MySQL | Database creation, data import, validation, and SQL analysis |
| Microsoft Excel | Dataset inspection and spreadsheet-based analysis where applicable |
| Microsoft Power BI | Dashboard development and data visualisation |
| DAX | KPI and calculated-measure development in Power BI |
| GitHub | Project version control and portfolio documentation |

---

## 8. Data Validation Before Dashboard Development

Before using the data in Power BI, the following checks are recommended:

1. Confirm that the required tables are available.
2. Verify the relationships between the tables.
3. Check that date columns are correctly formatted.
4. Review duplicate records and missing values.
5. Confirm that financial amounts are numeric.
6. Check the calculation of turnaround time.
7. Validate the patient and visit counts.
8. Reconcile SQL totals with Power BI measures.
9. Confirm that slicers filter the intended visuals.
10. Check that multi-table relationships do not cause double counting.

---

## 9. Key Performance Indicators

The project dashboard includes the following KPIs:

| KPI | Business Meaning |
|---|---|
| Total Visits | Total number of hospital visits |
| Unique Patients | Number of distinct patients |
| Total Revenue | Total billed revenue |
| Revenue per Visit | Average billed revenue per visit |
| Total Lab Tests | Total laboratory tests recorded |
| Average Lab TAT | Average laboratory turnaround time |
| Abnormal Percentage | Percentage of tests classified as abnormal |

The exact calculation of each KPI should follow the measure definitions used in the Power BI dashboard.

---

## 10. Limitations

- The dataset is synthetic and does not represent actual hospital operations.
- The accuracy of analysis depends on the quality of the generated records.
- Some validation checks may require additional execution before being marked as completed.
- The project does not demonstrate real clinical decision-making.
- Revenue and visit-level calculations depend on the underlying table grain and relationships.
- Results should be interpreted as portfolio analysis rather than real-world hospital performance.

---

## 11. Conclusion

The methodology provides a structured approach to preparing and analysing healthcare data using MySQL and Power BI.

It covers database preparation, CSV imports, structural validation, data-quality considerations, analytical methods, KPI development, and dashboard validation.

The project demonstrates an end-to-end healthcare analytics workflow and the application of SQL and business intelligence tools to operational and financial data.

---

**Project:** Healthcare Data Analytics  
**Database:** MySQL  
**Visualisation:** Microsoft Power BI  
**Dataset:** Synthetic healthcare data  
**Purpose:** Educational and portfolio demonstration
