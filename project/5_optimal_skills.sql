WITH skills_demand AS
(
    SELECT
        sd.skill_id,
        sd.skills,
        count(sjd.job_id) as demand_count
    FROM job_postings_fact as jp
    INNER JOIN skills_job_dim  as sjd on jp.job_id=sjd.job_id
    INNER JOIN skills_dim as sd on sjd.skill_id=sd.skill_id
    WHERE
        job_title_short='Data Analyst' AND
        job_work_from_home= TRUE AND
        salary_year_avg is not NULL
    group BY
        sd.skill_id
  
),

 average_salary AS
(
        SELECT
            sd.skill_id,
            
            round(avg(salary_year_avg),0) as avg_salary 

        FROM job_postings_fact as jp
        INNER JOIN skills_job_dim  as sjd on jp.job_id=sjd.job_id
        INNER JOIN skills_dim as sd on sjd.skill_id=sd.skill_id
        WHERE
            job_title_short='Data Analyst' AND
            job_work_from_home= TRUE AND
            salary_year_avg is not NULL
        group BY
            sd.skill_id
    
)
select
    skills_demand. skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    average_salary.avg_salary
FROM
    skills_demand
INNER JOIN
    average_salary
ON skills_demand.skill_id=average_salary.skill_id
WHERE  
    demand_count>10

ORDER BY
    avg_salary DESC,
    demand_count DESC
    
-- or more concise
select
    skills_dim.skill_id,
    skills_dim.skills,
    count(job_postings_fact.job_id) as demand_count,
    round(avg(job_postings_fact.salary_year_avg),0) as avg_salary
FROM
    job_postings_fact
INNER JOIN
    skills_job_dim 
ON 
    job_postings_fact.job_id=skills_job_dim.job_id
INNER JOIN
    skills_dim 
ON 
    skills_job_dim.skill_id=skills_dim.skill_id
WHERE
    job_title_short='Data Analyst' AND    
    job_work_from_home= TRUE AND
    salary_year_avg is not null
group BY
    skills_dim.skill_id
having
 count(job_postings_fact.job_id)>10
ORDER BY
    avg_salary DESC,
    demand_count DESC

    