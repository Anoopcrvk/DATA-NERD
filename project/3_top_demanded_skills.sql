SELECT
    skills,
    count(sjd.job_id) as demand_count
FROM job_postings_fact as jp
INNER JOIN skills_job_dim  as sjd on jp.job_id=sjd.job_id
INNER JOIN skills_dim as sd on sjd.skill_id=sd.skill_id
WHERE
    job_title_short='Data Analyst' AND
    job_location ilike '%india'
group BY
    skills
ORDER BY 
   demand_count DESC
LIMIT 5
    