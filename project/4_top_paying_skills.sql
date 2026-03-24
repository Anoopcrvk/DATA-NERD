SELECT
    skills,
    round(avg(salary_year_avg),0) as avg_salary 

FROM job_postings_fact as jp
INNER JOIN skills_job_dim  as sjd on jp.job_id=sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id=sd.skill_id
WHERE
    job_title_short='Data Analyst' 
    AND  job_location ilike '%india'
    AND salary_year_avg is not null
group BY
    skills
ORDER BY
    avg_salary DESC
LIMIT 25