-- We need to identify which age groups have the highest rate of 30-day readmissions to target them with follow-up care
-- We will define "High Risk" as any group with over a 12% readmission rate.

SELECT 
    `age`,
    COUNT(*) AS Total_Encounters,
    -- Step 1: Calculate the percentage of patients readmitted in <30 days
    ROUND(SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Readmission_Rate,
    -- Step 2: Interpret the rate for the clinical team
    CASE 
        WHEN (SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100) > 12 THEN 'High Risk (Requires Intervention)'
        WHEN (SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100) > 8 THEN 'Moderate Risk (Standard Follow-up)'
        ELSE 'Low Risk (Baseline)'
    END AS Clinical_Priority
FROM diabetic_data
GROUP BY `age`
ORDER BY Readmission_Rate DESC;


-- Query 1: Overall Hospital Performance
SELECT 
    -- 1. 30-Day Readmission Rate
    ROUND(SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Global_Readmit_Rate_Percent,
    
    -- 2. Average Length of Stay (LOS)
    ROUND(AVG(`time_in_hospital`), 2) AS Avg_Stay_Days,
    
    COUNT(*) AS Total_Patients_Analyzed
FROM diabetic_data;




-- Query 2: Top 5 Diagnoses driving Readmissions
SELECT 
    `diag_1` AS Primary_Diagnosis_Code,
    COUNT(*) AS Total_Patients,
    -- Readmission Rate for this specific diagnosis
    ROUND(SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Readmit_Rate,
    -- Average Length of Stay for this specific diagnosis
    ROUND(AVG(`time_in_hospital`), 2) AS Avg_Stay_Days
FROM diabetic_data
GROUP BY `diag_1`
-- We filter for diagnoses with at least 50 patients to ensure the data is reliable
HAVING Total_Patients > 50
ORDER BY Readmit_Rate DESC
LIMIT 5;