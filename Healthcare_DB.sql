-- Creating Dim_Patient table
CREATE TABLE Dim_Patient (
    Patient_ID INT PRIMARY KEY,
    First_Name VARCHAR(50),
    Last_Name VARCHAR(50),
    Gender VARCHAR(10),
    Date_Of_Birth DATE,
    Address VARCHAR(100),
    Phone_Number VARCHAR(15),
    Insurance_Type VARCHAR(20)
);

-- Creating Dim_Treatment table
CREATE TABLE Dim_Treatment (
    Treatment_ID INT PRIMARY KEY,
    Treatment_Name VARCHAR(100),
    Treatment_Type VARCHAR(20),
    Treatment_Cost DECIMAL(10, 2)
);

-- Creating Dim_Diagnosis table
CREATE TABLE Dim_Diagnosis (
    Diagnosis_ID INT PRIMARY KEY,
    Diagnosis_Code VARCHAR(20),
    Diagnosis_Description VARCHAR(100)
);

-- Creating Dim_Insurance table
CREATE TABLE Dim_Insurance (
    Insurance_ID INT PRIMARY KEY,
    Insurance_Company_Name VARCHAR(100),
    Policy_Type VARCHAR(50),
    Coverage_Type VARCHAR(50)
);

-- Creating Dim_Date table
CREATE TABLE Dim_Date (
    Date_ID INT PRIMARY KEY,
    Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day_of_Week VARCHAR(20)
);
-- Creating Fact_Patient_Care table
CREATE TABLE Fact_Patient_Care (
    Fact_Patient_Care_ID INT PRIMARY KEY,
    Patient_ID INT,
    Treatment_ID INT,
    Diagnosis_ID INT,
    Insurance_ID INT,
    Date_ID INT,
    Total_Cost DECIMAL(10, 2),
    Treatment_Duration INT,
    Days_In_Hospital INT,
    Patient_Count INT,
    FOREIGN KEY (Patient_ID) REFERENCES Dim_Patient(Patient_ID),
    FOREIGN KEY (Treatment_ID) REFERENCES Dim_Treatment(Treatment_ID),
    FOREIGN KEY (Diagnosis_ID) REFERENCES Dim_Diagnosis(Diagnosis_ID),
    FOREIGN KEY (Insurance_ID) REFERENCES Dim_Insurance(Insurance_ID),
    FOREIGN KEY (Date_ID) REFERENCES Dim_Date(Date_ID)
);

-- Creating Fact_Insurance_Claims table
CREATE TABLE Fact_Insurance_Claims (
    Claim_ID INT PRIMARY KEY,
    Insurance_ID INT,
    Patient_ID INT,
    Date_ID INT,
    Claim_Amount DECIMAL(10, 2),
    Claim_Processing_Time INT,
    Claim_Status VARCHAR(20),
    FOREIGN KEY (Insurance_ID) REFERENCES Dim_Insurance(Insurance_ID),
    FOREIGN KEY (Patient_ID) REFERENCES Dim_Patient(Patient_ID),
    FOREIGN KEY (Date_ID) REFERENCES Dim_Date(Date_ID)
);
##3. Insert Sample Data into Dimension Tables:
-- Inserting data into Dim_Patient
INSERT INTO Dim_Patient (Patient_ID, First_Name, Last_Name, Gender, Date_Of_Birth, Address, Phone_Number, Insurance_Type)
VALUES
(1, 'John', 'Doe', 'Male', '1985-06-15', '123 Main St', '123-456-7890', 'Private'),
(2, 'Jane', 'Smith', 'Female', '1990-07-23', '456 Oak Ave', '987-654-3210', 'Public');

-- Inserting data into Dim_Treatment
INSERT INTO Dim_Treatment (Treatment_ID, Treatment_Name, Treatment_Type, Treatment_Cost)
VALUES
(1, 'Surgery', 'Inpatient', 5000.00),
(2, 'Chemotherapy', 'Outpatient', 2000.00);

-- Inserting data into Dim_Diagnosis
INSERT INTO Dim_Diagnosis (Diagnosis_ID, Diagnosis_Code, Diagnosis_Description)
VALUES
(101, 'A01', 'Typhoid Fever'),
(102, 'B02', 'Malaria');

-- Inserting data into Dim_Insurance
INSERT INTO Dim_Insurance (Insurance_ID, Insurance_Company_Name, Policy_Type, Coverage_Type)
VALUES
(1, 'ABC Health Insurance', 'Individual', 'Full'),
(2, 'XYZ Health Insurance', 'Group', 'Partial');

-- Inserting data into Dim_Date
INSERT INTO Dim_Date (Date_ID, Date, Year, Quarter, Month, Day_of_Week)
VALUES
(20250101, '2025-01-01', 2025, 1, 1, 'Wednesday'),
(20250102, '2025-01-02', 2025, 1, 1, 'Thursday');
#4. Insert Sample Data into Fact Tables:
-- Inserting data into Fact_Patient_Care
INSERT INTO Fact_Patient_Care (Fact_Patient_Care_ID, Patient_ID, Treatment_ID, Diagnosis_ID, Insurance_ID, Date_ID, Total_Cost, Treatment_Duration, Days_In_Hospital, Patient_Count)
VALUES
(1, 1, 1, 101, 1, 20250101, 5000.00, 7, 7, 1),
(2, 2, 2, 102, 2, 20250102, 2000.00, 5, 0, 1);

-- Inserting data into Fact_Insurance_Claims
INSERT INTO Fact_Insurance_Claims (Claim_ID, Insurance_ID, Patient_ID, Date_ID, Claim_Amount, Claim_Processing_Time, Claim_Status)
VALUES
(1, 1, 1, 20250101, 5000.00, 30, 'Approved'),
(2, 2, 2, 20250102, 2000.00, 15, 'Approved');
##5. Sample Analytical Queries:
##Average Treatment Cost by Diagnosis:

SELECT d.Diagnosis_Description, AVG(f.Total_Cost) AS Average_Cost
FROM Fact_Patient_Care f
JOIN Dim_Diagnosis d ON f.Diagnosis_ID = d.Diagnosis_ID
GROUP BY d.Diagnosis_Description;
##Patient Count by Insurance Type:

SELECT p.Insurance_Type, COUNT(f.Patient_Count) AS Total_Patients
FROM Fact_Patient_Care f
JOIN Dim_Patient p ON f.Patient_ID = p.Patient_ID
GROUP BY p.Insurance_Type;

##Average Claim Processing Time by Insurance Company:
SELECT i.Insurance_Company_Name, AVG(f.Claim_Processing_Time) AS Average_Processing_Time
FROM Fact_Insurance_Claims f
JOIN Dim_Insurance i ON f.Insurance_ID = i.Insurance_ID
GROUP BY i.Insurance_Company_Name;

##Total Treatment Cost by Year:
SELECT d.Year, SUM(f.Total_Cost) AS Total_Treatment_Cost
FROM Fact_Patient_Care f
JOIN Dim_Date d ON f.Date_ID = d.Date_ID
GROUP BY d.Year;









