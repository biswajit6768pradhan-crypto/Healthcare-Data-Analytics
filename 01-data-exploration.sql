CREATE DATABASE IF NOT EXISTS HealthcareAnalytics;
USE Healthcaredata;


-- ============================================================
-- OPTIONAL: DELETE OLD TABLES BEFORE RECREATING
-- Order matters because of foreign keys
-- ============================================================

DROP TABLE IF EXISTS Admissions;
DROP TABLE IF EXISTS Billing;
DROP TABLE IF EXISTS Pharmacy;
DROP TABLE IF EXISTS Lab_Tests;
DROP TABLE IF EXISTS Visits;
DROP TABLE IF EXISTS Doctors;
DROP TABLE IF EXISTS Patients;


-- ============================================================
-- 1. PATIENTS TABLE
-- ============================================================

CREATE TABLE Patients (
    Patient_ID VARCHAR(10) PRIMARY KEY,
    Age INT,
    Gender VARCHAR(20),
    City VARCHAR(100),
    Hospital_Branch VARCHAR(100),
    Insurance_Provider VARCHAR(100),
    Registration_Date DATE
);


-- ============================================================
-- 2. DOCTORS TABLE
-- ============================================================

CREATE TABLE Doctors (
    Doctor_ID INT PRIMARY KEY,
    Doctor_Name VARCHAR(100),
    Department VARCHAR(100),
    Hospital_Branch VARCHAR(100),
    Experience_Years INT
);


-- ============================================================
-- 3. VISITS TABLE
-- ============================================================

CREATE TABLE Visits (
    Visit_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID VARCHAR(10),
    Doctor_ID INT,
    Visit_Date DATE,
    Hospital_Branch VARCHAR(100),
    Department VARCHAR(100),
    Visit_Type VARCHAR(50),

    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
    FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);


-- ============================================================
-- 4. LAB TESTS TABLE
-- ============================================================

CREATE TABLE Lab_Tests (
    Lab_Test_ID VARCHAR(15) PRIMARY KEY,
    Visit_ID VARCHAR(10),
    Patient_ID VARCHAR(10),
    Test_Name VARCHAR(100),
    Test_Category VARCHAR(100),
    Sample_Time DATETIME,
    Result_Time DATETIME,
    TAT_Minutes INT,
    Result_Status VARCHAR(50),
    Test_Cost DECIMAL(10,2),

    FOREIGN KEY (Visit_ID) REFERENCES Visits(Visit_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);


-- ============================================================
-- 5. PHARMACY TABLE
-- ============================================================

CREATE TABLE Pharmacy (
    Pharmacy_Sale_ID VARCHAR(15) PRIMARY KEY,
    Visit_ID VARCHAR(10),
    Patient_ID VARCHAR(10),
    Medicine_Name VARCHAR(100),
    Medicine_Category VARCHAR(100),
    Quantity INT,
    Unit_Price DECIMAL(10,2),
    Discount_Pct DECIMAL(5,2),
    Net_Amount DECIMAL(10,2),
    Sale_Date DATE,

    FOREIGN KEY (Visit_ID) REFERENCES Visits(Visit_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);


-- ============================================================
-- 6. BILLING TABLE
-- ============================================================

CREATE TABLE Billing (
    Bill_ID VARCHAR(10) PRIMARY KEY,
    Visit_ID VARCHAR(10),
    Patient_ID VARCHAR(10),
    Billing_Date DATE,
    Hospital_Branch VARCHAR(100),
    Consultation_Fee DECIMAL(10,2),
    Lab_Amount DECIMAL(10,2),
    Medicine_Amount DECIMAL(10,2),
    Total_Amount DECIMAL(10,2),
    Payer_Type VARCHAR(50),
    Insurance_Provider VARCHAR(100),

    FOREIGN KEY (Visit_ID) REFERENCES Visits(Visit_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);


-- ============================================================
-- 7. ADMISSIONS TABLE
-- ============================================================

CREATE TABLE Admissions (
    Admission_ID VARCHAR(10) PRIMARY KEY,
    Visit_ID VARCHAR(10),
    Patient_ID VARCHAR(10),
    Hospital_Branch VARCHAR(100),
    Department VARCHAR(100),
    Admission_Date DATE,
    Discharge_Date DATE,
    Length_of_Stay INT,
    Room_Type VARCHAR(50),

    FOREIGN KEY (Visit_ID) REFERENCES Visits(Visit_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);


-- ============================================================
-- CHECK TABLES
-- ============================================================

SHOW TABLES;

DESCRIBE Patients;
DESCRIBE Doctors;
DESCRIBE Visits;
DESCRIBE Lab_Tests;
DESCRIBE Pharmacy;
DESCRIBE Billing;
DESCRIBE Admissions;

-- ============================================================
-- IMPORT 1: PATIENTS
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Patients.csv'
INTO TABLE Patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Patient_ID,
    Age,
    Gender,
    City,
    Hospital_Branch,
    Insurance_Provider,
    Registration_Date
);


-- ============================================================
-- IMPORT 2: DOCTORS
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Doctors.csv'
INTO TABLE Doctors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Doctor_ID,
    Doctor_Name,
    Department,
    Hospital_Branch,
    Experience_Years
);


-- ============================================================
-- IMPORT 3: VISITS
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Visits.csv'
INTO TABLE Visits
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Visit_ID,
    Patient_ID,
    Doctor_ID,
    Visit_Date,
    Hospital_Branch,
    Department,
    Visit_Type
);


-- ============================================================
-- IMPORT 4: LAB TESTS
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Lab_Tests.csv'
INTO TABLE Lab_Tests
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Lab_Test_ID,
    Visit_ID,
    Patient_ID,
    Test_Name,
    Test_Category,
    @Sample_Time,
    @Result_Time,
    TAT_Minutes,
    Result_Status,
    Test_Cost
)
SET
Sample_Time = STR_TO_DATE(@Sample_Time, '%Y-%m-%d %H:%i'),
Result_Time = STR_TO_DATE(@Result_Time, '%Y-%m-%d %H:%i');


-- ============================================================
-- IMPORT 5: PHARMACY
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Pharmacy.csv'
INTO TABLE Pharmacy
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Pharmacy_Sale_ID,
    Visit_ID,
    Patient_ID,
    Medicine_Name,
    Medicine_Category,
    Quantity,
    Unit_Price,
    Discount_Pct,
    Net_Amount,
    Sale_Date
);


-- ============================================================
-- IMPORT 6: BILLING
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Billing.csv'
INTO TABLE Billing
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Bill_ID,
    Visit_ID,
    Patient_ID,
    Billing_Date,
    Hospital_Branch,
    Consultation_Fee,
    Lab_Amount,
    Medicine_Amount,
    Total_Amount,
    Payer_Type,
    Insurance_Provider
);


-- ============================================================
-- IMPORT 7: ADMISSIONS
-- ============================================================

LOAD DATA LOCAL INFILE 'D:/HealthcareData/Admissions.csv'
INTO TABLE Admissions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
    Admission_ID,
    Visit_ID,
    Patient_ID,
    Hospital_Branch,
    Department,
    Admission_Date,
    Discharge_Date,
    Length_of_Stay,
    Room_Type
);

DESCRIBE Patients;
DESCRIBE Doctors;
DESCRIBE Visits;
DESCRIBE Lab_Tests;
DESCRIBE Pharmacy;
DESCRIBE Billing;
DESCRIBE Admissions;

                                                -- Phase 2 - Patient & Hospital Operations Questions

-- What is the male/female distribution?
SELECT 
    Gender,
    COUNT(*) AS Total_Patients,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Patients), 2) AS Percentage
FROM Patients
GROUP BY Gender;
 -- What is the average patient age?
 select 
     avg(age) as average_patients_age
 from Patients;
  -- Which age group contributes the most visits?
 SELECT 
    CASE 
        WHEN p.Age < 18 THEN '0-17 (Pediatric)'
        WHEN p.Age BETWEEN 18 AND 35 THEN '18-35 (Young Adult)'
        WHEN p.Age BETWEEN 36 AND 55 THEN '36-55 (Middle-Aged)'
        WHEN p.Age BETWEEN 56 AND 70 THEN '56-70 (Senior)'
        ELSE '71+ (Elderly)'
    END AS Age_Group,
    COUNT(v.Visit_ID) AS Total_Visits,
    ROUND(COUNT(v.Visit_ID) * 100.0 / (SELECT COUNT(*) FROM Visits), 2) AS Percentage_of_Total_Visits
FROM Visits v
JOIN Patients p ON v.Patient_ID = p.Patient_ID
GROUP BY Age_Group
ORDER BY Total_Visits DESC;
--  Which city has the most patients?
SELECT 
    City,
    COUNT(Patient_ID) AS Total_Patients,
    ROUND(COUNT(Patient_ID) * 100.0 / (SELECT COUNT(*) FROM Patients), 2) AS Percentage_of_Total
FROM Patients
GROUP BY City
ORDER BY Total_Patients DESC;
-- Which hospital branch has the most patients?
select 
    Hospital_branch,
    COUNT(patient_id) as total_patients,
    round(count(patient_id)* 100.0 / (select count(*) from patients), 2) As percentage_of_total
    from Patients
    group by Hospital_branch
    order by total_patients DESC;
--  Which insurance provider covers the most patients?
select
     Insurance_Provider,
    count(patient_id) as total_patients,
    round(count(patient_id)* 100.00 / (select count(*) from patients), 2) as percentage_of_total
    from patients
    group by Insurance_Provider
    order by total_patients desc;
    
 -- 8. What percentage of patients are self-pay?
SELECT
    Payer_Type,
    COUNT(*) AS Total_Bills,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Billing),
        2
    ) AS Percentage_of_Total
FROM Billing
where payer_type = 'self pay'
GROUP BY Payer_Type
ORDER BY Total_Bills DESC;
 -- 9. How many patients are returning patients versus one-time patients?
SELECT
    Patient_Type,
    COUNT(*) AS Total_Patients
FROM
(
    SELECT
        Patient_ID,
        CASE
            WHEN COUNT(Visit_ID) = 1 THEN 'One-Time Patient'
            ELSE 'Returning Patient'
        END AS Patient_Type
    FROM Visits
    GROUP BY Patient_ID
) AS Patient_Visit_Summary
GROUP BY Patient_Type;
     
-- 10. What is the average number of visits per patient?
SELECT
    ROUND(AVG(Total_Visits), 2) AS Average_Visits_Per_Patient
FROM
(
    SELECT
        Patient_ID,
        COUNT(Visit_ID) AS Total_Visits
    FROM Visits
    GROUP BY Patient_ID
) AS Patient_Visits;
-- 11. Which departments receive the most visits?
SELECT
    Department,
    COUNT(Visit_ID) AS Total_Visits
FROM Visits
GROUP BY Department
ORDER BY Total_Visits DESC;
          
-- 12. What is the monthly trend of patient visits?
SELECT
    DATE_FORMAT(Visit_Date, '%Y-%m') AS Monthly_Trend,
    COUNT(Visit_ID) AS Total_Visits
FROM Visits
GROUP BY DATE_FORMAT(Visit_Date, '%Y-%m')
ORDER BY Monthly_Trend;
    
-- 15. Which doctor has the highest number of visits? Add a minimum-visit threshold before interpreting.
SELECT
    d.Doctor_ID,
    d.Doctor_Name,
    COUNT(v.Visit_ID) AS Total_Visits
FROM Visits v
JOIN Doctors d
    ON v.Doctor_ID = d.Doctor_ID
GROUP BY
    d.Doctor_ID,
    d.Doctor_Name
HAVING COUNT(v.Visit_ID) >= 100
ORDER BY Total_Visits DESC;

-- 16. What is the average daily visit volume?
SELECT
    ROUND(AVG(Daily_Visits), 2) AS Average_Daily_Visits
FROM
(
    SELECT
        Visit_Date,
        COUNT(Visit_ID) AS Daily_Visits
    FROM Visits
    GROUP BY Visit_Date
) AS Daily_Visit_Count;

   
-- 17. Which day/month has the highest patient volume?
SELECT
    DATE_FORMAT(Visit_Date, '%Y-%m') AS Month,
    COUNT(Visit_ID) AS Total_Visits
FROM Visits
GROUP BY DATE_FORMAT(Visit_Date, '%Y-%m')
ORDER BY Total_Visits DESC
LIMIT 10;

-- 18. How does patient volume differ by gender and department?
SELECT
    v.Department,
    p.Gender,
    COUNT(v.Visit_ID) AS Total_Visits
FROM Patients p
JOIN Visits v
    ON p.Patient_ID = v.Patient_ID
GROUP BY
    v.Department,
    p.Gender
ORDER BY
    v.Department,
    Total_Visits DESC;

--  19. How does patient volume differ by age group and department?
select
    v.Department,
    p.age,
        CASE 
        WHEN p.Age < 18 THEN '0-17 (Pediatric)'
        WHEN p.Age BETWEEN 18 AND 35 THEN '18-35 (Young Adult)'
        WHEN p.Age BETWEEN 36 AND 55 THEN '36-55 (Middle-Aged)'
        WHEN p.Age BETWEEN 56 AND 70 THEN '56-70 (Senior)'
        ELSE '71+ (Elderly)'
    END AS Age_Group,
COUNT(v.Visit_ID) AS Total_Visits
FROM Patients p
JOIN Visits v
    ON p.Patient_ID = v.Patient_ID
GROUP BY
    v.Department,
    p.age
ORDER BY
    v.Department,
    Total_Visits DESC; 
    
-- 20. Which department has the highest repeat-patient rate?
SELECT
    Department,
    COUNT(*) AS Total_Patients,

    SUM(
        CASE
            WHEN Patient_Type = 'Returning Patient' THEN 1
            ELSE 0
        END
    ) AS Returning_Patients,

    ROUND(
        SUM(
            CASE
                WHEN Patient_Type = 'Returning Patient' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Repeat_Patient_Rate

FROM
(
    SELECT
        Department,
        Patient_ID,

        CASE
            WHEN COUNT(Visit_ID) > 1 THEN 'Returning Patient'
            ELSE 'One-Time Patient'
        END AS Patient_Type

    FROM Visits

    GROUP BY
        Department,
        Patient_ID

) AS Patient_Visit_Summary

GROUP BY Department

ORDER BY Repeat_Patient_Rate DESC;

                                                           -- Phase 3 - Laboratory Analytics Questions
 
-- 1. How many total laboratory tests were performed?
select
    test_name,
    count(test_name) as total_lab_test
    from lab_tests
    group by test_name;

-- 2. Which five tests are ordered most frequently?
select
    test_name,
    count(test_name) as total_lab_test
    from lab_tests
    group by test_name
    order by test_name DESC;
    
-- 3. Which test categories generate the most volume?
select
  test_name,
  test_cost,
sum(test_cost) as total_test_cost
from lab_tests
group by
     test_name,
     test_cost
order by 
      test_name,
     test_cost desc;
     
-- 4. Which department generates the most laboratory workload?
SELECT
     test_category,
     test_name,
    count(test_name) AS Total_Tests_count
FROM Lab_Tests
GROUP BY 
    test_category,
    test_name
ORDER BY Total_Tests_count DESC
LIMIT 5;
    
-- 5. What is the average turnaround time (TAT) for all tests?
SELECT
     test_name,
     tat_minutes,
    round(avg(tat_minutes),   2) AS average_Tat_minute
FROM Lab_Tests
GROUP BY 
	test_name,
    tat_minutes
ORDER BY average_Tat_minute asc;

-- 6. What are the median, minimum, and maximum TAT values?
SELECT
     test_name,
	min(tat_minutes) as minimum_tat_minute,
	max(tat_minutes)  AS maximim_Tat_minute,
	round(avg(tat_minutes),   2) AS average_Tat_minute
FROM Lab_Tests
GROUP BY 
	test_name
ORDER BY test_name;

-- 7. Which five tests have the longest average TAT?
select
  test_name,
round(avg(tat_minutes),  2) as average_tat_minutes
from lab_tests
group by
     test_name
order by 
     average_tat_minutes desc
     Limit 5;
-- 8. Which tests have the highest TAT variability?
SELECT
    Test_Name,
    ROUND(AVG(TAT_Minutes), 2) AS Average_TAT,
    ROUND(STDDEV(TAT_Minutes), 2) AS TAT_Variability
FROM Lab_Tests
GROUP BY Test_Name
ORDER BY TAT_Variability DESC
LIMIT 5;

-- 9. What percentage of test results are Normal, Abnormal, and Critical?
SELECT
    Result_Status,
    COUNT(*) AS Total_Results,
    ROUND(
        COUNT(*) * 100.0 /
        (SELECT COUNT(*) FROM Lab_Tests),
        2
    ) AS Percentage_of_Total
FROM Lab_Tests
GROUP BY Result_Status
ORDER BY Percentage_of_Total DESC;

-- 10. Which tests have the highest abnormal-result percentage?
SELECT
    Test_Name,
    COUNT(*) AS Total_Results,

    SUM(
        CASE
            WHEN Result_Status = 'Abnormal' THEN 1
            ELSE 0
        END
    ) AS Abnormal_Results,

    ROUND(
        SUM(
            CASE
                WHEN Result_Status = 'Abnormal' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Abnormal_Percentage

FROM Lab_Tests

GROUP BY Test_Name

ORDER BY Abnormal_Percentage DESC;
-- 11. Which tests have the highest critical-result percentage?
SELECT
    Test_Name,
    COUNT(*) AS Total_Results,

    SUM(
        CASE
            WHEN Result_Status = 'critical' THEN 1
            ELSE 0
        END
    ) AS critical_Results,

    ROUND(
        SUM(
            CASE
                WHEN Result_Status = 'critical' THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS critical_Percentage

FROM Lab_Tests

GROUP BY Test_Name

ORDER BY critical_Percentage DESC;

-- 12. Does higher test volume correspond to longer TAT?
 SELECT
    DATE(Sample_Time) AS Test_Date,
    COUNT(Lab_Test_ID) AS Test_Volume,
    ROUND(AVG(TAT_Minutes), 2) AS Average_TAT
FROM Lab_Tests
GROUP BY DATE(Sample_Time)
ORDER BY Test_Date;
-- 13. How does TAT vary by hospital branch?
select
    v.hospital_branch,
     COUNT(lab_test_id) AS total_test,
    ROUND(AVG(l.TAT_Minutes), 2) AS Average_TAT_minutes
    from lab_tests l
    join visits v
    on v.visit_id = l.visit_id
    group by
          v.hospital_branch
    order by average_tat_minutes desc;
    
-- 14. How does TAT vary by test category?
SELECT
    Test_Category,
    COUNT(TAT_Minutes) AS Total_TAT_Minutes,
    ROUND(AVG(TAT_Minutes), 2) AS Average_TAT_Minutes
FROM Lab_Tests
GROUP BY Test_Category
ORDER BY Average_TAT_Minutes DESC;

-- 15. How does test volume change month by month?

-- 16. Which month has the highest lab workload?
SELECT
    DATE_FORMAT(sample_time, '%Y-%m') AS Month,
    COUNT(lab_test_ID) AS Total_lab_test
FROM lab_tests
GROUP BY DATE_FORMAT(sample_time, '%Y-%m')
ORDER BY Total_lab_test DESC;

-- 17. Which month has the highest abnormal-result count?
SELECT
    DATE_FORMAT(Sample_Time, '%Y-%m') AS Month,
    COUNT(*) AS Abnormal_Result_Count
FROM Lab_Tests
WHERE Result_Status = 'Abnormal'
GROUP BY DATE_FORMAT(Sample_Time, '%Y-%m')
ORDER BY Abnormal_Result_Count DESC;
        
-- 18. What is the total laboratory revenue?
SELECT
    ROUND(SUM(Test_Cost), 2) AS Total_Laboratory_Revenue
FROM Lab_Tests;
     
-- 19. Which tests generate the most laboratory revenue?
select
   test_name,
   test_cost,
   count(test_name) as total_test_name,
   round(sum(test_cost), 2) as total_test_cost
   from lab_tests
   group by 
         test_name,
        test_cost
	order by test_cost desc
    limit 6;
    
-- 20. What is the average revenue per laboratory test?
select
   test_name,
   test_cost,
   count(test_name) as total_test_name,
   round(avg(test_cost), 2) as average_test_cost
   from lab_tests
   group by 
         test_name,
        test_cost
	order by test_cost desc
    limit 6;
-- 21. Which departments combine high test volume with high lab revenue?
SELECT
    v.Department,
    COUNT(l.Lab_Test_ID) AS Total_Tests,
    ROUND(SUM(l.Test_Cost), 2) AS Total_Lab_Revenue
FROM Lab_Tests l
JOIN Visits v
    ON l.Visit_ID = v.Visit_ID
GROUP BY v.Department
ORDER BY Total_Lab_Revenue DESC;
-- 22. Which tests are high-volume but low-revenue?
WITH Test_Summary AS (
    SELECT
        Test_Name,
        COUNT(*) AS Total_Tests,
        SUM(Test_Cost) AS Total_Revenue
    FROM Lab_Tests
    GROUP BY Test_Name
)
SELECT
    Test_Name,
    Total_Tests,
    ROUND(Total_Revenue, 2) AS Total_Revenue
FROM Test_Summary
WHERE Total_Tests > (
    SELECT AVG(Total_Tests) FROM Test_Summary
)
AND Total_Revenue < (
    SELECT AVG(Total_Revenue) FROM Test_Summary
)
ORDER BY Total_Tests DESC;
  -- 23. Which tests are low-volume but high-revenue?
  WITH Test_Summary AS (
    SELECT
        Test_Name,
        COUNT(*) AS Total_Tests,
        SUM(Test_Cost) AS Total_Revenue
    FROM Lab_Tests
    GROUP BY Test_Name
)
SELECT
    Test_Name,
    Total_Tests,
    ROUND(Total_Revenue, 2) AS Total_Revenue
FROM Test_Summary
WHERE Total_Tests < (
    SELECT AVG(Total_Tests) FROM Test_Summary
)
AND Total_Revenue > (
    SELECT AVG(Total_Revenue) FROM Test_Summary
)
ORDER BY Total_Tests DESC;
  -- 24. Can you identify possible laboratory bottlenecks using TAT and volume together?
  WITH Test_Summary AS (
    SELECT
        Test_Name,
        COUNT(Lab_Test_ID) AS Total_Tests,
        AVG(TAT_Minutes) AS Average_TAT
    FROM Lab_Tests
    GROUP BY Test_Name
)
SELECT
    Test_Name,
    Total_Tests,
    ROUND(Average_TAT, 2) AS Average_TAT
FROM Test_Summary
WHERE Total_Tests > (
    SELECT AVG(Total_Tests)
    FROM Test_Summary
)
AND Average_TAT > (
    SELECT AVG(Average_TAT)
    FROM Test_Summary
)
ORDER BY Average_TAT DESC;
  -- 25. What operational recommendation would you make for the top 3 TAT outliers?
 SELECT
    Test_Name,
    COUNT(Lab_Test_ID) AS Total_Tests,
    ROUND(AVG(TAT_Minutes), 2) AS Average_TAT,
    MAX(TAT_Minutes) AS Maximum_TAT
FROM Lab_Tests
GROUP BY Test_Name
ORDER BY Average_TAT DESC
LIMIT 3;

                                                            -- Phase 4 - Pharmacy Analytics Questions

-- 1. How many pharmacy transactions were recorded?
    SELECT
    COUNT(Pharmacy_Sale_ID) AS Total_Pharmacy_Transactions
FROM Pharmacy;

-- 2. Which medicines are sold most frequently?
select
    medicine_name,
    count(medicine_name) as total_medicine_name,
    sum(quantity)  as total_quantity_sold
    from pharmacy
    group by
        medicine_name
    order by total_quantity_sold desc;
    
-- 3. Which medicine categories have the highest quantity sold?
select
    medicine_category,
    count(medicine_category) as total_medicine_category,
     sum(quantity) as total_quantity
    from pharmacy
    group by
        medicine_category
    order by total_quantity desc;
-- 4. Which medicines generate the most gross sales?
SELECT
    Medicine_Name,
    COUNT(*) AS Total_Transactions,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(Quantity * Unit_Price), 2) AS Gross_Sales
FROM Pharmacy
GROUP BY Medicine_Name
ORDER BY Gross_Sales DESC
LIMIT 6;
    
-- 5. Which medicines generate the most net sales?
SELECT
    Medicine_Name,
    COUNT(*) AS Total_Transactions,
    SUM(Quantity) AS Total_Quantity,
    ROUND(SUM(net_amount), 2) AS net_Sales
FROM Pharmacy
GROUP BY Medicine_Name
ORDER BY net_Sales DESC
LIMIT 6;

-- 6. What is the total pharmacy revenue?
select
    sum(net_amount) as total_revenue
    from pharmacy;
    
-- 7. What is the average net amount per pharmacy transaction?
select
    round(avg(net_amount),  2) as average_revenue
    from pharmacy;
    
-- 8. What percentage of transactions receive a discount?
select
round(sum(case when discount_pct > 0 then 1
     else 0 end) * 100 / count(*), 
     2) as discount_transaction_percentage
     from pharmacy;
     
-- 9. What is the average discount percentage?
SELECT
    ROUND(AVG(Discount_Pct), 2) AS Average_Discount_Percentage
FROM Pharmacy;

-- 10. Which medicines have the highest discount impact?
SELECT
    Medicine_Name,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Quantity * Unit_Price), 2) AS Gross_Sales,
    ROUND(SUM(Net_Amount), 2) AS Net_Sales,
    ROUND(
        SUM(Quantity * Unit_Price - Net_Amount),
        2
    ) AS Total_Discount_Impact
FROM Pharmacy
GROUP BY Medicine_Name
ORDER BY Total_Discount_Impact DESC
LIMIT 10;
-- 11. How does pharmacy revenue change by month?
SELECT
    DATE_FORMAT(Sale_Date, '%Y-%m') AS Month,
    ROUND(SUM(Net_Amount), 2) AS Total_Revenue
FROM Pharmacy
GROUP BY DATE_FORMAT(Sale_Date, '%Y-%m')
ORDER BY Month ASC;

-- 12. Which hospital branches generate the most pharmacy revenue?
SELECT
    v.Hospital_Branch,
    COUNT(p.Pharmacy_Sale_ID) AS Total_Transactions,
    ROUND(SUM(p.Net_Amount), 2) AS Total_Revenue
FROM Pharmacy p
JOIN Visits v
    ON p.Visit_ID = v.Visit_ID
GROUP BY v.Hospital_Branch
ORDER BY Total_Revenue DESC;

                                              --  Phase 5 - Billing, Revenue & Insurance Questions

-- 1. What is total billed revenue?
select
   sum(total_amount) as total_revenue 
   from billing;
   
-- 2. What is average revenue per visit?
SELECT
    COUNT(DISTINCT Visit_ID) AS Total_Visits,
    ROUND(SUM(Total_Amount), 2) AS Total_Revenue,
    ROUND(
        SUM(Total_Amount) / COUNT(DISTINCT Visit_ID),
        2
    ) AS Average_Revenue_Per_Visit
FROM Billing;
   
-- 3. What is median revenue per visit?
WITH Visit_Revenue AS (
    SELECT
        Visit_ID,
        SUM(Total_Amount) AS Revenue
    FROM Billing
    GROUP BY Visit_ID
),
Ranked_Revenue AS (
    SELECT
        Revenue,
        ROW_NUMBER() OVER (ORDER BY Revenue) AS Row_Num,
        COUNT(*) OVER () AS Total_Visits
    FROM Visit_Revenue
)
SELECT
    ROUND(AVG(Revenue), 2) AS Median_Revenue
FROM Ranked_Revenue
WHERE Row_Num IN (
    FLOOR((Total_Visits + 1) / 2),
    FLOOR((Total_Visits + 2) / 2)
);
-- 4. How much revenue comes from consultation fees?
select
   sum(consultation_fee) as total_consultation_fee
   from billing;
   
-- 5. How much revenue comes from laboratory services?
select
   sum(lab_amount) as total_revenue
   from billing;
-- 6. How much revenue comes from pharmacy?
select
   sum(medicine_amount) as total_revenue
   from billing;
-- 7. What percentage of total revenue comes from lab services?
SELECT
    ROUND(SUM(Lab_Amount), 2) AS Total_Lab_Revenue,
    ROUND(SUM(Total_Amount), 2) AS Total_Hospital_Revenue,
    ROUND(
        SUM(Lab_Amount) * 100.0 /
        NULLIF(SUM(Total_Amount), 0),
        2
    ) AS Lab_Revenue_Percentage
FROM Billing;
-- 8. What percentage comes from pharmacy?
SELECT
    ROUND(SUM(Medicine_Amount), 2) AS Total_Pharmacy_Revenue,
    ROUND(SUM(Total_Amount), 2) AS Total_Hospital_Revenue,
    ROUND(
        SUM(Medicine_Amount) * 100.0 /
        NULLIF(SUM(Total_Amount), 0),
        2
    ) AS Pharmacy_Revenue_Percentage
FROM Billing;

-- 9. Which department generates the highest total patient billing?
select
    v.department,
    count(distinct v.department) as total_department,
    Round(sum(b.total_amount),  2) as total_revenue
    from billing b
    join visits v
        on b.visit_id = v.visit_id
	group by v.department
     order by total_revenue desc;
     
-- 10. Which hospital branch generates the highest revenue?
select 
     hospital_branch,
     count(hospital_branch) as total_hospital_branch,
     sum(total_amount) as total_revenue
     from billing
        group by hospital_branch
     order by total_revenue desc;
     
-- 11. How does revenue change month by month?
SELECT
    DATE_FORMAT(billing_date, '%Y-%m') AS Month,
    ROUND(SUM(total_Amount), 2) AS Total_Revenue
FROM billing
GROUP BY DATE_FORMAT(billing_date, '%Y-%m')
ORDER BY Month ASC;

-- 12. Which payer type generates more revenue: Insurance or Self Pay?
select
   payer_type,
   round(sum(total_amount),  2) as total_revenue
   from billing
   group by payer_type
   order by total_revenue desc;
   
-- 13. Which insurance provider contributes the most billed revenue?
SELECT
    Insurance_Provider,
    ROUND(SUM(Total_Amount), 2) AS Total_Revenue
FROM Billing
WHERE Payer_Type = 'Insurance'
GROUP BY Insurance_Provider
ORDER BY Total_Revenue DESC;
   
-- 14. What is average revenue per insured visit vs self-pay visit?
select
   payer_type,
   count(distinct visit_id) as total_visit_id,
   sum(total_amount) as total_revenue,
   round(avg(total_amount),  2) as average_revenue
   from billing
   group by payer_type
   order by average_revenue desc;
   
-- 15. Which departments have high visit volume but low revenue per visit?
select
    v.department,
    count(distinct v.visit_id) as total_visit,
    Round(sum(b.total_amount),  2) as total_revenue,
     ROUND(SUM(b.Total_Amount) / COUNT(DISTINCT v.Visit_ID),  2) AS Revenue_Per_Visit
    from billing b
    join visits v
        on b.visit_id = v.visit_id
	group by v.department
     order by total_visit desc,  Revenue_Per_Visit asc;
     
-- 16. Which departments have lower volume but high revenue per visit?
select
    v.department,
    count(distinct v.visit_id) as total_visit,
    Round(sum(b.total_amount),  2) as total_revenue,
     ROUND(SUM(b.Total_Amount) / COUNT(DISTINCT v.Visit_ID),  2) AS Revenue_Per_Visit
    from billing b
    join visits v
        on b.visit_id = v.visit_id
	group by v.department
     order by total_visit asc,  Revenue_Per_Visit desc;

                                                    -- Phase 6 - Admissions & Inpatient Analytics Questions
-- 1. How many admissions occurred?
select
   count(*) as total_admission
   from admissions;
-- 2. Which departments have the most admissions?
select
     department,
	count(*) as total_admission
    from admissions
    group by department
    order by total_admission desc;
    
-- 3. Which hospital branch has the most admissions?
select
     hospital_branch,
	count(*) as total_admission
    from admissions
    group by 
            hospital_branch
    order by total_admission desc;
    
-- 4. What is the average length of stay (LOS)?
SELECT
    ROUND(AVG(Length_of_Stay), 2) AS Average_LOS
FROM Admissions;
    
-- 5. What are the median, minimum, and maximum LOS values?
WITH Ranked_LOS AS (
    SELECT
        Length_of_Stay,
        ROW_NUMBER() OVER (
            ORDER BY Length_of_Stay
        ) AS Row_Num,
        COUNT(*) OVER () AS Total_Admissions
    FROM Admissions
    WHERE Length_of_Stay IS NOT NULL
)
SELECT
    MIN(Length_of_Stay) AS Minimum_LOS,
    MAX(Length_of_Stay) AS Maximum_LOS,
    ROUND(AVG(
        CASE
            WHEN Row_Num IN (
                FLOOR((Total_Admissions + 1) / 2),
                FLOOR((Total_Admissions + 2) / 2)
            )
            THEN Length_of_Stay
        END
    ), 2) AS Median_LOS
FROM Ranked_LOS;
-- 6. Which room type is used most often?
select
     room_type,
    count(*)  as total_admission
    from admissions
    group by room_type
    order by total_admission desc;
    
-- 7. Which room type has the longest average stay?
select 
     room_type,
     count(*) as total_admission,
     round(avg(length_of_stay),  2) as average_LOS
     from admissions
     group by room_type
	order by average_LOS desc;
-- 8. Which departments have the longest average LOS?
select 
     department,
     count(*) as total_admission,
     round(avg(length_of_stay),  2) as average_LOS
     from admissions
     group by department
	order by average_LOS desc;
    
-- 9. How does LOS vary by hospital branch?
select 
     hospital_branch,
     round(avg(length_of_stay),  2) average_LOS
     from admissions
     group by hospital_branch
	order by average_LOS desc;
    
-- 10. How does admission volume change by month?
select
     date_format(admission_date, '%Y-%M') as month,
     count(admission_id) as total_admission
     from admissions
     group by date_format(admission_date, '%Y-%M')
     order by month asc;
     
-- 11. Are departments with high admissions also high-revenue departments?
SELECT
    a.Department,
    COUNT(DISTINCT a.Admission_ID) AS Total_Admissions,
    ROUND(SUM(b.Total_Amount), 2) AS Total_Revenue
FROM Admissions a
JOIN Billing b
    ON a.Visit_ID = b.Visit_ID
GROUP BY a.Department
ORDER BY Total_Admissions DESC;
     
-- 12. What is the relationship between LOS and total billing?
WITH Visit_Billing AS (
    SELECT
        Visit_ID,
        SUM(Total_Amount) AS Visit_Total_Billing
    FROM Billing
    GROUP BY Visit_ID
)
SELECT
    a.Length_of_Stay,
    COUNT(DISTINCT a.Admission_ID) AS Total_Admissions,
    ROUND(AVG(b.Visit_Total_Billing), 2) AS Average_Billing
FROM Admissions a
JOIN Visit_Billing b
    ON a.Visit_ID = b.Visit_ID
GROUP BY a.Length_of_Stay
ORDER BY a.Length_of_Stay ASC;

                                           -- Phase 6 - Integrated Healthcare Questions (Most Important)

-- 1. Which departments have the highest combination of visits, lab workload, pharmacy sales, and revenue?
WITH Lab_Summary AS (
    SELECT
        Visit_ID,
        COUNT(*) AS Total_Tests
    FROM Lab_Tests
    GROUP BY Visit_ID
),

Pharmacy_Summary AS (
    SELECT
        Visit_ID,
        SUM(Net_Amount) AS Pharmacy_Sales
    FROM Pharmacy
    GROUP BY Visit_ID
),

Billing_Summary AS (
    SELECT
        Visit_ID,
        SUM(Total_Amount) AS Billing_Revenue
    FROM Billing
    GROUP BY Visit_ID
)

SELECT
    v.Department,

    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,

    SUM(COALESCE(l.Total_Tests, 0))
        AS Total_Lab_Tests,

    ROUND(
        SUM(COALESCE(p.Pharmacy_Sales, 0)), 2
    ) AS Total_Pharmacy_Sales,

    ROUND(
        SUM(COALESCE(b.Billing_Revenue, 0)), 2
    ) AS Total_Billing_Revenue

FROM Visits v

LEFT JOIN Lab_Summary l
    ON v.Visit_ID = l.Visit_ID

LEFT JOIN Pharmacy_Summary p
    ON v.Visit_ID = p.Visit_ID

LEFT JOIN Billing_Summary b
    ON v.Visit_ID = b.Visit_ID

GROUP BY v.Department

ORDER BY Total_Billing_Revenue DESC;
           
-- 2. Which branches are busiest across patient volume, admissions, laboratory tests, and pharmacy?
WITH Admissions_Summary AS (
    SELECT
        Visit_ID,
        COUNT(DISTINCT Admission_ID) AS Total_Admissions
    FROM Admissions
    GROUP BY Visit_ID
),

Lab_Summary AS (
    SELECT
        Visit_ID,
        COUNT(*) AS Total_Tests
    FROM Lab_Tests
    GROUP BY Visit_ID
),

Pharmacy_Summary AS (
    SELECT
        Visit_ID,
        COUNT(DISTINCT Pharmacy_Sale_ID)
            AS Total_Pharmacy_Transactions
    FROM Pharmacy
    GROUP BY Visit_ID
)

SELECT
    v.Hospital_Branch,

    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,

    SUM(COALESCE(a.Total_Admissions, 0))
        AS Total_Admissions,

    SUM(COALESCE(l.Total_Tests, 0))
        AS Total_Lab_Tests,

    SUM(COALESCE(p.Total_Pharmacy_Transactions, 0))
        AS Total_Pharmacy_Transactions

FROM Visits v

LEFT JOIN Admissions_Summary a
    ON v.Visit_ID = a.Visit_ID

LEFT JOIN Lab_Summary l
    ON v.Visit_ID = l.Visit_ID

LEFT JOIN Pharmacy_Summary p
    ON v.Visit_ID = p.Visit_ID

GROUP BY v.Hospital_Branch

ORDER BY Total_Visits DESC;
-- 3. Which department has the highest average revenue per visit?

SELECT
    v.Department,

    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,

    COALESCE(SUM(b.Total_Amount), 0)
        AS Total_Revenue,

    ROUND(
        COALESCE(SUM(b.Total_Amount), 0) /
        NULLIF(COUNT(DISTINCT v.Visit_ID), 0),
        2
    ) AS Revenue_Per_Visit

FROM Visits v

LEFT JOIN Billing b
    ON v.Visit_ID = b.Visit_ID

GROUP BY v.Department

ORDER BY Revenue_Per_Visit DESC;
    
-- 4. Which department has the highest average lab TAT?
select
    v.department,
    round(avg(l.tat_minutes),  2) as average_tat
    from lab_tests l
    left join visits v
    on v.visit_id = l.visit_id
    group by v.department
    order by average_tat desc;
    
-- 5. Is there a relationship between patient volume and laboratory turnaround time?
SELECT
    v.Visit_Date,
    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,
    COUNT(l.Visit_ID) AS Total_Lab_Tests,
    ROUND(AVG(l.TAT_Minutes), 2) AS Average_TAT
FROM Visits v
LEFT JOIN Lab_Tests l
    ON v.Visit_ID = l.Visit_ID
GROUP BY v.Visit_Date
ORDER BY v.Visit_Date;
    
-- 6. Are high-volume departments also high-revenue departments?
select
   v.department,
   count(distinct v.visit_id) as total_visit,
   round(sum(b.total_amount),  2) as total_revenue
   from billing b
   left join visits v
   on b.visit_id = v.visit_id
   group by v.department
   order by total_revenue desc;
   
-- 7. Which patient segments (age/gender/insurance) show the highest visit frequency?
SELECT
    CASE
        WHEN p.Age < 18 THEN 'Under 18'
        WHEN p.Age BETWEEN 18 AND 30 THEN '18-30'
        WHEN p.Age BETWEEN 31 AND 45 THEN '31-45'
        WHEN p.Age BETWEEN 46 AND 60 THEN '46-60'
        ELSE 'Above 60'
    END AS Age_Group,

    p.Gender,
    p.Insurance_provider,

    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,

    COUNT(DISTINCT p.Patient_ID) AS Total_Patients,

    ROUND(
        COUNT(DISTINCT v.Visit_ID) * 1.0 /
        NULLIF(COUNT(DISTINCT p.Patient_ID), 0),
        2
    ) AS Visits_Per_Patient

FROM Patients p

JOIN Visits v
    ON p.Patient_ID = v.Patient_ID

GROUP BY
    Age_Group,
    p.Gender,
    p.Insurance_provider

ORDER BY Visits_Per_Patient DESC;
   
-- 8. Which departments have the highest repeat-patient rate?

SELECT
    Department,
    COUNT(*) AS Total_Patients,
    SUM(
        CASE
            WHEN Patient_Type = 'Returning Patient'
            THEN 1
            ELSE 0
        END
    ) AS Returning_Patients,
    ROUND(
        SUM(
            CASE
                WHEN Patient_Type = 'Returning Patient'
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS Repeat_Patient_Rate
FROM
(
    SELECT
        v.Department,
        p.Patient_ID,
        CASE
            WHEN COUNT(DISTINCT v.Visit_ID) = 1
                THEN 'One-Time Patient'
            ELSE 'Returning Patient'
        END AS Patient_Type
    FROM Visits v
    JOIN Patients p
        ON p.Patient_ID = v.Patient_ID
    GROUP BY
        v.Department,
        p.Patient_ID
) AS Patient_Visit_Summary
GROUP BY Department
ORDER BY Repeat_Patient_Rate DESC;

-- 9. Which tests contribute most to both workload and lab revenue?
select 
    test_name,
    count(*) as total_test,
    round(sum(test_cost),  2) as total_revenue
	from lab_tests
    group by test_name
    order by total_revenue desc;
    
-- 10. Which branches have the highest abnormal-result burden?
select
	 v.hospital_branch,
     l.result_status,
     count(distinct v.visit_id) as total_visit,
     count(l.result_status) as total_result
     from lab_tests l
     left join visits v
        on v.visit_id = l.visit_id
	where l.result_status = 'abnormal'
	group by v.hospital_branch, l.result_status
    order by total_result desc;
     
-- 11. Which branches have the longest laboratory TAT?
select 
     v.hospital_branch,
     count(distinct v.visit_id) as total_visit,
     round(avg(tat_minutes), 2) as average_tat_minutes
     from lab_tests l
     left join visits v
       on v.visit_id = l.visit_id
	group by v.hospital_branch
    order by average_tat_minutes desc;
     
-- 12. Do self-pay and insurance patients have different average billing patterns?
SELECT
    Payer_Type,
    COUNT(*) AS Total_Bills,
    ROUND(AVG(Total_Amount), 2) AS Average_Bill_Amount
FROM Billing
GROUP BY Payer_Type
ORDER BY Average_Bill_Amount DESC;
   
-- 13. What percentage of total hospital revenue is linked to lab activity and pharmacy activity?

SELECT
    ROUND(SUM(Total_Amount), 2) AS Total_Hospital_Revenue,
    ROUND(SUM(COALESCE(Lab_Amount, 0)), 2) AS Total_Lab_Revenue,
    ROUND(SUM(COALESCE(Medicine_Amount, 0)), 2) AS Total_Pharmacy_Revenue,

    ROUND(SUM(COALESCE(Lab_Amount, 0) +COALESCE(Medicine_Amount, 0)) * 100.0 /
        NULLIF(SUM(Total_Amount), 0), 2) AS Lab_Pharmacy_Revenue_Percentage

FROM Billing;
    
-- 14. Which months show both high demand and high revenue?
select
    count(distinct patient_id) as total_patient,
    date_format(billing_date, '%Y-%M') as month,
    round(sum(total_amount), 2) as total_revenue
    from billing
    group by  date_format(billing_date, '%Y-%M')
    order by total_revenue desc;
    
-- 15. Which departments should be prioritized for operational improvement?
SELECT
    v.Department,
    COUNT(*) AS Total_Lab_Tests,
    ROUND(AVG(l.TAT_Minutes), 2) AS Average_TAT
FROM Lab_Tests l
left join visits v
      on v.visit_id = l.visit_id
group by v.department
order by average_tat desc, Total_lab_tests desc;
  
                                                -- 9. Advanced SQL Question Bank
-- 1. Write a JOIN that combines Visits, Patients, and Doctors to produce an operational visit dataset.
SELECT
    v.Visit_ID,
    v.Visit_Date,
    v.Hospital_Branch,
    v.Department,
    v.Visit_Type,
    v.Patient_ID,
    p.Age,
    p.Gender,
    v.Doctor_ID,
    d.Doctor_Name
FROM Visits v
LEFT JOIN Patients p
    ON v.Patient_ID = p.Patient_ID
LEFT JOIN Doctors d
    ON v.Doctor_ID = d.Doctor_ID
ORDER BY v.Visit_Date
limit 10;

-- 2. Write a JOIN that combines Visits and Lab_Tests to calculate test workload by department.
SELECT
    v.Department,
    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,
    COUNT(l.Test_Name) AS Total_Lab_Tests
FROM Visits v
LEFT JOIN Lab_Tests l
    ON v.Visit_ID = l.Visit_ID
GROUP BY v.Department
ORDER BY Total_Lab_Tests DESC;
   
-- 3. Use GROUP BY and CASE to create OPD/IPD/Emergency percentages.
SELECT
    v.Hospital_Branch,
    COUNT(*) AS Total_Visits,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN TRIM(TRAILING CHAR(13) FROM v.Visit_Type) = 'OPD'
                THEN 1 ELSE 0
            END
        ) / COUNT(*), 2
    ) AS OPD_Percentage,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN TRIM(TRAILING CHAR(13) FROM v.Visit_Type) = 'IPD'
                THEN 1 ELSE 0
            END
        ) / COUNT(*), 2
    ) AS IPD_Percentage,

    ROUND(
        100.0 * SUM(
            CASE
                WHEN TRIM(TRAILING CHAR(13) FROM v.Visit_Type) = 'Emergency'
                THEN 1 ELSE 0
            END
        ) / COUNT(*), 2
    ) AS Emergency_Percentage

FROM Visits v
GROUP BY v.Hospital_Branch
ORDER BY Total_Visits DESC;
-- 4. Use date functions to calculate monthly visits and monthly revenue.
-- 4. Use date functions to calculate monthly visits and monthly revenue.
SELECT
    DATE_FORMAT(v.Visit_Date, '%Y-%m') AS Month,
    COUNT(DISTINCT v.Visit_ID) AS Total_Visits,
    ROUND(
        SUM(COALESCE(b.Total_Amount, 0)), 2
    ) AS Total_Revenue
FROM Visits v
LEFT JOIN Billing b
    ON v.Visit_ID = b.Visit_ID
GROUP BY DATE_FORMAT(v.Visit_Date, '%Y-%m')
ORDER BY Month;				
    
-- 5. Find the top 5 tests by volume using ORDER BY and LIMIT.
select 
    test_name,
   count(*) as total_test_count
   from lab_tests
   group by test_name
   order by total_test_count desc
   limit 5;
-- 6. Calculate abnormal-result percentage using conditional aggregation.
SELECT
    test_name,
    COUNT(*) AS total_results,
    SUM(CASE WHEN result_status = 'abnormal' THEN 1 ELSE 0 END) AS abnormal_results,
    ROUND(100.0 * SUM(CASE WHEN result_status = 'abnormal' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2
    ) AS abnormal_pct
FROM lab_tests
GROUP BY test_name
ORDER BY abnormal_pct DESC;
-- 7. Calculate average TAT by test and rank tests from slowest to fastest.
SELECT
    test_name,
    COUNT(*) AS total_tests,
    ROUND(AVG(tat_minutes), 2) AS average_tat
FROM lab_tests
GROUP BY test_name
ORDER BY average_tat DESC;

-- 8. Use a CTE to calculate department KPIs in one reusable query.
WITH visit_kpi AS (
    SELECT
        Department,
        COUNT(*) AS Total_Visits
    FROM Visits
    GROUP BY Department
),

revenue_kpi AS (
    SELECT
        v.Department,
        SUM(b.Total_Amount) AS Total_Revenue
    FROM Visits v
    JOIN Billing b
        ON v.Visit_ID = b.Visit_ID
    GROUP BY v.Department
),

lab_kpi AS (
    SELECT
        v.Department,
        COUNT(*) AS Total_Lab_Tests,
        ROUND(AVG(l.TAT_Minutes), 2) AS Average_TAT
    FROM Visits v
    JOIN Lab_Tests l
        ON v.Visit_ID = l.Visit_ID
    GROUP BY v.Department
)

SELECT
    vk.Department,
    vk.Total_Visits,
    COALESCE(rk.Total_Revenue, 0) AS Total_Revenue,
    COALESCE(lk.Total_Lab_Tests, 0) AS Total_Lab_Tests,
    lk.Average_TAT

FROM visit_kpi vk
LEFT JOIN revenue_kpi rk
    ON vk.Department = rk.Department
LEFT JOIN lab_kpi lk
    ON vk.Department = lk.Department
ORDER BY vk.Total_Visits DESC;

-- 9. Use a window function to rank doctors within each department by visit volume.
WITH doctor_summary AS (
    SELECT
        v.Department,
        v.Doctor_ID,
        d.Doctor_Name,
        COUNT(v.Visit_ID) AS Total_Visits
    FROM Visits v
    LEFT JOIN Doctors d
        ON v.Doctor_ID = d.Doctor_ID
    GROUP BY
        v.Department,
        v.Doctor_ID,
        d.Doctor_Name
)

SELECT
    Department,
    Doctor_ID,
    Doctor_Name,
    Total_Visits,
    DENSE_RANK() OVER (PARTITION BY Department
        ORDER BY Total_Visits DESC) AS Doctor_Rank
FROM doctor_summary
ORDER BY Department, Doctor_Rank;

-- 10. Use a window function to rank tests within each category by test volume.
WITH test_summary AS (
    SELECT
        test_category,
        test_name,
        COUNT(*) AS total_test_count
    FROM Lab_Tests
    GROUP BY
        test_category,
        test_name
)

SELECT
    test_category,
    test_name,
    total_test_count,
    DENSE_RANK() OVER (PARTITION BY test_category
        ORDER BY total_test_count DESC) AS test_rank
FROM test_summary
ORDER BY test_category, test_rank;
      
-- 11. Calculate each department's percentage contribution to total hospital revenue.
select
   v.department,
   count(distinct v.visit_id) as total_visit,
   sum(b.total_amount) as total_revenue,
   round( 100.0 * sum(b.total_amount) / NULLIF (sum(sum(b.total_amount)) over(),0), 2) as revenue_percentage 
   from visits v
   left join billing b
       on b.visit_id = v.visit_id
	group by v.department
    order by revenue_percentage desc;
    
-- 12. Calculate month-over-month revenue change using LAG().
WITH monthly_revenue AS (
    SELECT
        DATE_FORMAT(b.billing_date, '%Y-%m') AS month,
        SUM(b.total_amount) AS total_revenue
    FROM billing b
    GROUP BY DATE_FORMAT(b.billing_date, '%Y-%m')
),

revenue_comparison AS (
    SELECT
        month,
        total_revenue,
        LAG(total_revenue) OVER (
            ORDER BY month
        ) AS previous_month_revenue
    FROM monthly_revenue
)

SELECT
    month,
    total_revenue,
    previous_month_revenue,
    ROUND(total_revenue - previous_month_revenue, 2) AS revenue_change,
     ROUND(100.0 * (total_revenue - previous_month_revenue) / NULLIF(previous_month_revenue, 0), 2) AS revenue_change_pct

FROM revenue_comparison
ORDER BY month;

-- 13. Calculate month-over-month patient growth using LAG().
WITH monthly_patient AS (
    SELECT
        DATE_FORMAT(a.admission_date, '%Y-%m') AS month,
        COUNT(DISTINCT a.admission_id) AS total_admission
    FROM admissions a
    GROUP BY DATE_FORMAT(a.admission_date, '%Y-%m')
),

patient_growth AS (
    SELECT
        month,
        total_admission,
        LAG(total_admission) OVER (
            ORDER BY month
        ) AS previous_month_admission
    FROM monthly_patient
)

SELECT
    month,
    total_admission,
    previous_month_admission,
    total_admission - previous_month_admission AS admission_change,
    ROUND( 100.0 * (total_admission - previous_month_admission) / NULLIF(previous_month_admission, 0), 2) AS admission_change_pct
FROM patient_growth
ORDER BY month;
-- 14. Find patients with more than one visit.
 SELECT
    Patient_ID,
    COUNT(Visit_ID) AS Total_Visits
FROM Visits
GROUP BY Patient_ID
HAVING COUNT(Visit_ID) > 1
ORDER BY Total_Visits DESC;
-- 15. Find the top 10 patients by visit count and total billed amount.
SELECT
    v.Patient_ID,
    COUNT(v.Visit_ID) AS Total_Visits,
    COALESCE(SUM(b.Total_Amount), 0) AS Total_Billed_Amount
FROM Visits v
LEFT JOIN Billing b
    ON v.Visit_ID = b.Visit_ID
GROUP BY v.Patient_ID
ORDER BY Total_Visits DESC, Total_Billed_Amount DESC
LIMIT 10;

-- 16. Find departments where average TAT is above the hospital-wide average.
SELECT
    v.Department,
    ROUND(AVG(lt.TAT_Minutes), 2) AS Department_Avg_TAT
FROM Visits v
JOIN Lab_Tests lt
    ON v.Visit_ID = lt.Visit_ID
GROUP BY v.Department
HAVING AVG(lt.TAT_Minutes) > (
    SELECT AVG(TAT_Minutes)
    FROM Lab_Tests
)
ORDER BY Department_Avg_TAT DESC;
