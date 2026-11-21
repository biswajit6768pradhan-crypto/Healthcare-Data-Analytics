# KPI Definitions and Business Logic
## Healthcare Data Analytics Project

## 1. Introduction

This document defines the Key Performance Indicators (KPIs) used in the Healthcare Data Analytics Power BI dashboard.

The KPIs are designed to monitor hospital activity, patient volume, financial performance, and laboratory efficiency.

The project uses synthetic healthcare data for educational and portfolio demonstration.

---

## 2. Executive Dashboard KPIs

The dashboard contains seven main KPI cards.

| No. | KPI | Purpose |
|---|---|---|
| 1 | Total Visits | Measures total hospital visits |
| 2 | Unique Patients | Measures the number of distinct patients |
| 3 | Total Revenue | Measures total billed revenue |
| 4 | Revenue per Visit | Measures average revenue generated per visit |
| 5 | Total Lab Tests | Measures total laboratory tests |
| 6 | Average Lab TAT | Measures average laboratory turnaround time |
| 7 | Abnormal % | Measures the percentage of abnormal laboratory results |

---

## 3. KPI Definitions and DAX Measures

### KPI 1: Total Visits

**Definition:** Total number of hospital visit records.

**Business Purpose:** Helps monitor hospital demand and overall patient activity.

**DAX Formula:**

```dax
Total Visits =
DISTINCTCOUNT(Visits[Visit_ID])
```

**Interpretation:** A higher number of visits indicates greater recorded hospital activity.

### KPI 2: Unique Patients

**Definition:** Total number of distinct patients who visited the hospital.

**Business Purpose:** Helps understand the hospital's patient reach and patient volume.

**DAX Formula:**

```dax
Unique Patients =
DISTINCTCOUNT(Visits[Patient_ID])
```

**Interpretation:** This KPI counts each patient once, even if the patient has multiple visits.

### KPI 3: Total Revenue

**Definition:** Total billed revenue recorded in the Billing table.

**Business Purpose:** Helps evaluate the financial performance of the hospital.

**DAX Formula:**

```dax
Total Revenue =
SUM(Billing[Total_Amount])
```

**Display Format:** Indian Rupees (₹).

**Interpretation:** Shows the total amount billed across the selected reporting period and filters.

### KPI 4: Revenue per Visit

**Definition:** Average billed revenue per distinct hospital visit.

**Business Purpose:** Helps compare financial contribution with hospital activity.

**DAX Formula:**

```dax
Revenue per Visit =
DIVIDE(
    [Total Revenue],
    [Total Visits],
    0
)
```

**Display Format:** Indian Rupees (₹).

**Interpretation:** Indicates the average billed revenue generated per visit under the dashboard's selected filters.

**Important:** This measure assumes that the revenue total and visit count are calculated over compatible populations and that the billing table does not create unintended duplicate amounts.

### KPI 5: Total Lab Tests

**Definition:** Total number of laboratory test records.

**Business Purpose:** Helps monitor laboratory workload and service demand.

**DAX Formula:**

```dax
Total Lab Tests =
DISTINCTCOUNT(Lab_Tests[Lab_Test_ID])
```

**Interpretation:** A higher value indicates greater laboratory testing activity.

### KPI 6: Average Lab TAT

**Definition:** Average laboratory turnaround time measured in minutes.

**Business Purpose:** Helps evaluate laboratory processing efficiency.

**DAX Formula:**

```dax
Average Lab TAT =
AVERAGE(Lab_Tests[TAT_Minutes])
```

**Display Format:** Minutes.

**Interpretation:** Lower average turnaround time generally indicates faster processing, subject to test type and operational requirements.

### KPI 7: Abnormal Percentage

**Definition:** Percentage of laboratory tests classified as abnormal.

**Business Purpose:** Helps monitor the distribution of abnormal laboratory results in the dataset.

**DAX Formula:**

```dax
Abnormal Tests =
CALCULATE(
    DISTINCTCOUNT(Lab_Tests[Lab_Test_ID]),
    Lab_Tests[Result_Status] = "Abnormal"
)
```

```dax
Abnormal % =
DIVIDE(
    [Abnormal Tests],
    [Total Lab Tests],
    0
)
```

**Display Format:** Percentage.

**Interpretation:** Represents the share of recorded laboratory tests classified as abnormal.

**Important:** This is a descriptive metric for the synthetic dataset, not a measure of hospital quality or patient health.

---

## 4. Additional Dashboard Metrics

The dashboard also includes supporting visual analyses.

| Metric | Calculation / Analysis |
|---|---|
| Revenue vs Last Year | Compares current-period revenue with the previous year's revenue |
| Visits by Department | Counts visits grouped by department |
| Average TAT by Test Category | Calculates average turnaround time by test category |
| Abnormal Tests by Category | Counts abnormal laboratory tests by category |
| Admissions by Department | Counts admissions by department |
| Average Length of Stay | Calculates average inpatient length of stay |
| Revenue by Hospital Branch | Summarises billed revenue by branch |
| Monthly Patient Visits Trend | Counts visits grouped by month |

These metrics provide additional operational and financial context beyond the seven main KPI cards.

---

## 5. Dashboard Filters

The Power BI dashboard includes three main slicers:

### Hospital Branch
Allows users to compare performance across hospital branches.

### Department
Allows users to analyse visits, laboratory activity, and admissions by department where the relevant relationships support filtering.

### Date
Allows users to view KPIs and trends for a selected reporting period.

All KPIs should respond consistently to the intended slicers.

---

## 6. KPI Validation

Before publishing the dashboard, the following checks should be performed:

1. Compare Total Visits with the distinct Visit_ID count in SQL.
2. Compare Unique Patients with the distinct Patient_ID count from Visits.
3. Reconcile Total Revenue with the sum of Billing.Total_Amount.
4. Validate Revenue per Visit using the same reporting population.
5. Compare Total Lab Tests with the distinct Lab_Test_ID count.
6. Compare Average Lab TAT with the SQL average of TAT_Minutes.
7. Validate Abnormal Tests and Abnormal % against the Result_Status values.
8. Check that branch, department, and date slicers produce expected results.
9. Confirm that multi-table relationships do not duplicate financial totals.

---

## 7. Business Value of the KPIs

The KPIs help demonstrate how healthcare data can support operational and financial monitoring.

- **Patient Activity:** Total Visits and Unique Patients show hospital demand.
- **Financial Performance:** Total Revenue and Revenue per Visit show billed financial activity.
- **Laboratory Efficiency:** Total Lab Tests and Average Lab TAT show laboratory workload and processing time.
- **Laboratory Result Distribution:** Abnormal Percentage shows the share of tests classified as abnormal.

Together, these indicators provide a high-level overview of hospital performance.

---

## 8. Limitations

- All KPIs are based on synthetic data.
- KPI results depend on the underlying table relationships and data quality.
- Revenue calculations depend on the grain of the Billing table.
- Average turnaround time does not account for differences in test complexity.
- Abnormal percentages are descriptive and should not be interpreted as clinical outcomes.
- Year-over-year comparisons require a correctly configured date table and comparable date periods.

---

## 9. Conclusion

The KPI framework provides a structured method for monitoring patient activity, hospital revenue, laboratory workload, and operational performance.

The measures are implemented using DAX in Power BI and supported by the underlying MySQL database.

This demonstrates the practical application of data analytics and business intelligence in a healthcare setting.

---

**Project:** Healthcare Data Analytics  
**Database:** MySQL  
**Dashboard Tool:** Microsoft Power BI  
**Measure Language:** DAX  
**Dataset:** Synthetic healthcare data
