# Health-Care-Projects
Health Care Analytics Projects

Healthcare Data Analytics Portfolio
Focus: Operational Efficiency (CMS) & Clinical Quality (Diabetes Readmissions)

Tools: MySQL, Data Normalization, KPI Benchmarking

📖 Table of Contents
Project 1: CMS Operational Efficiency Index

Project 2: Diabetes 30-Day Readmission Analysis

Diabetes Readmission Risk by Age DemographicBusiness Problem: 30-day readmissions trigger CMS financial penalties. This analysis identifies which age cohorts cross the 12% high-risk threshold, allowing for targeted "Transition of Care" resource allocation.

| Age Group | Total Encounters | Readmission Rate (<30 days) | Clinical Priority |
| :--- | :---: | :---: | :--- |
| **[70-80)** | 26,068 | **12.45%** | 🚨 High Risk |
| **[80-90)** | 17,197 | **12.18%** | 🚨 High Risk |
| [60-70) | 22,483 | 11.45% | Standard Risk |
| [50-60) | 17,256 | 10.37% | Standard Risk |
| [40-50) | 9,685 | 9.07% | Standard Risk |
| [30-40) | 3,775 | 8.32% | Standard Risk |

Methodology & Interpretation Logic

Technical Competencies

🏥 Project 1: CMS Operational Efficiency Index
Business Problem: CMS reports "Timeliness of Care" using qualitative text (e.g., "Above the national average"). I converted this to a 1–3 numerical index to identify regions at "Operational Risk."

The following table summarizes the calculated **Efficiency Index** (3.0 = High Efficiency, 1.0 = High Risk). 

| State | Avg Efficiency Index | Interpretation | Total Hospitals |
| :--- | :--- | :--- | :--- |
| **SD** | **2.93** | Above National Average (High Efficiency) | 15 |
| **WI** | **2.79** | Above National Average (High Efficiency) | 103 |
| **KS** | **2.70** | Above National Average (High Efficiency) | 63 |
| ... | ... | ... | ... |
| **NY** | 1.37 | Below National Average (Operational Risk) | 152 |
| **CT** | 1.33 | Below National Average (Operational Risk) | 27 |
| **NJ** | **1.19** | **Below National Average (Operational Risk)** | 63 |

Project 2: Diabetes 30-Day Readmission & LOS Analysis
Business Problem: High readmission rates trigger CMS financial penalties (HRRP). This project identifies the intersection of diagnosis type and Average Length of Stay (LOS).

📝 Technical Summary & Clinical Insight
The 12% Threshold: National clinical benchmarks for diabetic 30-day readmissions typically hover between 11% and 15%. By setting a 12% "High Risk" threshold, this query isolates diagnoses—specifically those in the [80-90) age bracket and specific circulatory codes—that are most likely to drive federal reimbursement penalties.


The LOS Correlation: The data reveals that a shorter Length of Stay (LOS) doesn't always correlate with higher readmissions; rather, specific primary diagnoses (diag_1) show "high-intensity" patterns where patients require longer stabilization periods to prevent immediate return.

MySQL Query: Clinical Drill-Down


Methodology & Interpretation Guide
To ensure the data is actionable for non-technical stakeholders, I mapped CMS qualitative markers to a 3-point scale:

3.0 (Above Average): Exceptional Performance.

2.0 (Same as Average): Target Baseline (Scores like 2.3 represent stable performance).

1.0 (Below Average): Critical Bottleneck.
