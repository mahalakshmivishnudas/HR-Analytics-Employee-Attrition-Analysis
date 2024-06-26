SELECT * FROM hrdata

--KPI's requirements

-- 1.Calculate Total Employee Count 
SELECT COUNT(employee_count) as employee_count FROM hrdata

-- 2.Calculate Attrition Count
SELECT COUNT(attrition) as attrition_count FROM hrdata
WHERE attrition = 'Yes'

-- 3.Calculate Attrition rate
SELECT CAST(ROUND((CAST(SUM(CASE WHEN (attrition) = 'Yes' THEN 1 ELSE 0 END) AS DECIMAL(10, 2)) *100 
/ CAST(COUNT(*) AS DECIMAL(10, 2))), 2) AS DECIMAL(10, 2)) AS Employee_attritionrate
FROM hrdata

  -- 4.Calculate Active Employees
SELECT SUM(employee_count) - (select count(attrition) from hrdata where (attrition) = 'Yes')
from hrdata

-- 5.Calculate Average Age
SELECT (ROUND(CAST(AVG(Coalesce(age, 0.0)) AS DECIMAL(10, 0)), 0))  AS Avg_Age from hrdata



  --Chart's Requirements

--1.Calculate Attrition By Gender
SELECT COUNT(attrition) AS Attrition_By_Gender, gender FROM hrdata 
WHERE (attrition) = 'Yes'
GROUP BY gender
ORDER BY COUNT(attrition) DESC


--2.Calculate Department Wise Attrition
SELECT department, COUNT(attrition) AS Department_wise_attrition, ROUND((CAST(COUNT(attrition) AS NUMERIC) / 
(SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes'))*100, 2) AS Percentage 
FROM hrdata
WHERE (attrition) = 'Yes'
GROUP BY department
ORDER BY COUNT(attrition) DESC


--3.Calculate No.of Employee by Age Group
SELECT age, SUM(employee_count) AS Employee_Count FROM hrdata
GROUP BY age
ORDER BY age


--4.Calculate Education Field Wise Attrition
SELECT education_field, COUNT(attrition) AS attrition_count FROM hrdata 
WHERE (attrition) = 'Yes' 
GROUP BY education_field
ORDER BY COUNT(attrition) DESC


  --5.Calculate Attrition Rate by Gender for Different AgeGroup
SELECT age_band, gender, COUNT(attrition) as attrition_count, 
ROUND((CAST(COUNT(attrition) AS NUMERIC) / 
(SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes'))*100, 2) AS Percentage 
FROM hrdata
WHERE attrition = 'Yes' 
GROUP BY age_band, gender
ORDER BY age_band, gender DESC





