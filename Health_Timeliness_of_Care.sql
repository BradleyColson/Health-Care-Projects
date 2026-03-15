-- Step 1: Using a CTE to map text to numbers
WITH StateEfficiency AS (
    SELECT 
        `State`,
        CASE 
            WHEN `Timeliness of care national comparison` = 'Above the national average' THEN 3
            WHEN `Timeliness of care national comparison` = 'Same as the national average' THEN 2
            WHEN `Timeliness of care national comparison` = 'Below the national average' THEN 1
            ELSE NULL 
        END AS Timeliness_Score
    FROM HospInfo
)
-- Step 2: Aggregating scores by State
SELECT 
    `State`,
    ROUND(AVG(Timeliness_Score), 2) AS Avg_Efficiency_Index,
    COUNT(*) AS Hospital_Count
FROM StateEfficiency
WHERE Timeliness_Score IS NOT NULL
GROUP BY `State`
HAVING COUNT(*) > 10
ORDER BY Avg_Efficiency_Index DESC;

SELECT 
    `State`,
    Avg_Efficiency_Index,
    CASE 
        WHEN Avg_Efficiency_Index >= 2.5 THEN 'Above National Average (High Efficiency)'
        WHEN Avg_Efficiency_Index >= 1.8 THEN 'Same as National Average (Target Performance)'
        ELSE 'Below National Average (Operational Risk)'
    END AS Performance_Status,
    Total_Hospitals
FROM AggregatedEfficiency
ORDER BY Avg_Efficiency_Index DESC;




-------------------------------------------------------------------

-- Project 1: ED Operational Efficiency
-- This query calculates the score and interprets it in one step
SELECT 
    `State`,
    ROUND(AVG(CASE 
        WHEN `Timeliness of care national comparison` = 'Above the national average' THEN 3
        WHEN `Timeliness of care national comparison` = 'Same as the national average' THEN 2
        WHEN `Timeliness of care national comparison` = 'Below the national average' THEN 1
        ELSE NULL 
    END), 2) AS Avg_Efficiency_Index,
    -- This section defines what the number (e.g. 2.3) actually means
    CASE 
        WHEN AVG(CASE 
            WHEN `Timeliness of care national comparison` = 'Above the national average' THEN 3
            WHEN `Timeliness of care national comparison` = 'Same as the national average' THEN 2
            WHEN `Timeliness of care national comparison` = 'Below the national average' THEN 1
            ELSE NULL END) >= 2.5 THEN 'Above National Average (High Efficiency)'
        WHEN AVG(CASE 
            WHEN `Timeliness of care national comparison` = 'Above the national average' THEN 3
            WHEN `Timeliness of care national comparison` = 'Same as the national average' THEN 2
            WHEN `Timeliness of care national comparison` = 'Below the national average' THEN 1
            ELSE NULL END) >= 1.8 THEN 'Same as National Average (Target Performance)'
        ELSE 'Below National Average (Operational Risk)'
    END AS Interpretation,
    COUNT(*) AS Total_Hospitals
FROM HospInfo
WHERE `Timeliness of care national comparison` != 'Not Available'
GROUP BY `State`
HAVING Total_Hospitals > 10
ORDER BY Avg_Efficiency_Index DESC;


-----------------------------------------------------------------

