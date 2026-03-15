# Health-Care-Projects
Health Care Analytics Projects

Healthcare Data Analytics Portfolio
Focus: Operational Efficiency (CMS) & Clinical Quality (Diabetes Readmissions)

Tools: MySQL, Data Normalization, KPI Benchmarking

📖 Table of Contents
Project 1: CMS Operational Efficiency Index

Project 2: Diabetes 30-Day Readmission Analysis

Methodology & Interpretation Logic

Technical Competencies

🏥 Project 1: CMS Operational Efficiency Index
Business Problem: CMS reports "Timeliness of Care" using qualitative text (e.g., "Above the national average"). I converted this to a 1–3 numerical index to identify regions at "Operational Risk."

SELECT 
    `State`,
    ROUND(AVG(CASE 
        WHEN `Timeliness of care national comparison` = 'Above the national average' THEN 3
        WHEN `Timeliness of care national comparison` = 'Same as the national average' THEN 2
        WHEN `Timeliness of care national comparison` = 'Below the national average' THEN 1
        ELSE NULL 
    END), 2) AS Avg_Efficiency_Index,
    CASE 
        WHEN AVG(CASE ... END) >= 2.5 THEN 'High Efficiency (Exceeding Benchmark)'
        WHEN AVG(CASE ... END) >= 1.8 THEN 'Target Performance (Meeting Benchmark)'
        ELSE 'Operational Risk (Below Benchmark)'
    END AS Performance_Status,
    COUNT(*) AS Total_Hospitals
FROM HospInfo
WHERE `Timeliness of care national comparison` != 'Not Available'
GROUP BY `State`
HAVING Total_Hospitals > 10
ORDER BY Avg_Efficiency_Index DESC;



Project 2: Diabetes 30-Day Readmission & LOS Analysis
Business Problem: High readmission rates trigger CMS financial penalties (HRRP). This project identifies the intersection of diagnosis type and Average Length of Stay (LOS).

📝 Technical Summary & Clinical Insight
The 12% Threshold: National clinical benchmarks for diabetic 30-day readmissions typically hover between 11% and 15%. By setting a 12% "High Risk" threshold, this query isolates diagnoses—specifically those in the [80-90) age bracket and specific circulatory codes—that are most likely to drive federal reimbursement penalties.

SELECT 
    `diag_1` AS Primary_Diagnosis_Code,
    COUNT(*) AS Total_Patients,
    ROUND(SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS Readmit_Rate_Percent,
    ROUND(AVG(`time_in_hospital`), 2) AS Avg_Stay_Days,
    CASE 
        WHEN (SUM(CASE WHEN `readmitted` = '<30' THEN 1 ELSE 0 END) / COUNT(*) * 100) > 12 THEN 'High Risk (Requires Intervention)'
        ELSE 'Standard Risk'
    END AS Clinical_Priority
FROM diabetic_data
GROUP BY `diag_1`
HAVING Total_Patients > 50
ORDER BY Readmit_Rate_Percent DESC
LIMIT 5;

The LOS Correlation: The data reveals that a shorter Length of Stay (LOS) doesn't always correlate with higher readmissions; rather, specific primary diagnoses (diag_1) show "high-intensity" patterns where patients require longer stabilization periods to prevent immediate return.

MySQL Query: Clinical Drill-Down



Methodology & Interpretation Guide
To ensure the data is actionable for non-technical stakeholders, I mapped CMS qualitative markers to a 3-point scale:

3.0 (Above Average): Exceptional Performance.

2.0 (Same as Average): Target Baseline (Scores like 2.3 represent stable performance).

1.0 (Below Average): Critical Bottleneck.
