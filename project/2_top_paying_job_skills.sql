WITH top_paying_job_skills AS
    (
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
    LIMIT
        10

)
select
    top_paying_job_skills.*,
    skills
from top_paying_job_skills
inner JOIN skills_job_dim on top_paying_job_skills.job_id =skills_job_dim.job_id 
inner JOIN skills_dim on  skills_job_dim.skill_id = skills_dim.skill_id

ORDER BY
    salary_year_avg DESC




/*
[
  {
    "skills": "pyspark",
    "avg_salary": "165000"
  },
  {
    "skills": "gitlab",
    "avg_salary": "165000"
  },
  {
    "skills": "postgresql",
    "avg_salary": "165000"
  },
  {
    "skills": "linux",
    "avg_salary": "165000"
  },
  {
    "skills": "mysql",
    "avg_salary": "165000"
  },
  {
    "skills": "neo4j",
    "avg_salary": "163782"
  },
  {
    "skills": "gdpr",
    "avg_salary": "163782"
  },
  {
    "skills": "airflow",
    "avg_salary": "138088"
  },
  {
    "skills": "mongodb",
    "avg_salary": "135994"
  },
  {
    "skills": "scala",
    "avg_salary": "135994"
  },
  {
    "skills": "databricks",
    "avg_salary": "135994"
  },
  {
    "skills": "pandas",
    "avg_salary": "122463"
  },
  {
    "skills": "kafka",
    "avg_salary": "122100"
  },
  {
    "skills": "confluence",
    "avg_salary": "119250"
  },
  {
    "skills": "visio",
    "avg_salary": "119250"
  },
  {
    "skills": "shell",
    "avg_salary": "118500"
  },
  {
    "skills": "spark",
    "avg_salary": "118332"
  },
  {
    "skills": "jira",
    "avg_salary": "115213"
  },
  {
    "skills": "no-sql",
    "avg_salary": "114291"
  },
  {
    "skills": "hadoop",
    "avg_salary": "113276"
  },
  {
    "skills": "snowflake",
    "avg_salary": "111213"
  },
  {
    "skills": "matplotlib",
    "avg_salary": "111175"
  },
  {
    "skills": "dax",
    "avg_salary": "111175"
  },
  {
    "skills": "bash",
    "avg_salary": "111175"
  },
  {
    "skills": "electron",
    "avg_salary": "111175"
  }
]
*/