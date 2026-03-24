SELECT 
     job_id,
     name AS company_name,
    job_title_short,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date::date
FROM
    job_postings_fact as jp
LEFT JOIN
     company_dim as cd
ON
    jp.company_id = cd.company_id
WHERE
    job_title_short='Data Analyst'
    AND job_location ilike '%india'
    AND salary_year_avg is not null
ORDER BY
    salary_year_avg DESC
LIMIT 10
