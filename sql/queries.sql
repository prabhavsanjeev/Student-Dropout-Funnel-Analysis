
-- Student Dropout Analysis - SQL Queries

-- Query 1: Dropout rate by course (courses with 100+ students)
SELECT 
    Course,
    COUNT(*) AS total_students,
    SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) AS dropouts,
    ROUND(SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS dropout_rate_pct
FROM students
GROUP BY Course
HAVING COUNT(*) >= 100
ORDER BY dropout_rate_pct DESC;


-- Query 2: Dropout rate by financial factors (scholarship, debtor, fees)
SELECT 
    "Scholarship holder",
    "Debtor",
    "Tuition fees up to date",
    COUNT(*) AS total_students,
    ROUND(SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS dropout_rate_pct
FROM students
GROUP BY "Scholarship holder", "Debtor", "Tuition fees up to date"
ORDER BY dropout_rate_pct DESC;


-- Query 3: CTE - High-risk groups (dropout rate > 30%) by scholarship & fees status
WITH risk_summary AS (
    SELECT 
        "Scholarship holder",
        "Tuition fees up to date",
        COUNT(*) AS total_students,
        ROUND(SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS dropout_rate_pct
    FROM students
    GROUP BY "Scholarship holder", "Tuition fees up to date"
)
SELECT * FROM risk_summary
WHERE dropout_rate_pct > 30
ORDER BY dropout_rate_pct DESC;


-- Query 4: Window Function - Ranking courses by dropout risk
SELECT 
    Course,
    COUNT(*) AS total_students,
    ROUND(SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS dropout_rate_pct,
    RANK() OVER (ORDER BY ROUND(SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) DESC) AS risk_rank
FROM students
GROUP BY Course
HAVING COUNT(*) >= 100
ORDER BY risk_rank
LIMIT 10;


-- Query 5: JOIN - Dropout rate by risk category (using risk_lookup reference table)
SELECT 
    r."Risk Category",
    COUNT(*) AS total_students,
    ROUND(SUM(CASE WHEN s.target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS dropout_rate_pct
FROM students s
JOIN risk_lookup r
    ON s."Scholarship holder" = r."Scholarship holder"
    AND s."Tuition fees up to date" = r."Tuition fees up to date"
GROUP BY r."Risk Category"
ORDER BY dropout_rate_pct DESC;


-- Query 6: CASE WHEN - Dropout rate by age group
SELECT 
    CASE 
        WHEN "Age at enrollment" <= 19 THEN 'Teen (<=19)'
        WHEN "Age at enrollment" BETWEEN 20 AND 25 THEN 'Young Adult (20-25)'
        ELSE 'Mature (26+)'
    END AS age_group,
    COUNT(*) AS total_students,
    ROUND(SUM(CASE WHEN target = 'Dropout' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS dropout_rate_pct
FROM students
GROUP BY age_group
ORDER BY dropout_rate_pct DESC;


-- Query 7: Academic & economic factors by outcome
SELECT 
    target,
    ROUND(AVG("Admission grade"), 2) AS avg_admission_grade,
    ROUND(AVG("Curricular units 1st sem (grade)"), 2) AS avg_1st_sem_grade,
    ROUND(AVG("Unemployment rate"), 2) AS avg_unemployment_rate
FROM students
GROUP BY target;