# Data Dictionary – Healthcare Data Analytics

## 1. Introduction

This document describes the database tables, columns, data types and relationships used in the Healthcare Data Analytics project.
The database contains seven tables and uses synthetic data for educational and portfolio purposes.

## 2. Database Tables

### 2.1 Patients

Stores patient demographic and registration information.

| Column | Data Type | Description |
|---|---|---|
| Patient_ID | VARCHAR(10) | Unique patient identifier; Primary Key |
| Age | INT | Patient age |
| Gender | VARCHAR(20) | Patient gender |
| City | VARCHAR(100) | Patient city |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Insurance_Provider | VARCHAR(100) | Insurance provider |
| Registration_Date | DATE | Patient registration date |

### 2.2 Doctors

Stores doctor and department information.

| Column | Data Type | Description |
|---|---|---|
| Doctor_ID | INT | Unique doctor identifier; Primary Key |
| Doctor_Name | VARCHAR(100) | Doctor name |
| Department | VARCHAR(100) | Doctor's department |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Experience_Years | INT | Doctor's years of experience |

### 2.3 Visits

Stores patient visit information.

| Column | Data Type | Description |
|---|---|---|
| Visit_ID | VARCHAR(10) | Unique visit identifier; Primary Key |
| Patient_ID | VARCHAR(10) | Patient reference; Foreign Key |
| Doctor_ID | INT | Doctor reference; Foreign Key |
| Visit_Date | DATE | Date of patient visit |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Department | VARCHAR(100) | Visit department |
| Visit_Type | VARCHAR(50) | Type of patient visit |

### 2.4 Lab_Tests

Stores laboratory test and turnaround information.

| Column | Data Type | Description |
|---|---|---|
| Lab_Test_ID | VARCHAR(15) | Unique laboratory test identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Related visit; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient reference; Foreign Key |
| Test_Name | VARCHAR(100) | Laboratory test name |
| Test_Category | VARCHAR(100) | Laboratory test category |
| Sample_Time | DATETIME | Sample collection time |
| Result_Time | DATETIME | Result time |
| TAT_Minutes | INT | Turnaround time in minutes |
| Result_Status | VARCHAR(50) | Laboratory result status |
| Test_Cost | DECIMAL(10,2) | Laboratory test cost |

### 2.5 Pharmacy

Stores medicine sales and transaction information.

| Column | Data Type | Description |
|---|---|---|
| Pharmacy_Sale_ID | VARCHAR(15) | Unique pharmacy sale identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Related visit; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient reference; Foreign Key |
| Medicine_Name | VARCHAR(100) | Medicine name |
| Medicine_Category | VARCHAR(100) | Medicine category |
| Quantity | INT | Quantity sold |
| Unit_Price | DECIMAL(10,2) | Price per unit |
| Discount_Pct | DECIMAL(5,2) | Discount percentage |
| Net_Amount | DECIMAL(10,2) | Net sale amount |
| Sale_Date | DATE | Medicine sale date |

### 2.6 Billing

Stores hospital billing and payment information.

| Column | Data Type | Description |
|---|---|---|
| Bill_ID | VARCHAR(10) | Unique bill identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Related visit; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient reference; Foreign Key |
| Billing_Date | DATE | Billing date |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Consultation_Fee | DECIMAL(10,2) | Consultation fee |
| Lab_Amount | DECIMAL(10,2) | Laboratory charges |
| Medicine_Amount | DECIMAL(10,2) | Medicine charges |
| Total_Amount | DECIMAL(10,2) | Total bill amount |
| Payer_Type | VARCHAR(50) | Payment/payer category |
| Insurance_Provider | VARCHAR(100) | Insurance provider |

### 2.7 Admissions

Stores inpatient admission and discharge information.

| Column | Data Type | Description |
|---|---|---|
| Admission_ID | VARCHAR(10) | Unique admission identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Related visit; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient reference; Foreign Key |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Department | VARCHAR(100) | Admission department |
| Admission_Date | DATE | Admission date |
| Discharge_Date | DATE | Discharge date |
| Length_of_Stay | INT | Length of stay |
| Room_Type | VARCHAR(50) | Room category |

## 3. Primary Keys

Each table has a unique primary key:

- Patients: Patient_ID
- Doctors: Doctor_ID
- Visits: Visit_ID
- Lab_Tests: Lab_Test_ID
- Pharmacy: Pharmacy_Sale_ID
- Billing: Bill_ID
- Admissions: Admission_ID

## 4. Foreign Key Relationships

The SQL schema defines these relationships:

- Visits.Patient_ID → Patients.Patient_ID
- Visits.Doctor_ID → Doctors.Doctor_ID
- Lab_Tests.Visit_ID → Visits.Visit_ID
- Lab_Tests.Patient_ID → Patients.Patient_ID
- Pharmacy.Visit_ID → Visits.Visit_ID
- Pharmacy.Patient_ID → Patients.Patient_ID
- Billing.Visit_ID → Visits.Visit_ID
- Billing.Patient_ID → Patients.Patient_ID
- Admissions.Visit_ID → Visits.Visit_ID
- Admissions.Patient_ID → Patients.Patient_ID

## 5. Data Types Used

- INT: Whole-number values.
- VARCHAR: Variable-length text.
- DATE: Calendar dates.
- DATETIME: Date and time values.
- DECIMAL: Numeric values with fixed decimal precision, used for monetary values.

## 6. Dataset Disclaimer

This project uses synthetic healthcare data. It does not contain actual patient records or represent real hospital transactions.

The descriptions in this document explain the database schema and intended column usage.
