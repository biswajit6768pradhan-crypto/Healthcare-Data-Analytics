# Healthcare Data Analytics – Data Dictionary

## 1. Introduction

This Data Dictionary describes the structure of the seven MySQL tables used in the Healthcare Data Analytics project.

It documents the column names, data types, and purposes of each field based on the `CREATE TABLE` statements in `01-data-exploration.sql`.

**Database:** `Healthcaredata`  
**Database tool:** MySQL  
**Dataset:** Synthetic healthcare data created for educational and portfolio purposes.

---

## 2. Patients Table

**Purpose:** Stores patient demographic information, hospital branch details, insurance information, and registration dates.

| Column | Data Type | Description |
|---|---|---|
| Patient_ID | VARCHAR(10) | Unique patient identifier; Primary Key |
| Age | INT | Patient age |
| Gender | VARCHAR(20) | Patient gender |
| City | VARCHAR(100) | Patient's city |
| Hospital_Branch | VARCHAR(100) | Hospital branch associated with the patient |
| Insurance_Provider | VARCHAR(100) | Patient's insurance provider |
| Registration_Date | DATE | Date of patient registration |

**Primary Key:** Patient_ID

---

## 3. Doctors Table

**Purpose:** Contains doctor information, including department, hospital branch, and professional experience.

| Column | Data Type | Description |
|---|---|---|
| Doctor_ID | INT | Unique doctor identifier; Primary Key |
| Doctor_Name | VARCHAR(100) | Doctor's name |
| Department | VARCHAR(100) | Department where the doctor works |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Experience_Years | INT | Doctor's years of experience |

**Primary Key:** Doctor_ID

---

## 4. Visits Table

**Purpose:** Records patient visits and connects patients with doctors, departments, and hospital branches.

| Column | Data Type | Description |
|---|---|---|
| Visit_ID | VARCHAR(10) | Unique visit identifier; Primary Key |
| Patient_ID | VARCHAR(10) | Patient identifier; Foreign Key |
| Doctor_ID | INT | Doctor identifier; Foreign Key |
| Visit_Date | DATE | Date of the hospital visit |
| Hospital_Branch | VARCHAR(100) | Branch where the visit occurred |
| Department | VARCHAR(100) | Department associated with the visit |
| Visit_Type | VARCHAR(50) | Type of visit, such as OPD, IPD, or Emergency, depending on the data |

**Primary Key:** Visit_ID

**Foreign Keys:**
- Patient_ID references Patients(Patient_ID).
- Doctor_ID references Doctors(Doctor_ID).

---

## 5. Lab_Tests Table

**Purpose:** Stores laboratory test information, sample and result timestamps, turnaround time, result status, and test cost.

| Column | Data Type | Description |
|---|---|---|
| Lab_Test_ID | VARCHAR(15) | Unique laboratory test identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Associated visit identifier; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient identifier; Foreign Key |
| Test_Name | VARCHAR(100) | Name of the laboratory test |
| Test_Category | VARCHAR(100) | Category of the laboratory test |
| Sample_Time | DATETIME | Date and time when the sample was collected |
| Result_Time | DATETIME | Date and time when the result was recorded |
| TAT_Minutes | INT | Laboratory turnaround time in minutes |
| Result_Status | VARCHAR(50) | Recorded result classification, such as Normal, Abnormal, or Critical |
| Test_Cost | DECIMAL(10,2) | Cost associated with the laboratory test |

**Primary Key:** Lab_Test_ID

**Foreign Keys:**
- Visit_ID references Visits(Visit_ID).
- Patient_ID references Patients(Patient_ID).

---

## 6. Pharmacy Table

**Purpose:** Records medicine sales, quantities, prices, discounts, and net transaction amounts.

| Column | Data Type | Description |
|---|---|---|
| Pharmacy_Sale_ID | VARCHAR(15) | Unique pharmacy transaction identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Associated visit identifier; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient identifier; Foreign Key |
| Medicine_Name | VARCHAR(100) | Name of the medicine |
| Medicine_Category | VARCHAR(100) | Medicine category |
| Quantity | INT | Number of units sold |
| Unit_Price | DECIMAL(10,2) | Price per medicine unit |
| Discount_Pct | DECIMAL(5,2) | Discount percentage |
| Net_Amount | DECIMAL(10,2) | Final amount after discount |
| Sale_Date | DATE | Date of the pharmacy transaction |

**Primary Key:** Pharmacy_Sale_ID

**Foreign Keys:**
- Visit_ID references Visits(Visit_ID).
- Patient_ID references Patients(Patient_ID).

---

## 7. Billing Table

**Purpose:** Contains hospital billing details, including consultation fees, laboratory charges, medicine charges, total amounts, and payer information.

| Column | Data Type | Description |
|---|---|---|
| Bill_ID | VARCHAR(10) | Unique billing identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Associated visit identifier; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient identifier; Foreign Key |
| Billing_Date | DATE | Date of billing |
| Hospital_Branch | VARCHAR(100) | Branch associated with the bill |
| Consultation_Fee | DECIMAL(10,2) | Consultation charges |
| Lab_Amount | DECIMAL(10,2) | Laboratory charges included in the bill |
| Medicine_Amount | DECIMAL(10,2) | Medicine charges included in the bill |
| Total_Amount | DECIMAL(10,2) | Total billed amount |
| Payer_Type | VARCHAR(50) | Type of payer, such as insurance or self-pay, depending on the data |
| Insurance_Provider | VARCHAR(100) | Insurance provider associated with the bill |

**Primary Key:** Bill_ID

**Foreign Keys:**
- Visit_ID references Visits(Visit_ID).
- Patient_ID references Patients(Patient_ID).

---

## 8. Admissions Table

**Purpose:** Stores inpatient admission information, including admission and discharge dates, length of stay, department, branch, and room type.

| Column | Data Type | Description |
|---|---|---|
| Admission_ID | VARCHAR(10) | Unique admission identifier; Primary Key |
| Visit_ID | VARCHAR(10) | Associated visit identifier; Foreign Key |
| Patient_ID | VARCHAR(10) | Patient identifier; Foreign Key |
| Hospital_Branch | VARCHAR(100) | Hospital branch |
| Department | VARCHAR(100) | Department responsible for the admission |
| Admission_Date | DATE | Date of admission |
| Discharge_Date | DATE | Date of discharge |
| Length_of_Stay | INT | Duration of stay, measured in days |
| Room_Type | VARCHAR(50) | Type of room assigned to the patient |

**Primary Key:** Admission_ID

**Foreign Keys:**
- Visit_ID references Visits(Visit_ID).
- Patient_ID references Patients(Patient_ID).

---

## 9. Table Relationships

The database uses primary keys and foreign keys to connect related information.

| Parent Table | Parent Column | Child Table | Child Column |
|---|---|---|---|
| Patients | Patient_ID | Visits | Patient_ID |
| Doctors | Doctor_ID | Visits | Doctor_ID |
| Visits | Visit_ID | Lab_Tests | Visit_ID |
| Patients | Patient_ID | Lab_Tests | Patient_ID |
| Visits | Visit_ID | Pharmacy | Visit_ID |
| Patients | Patient_ID | Pharmacy | Patient_ID |
| Visits | Visit_ID | Billing | Visit_ID |
| Patients | Patient_ID | Billing | Patient_ID |
| Visits | Visit_ID | Admissions | Visit_ID |
| Patients | Patient_ID | Admissions | Patient_ID |

### Simplified Relationship Structure

- Patients connect to Visits through Patient_ID.
- Doctors connect to Visits through Doctor_ID.
- Visits connect to laboratory tests, pharmacy transactions, billing, and admissions through Visit_ID.
- Patient_ID is also stored in these activity tables to support patient-level analysis.

---

## 10. Data Types Used

| Data Type | Purpose |
|---|---|
| INT | Whole numbers, such as age, quantity, and experience |
| VARCHAR | Text and identifier fields |
| DATE | Calendar dates |
| DATETIME | Date and time values |
| DECIMAL(10,2) | Financial amounts |
| DECIMAL(5,2) | Percentage values |

---

## 11. Analytical Applications

The database supports analysis across several healthcare business areas:

- **Patient Analytics:** Age, gender, city, insurance, and registration patterns.
- **Hospital Operations:** Visits, department workload, doctor activity, and branch performance.
- **Laboratory Analytics:** Test volume, turnaround time, result status, and test costs.
- **Pharmacy Analytics:** Medicine demand, quantities, discounts, and sales.
- **Financial Analytics:** Billing, revenue components, payer types, and insurance providers.
- **Inpatient Analytics:** Admissions, room types, and length of stay.

---

## 12. Important Notes and Limitations

1. The dataset is synthetic and does not represent real patient records.
2. Column descriptions explain the intended meaning of fields; actual values should be checked against the imported data.
3. The schema defines primary keys and foreign keys but does not specify every possible business rule.
4. The relationship between Visit_ID and activity tables should be checked for duplicate visits before calculating visit-level KPIs.
5. Financial calculations should use the appropriate billing or transaction grain to avoid double counting.
6. `Length_of_Stay` is stored as an integer; its calculation should be interpreted according to the data-generation method.
7. The SQL script currently creates `HealthcareAnalytics` but selects `Healthcaredata`. These database names should be made consistent.

---

**Project:** Healthcare Data Analytics  
**Database:** MySQL  
**Tables Documented:** 7  
**Dataset Type:** Synthetic healthcare dataset  
**Documentation Source:** `01-data-exploration.sql`
