# Introduction
This project uses SQL to analyze Data Analyst job postings and identify top-paying roles 💰, most in-demand skills 📊, and the skills that offer the best combination of high demand and high salary 🚀. It demonstrates practical data analysis and provides insights into the most valuable skills for career growth 📈.

for sql queries check this out - 
[project folder](/project/)
# Background


As the demand for Data Analysts grows with the rise of data-driven decision making, understanding which skills are most valuable and how they impact salary can be challenging for beginners. Using a real world dataset of job postings, the analysis examines the relationship between skills, demand, and compensation to provide clear insights into the key skills that support career growth in the data analytics field.

# Tools I used

- **SQL** – Used to query the dataset, filter job postings, calculate averages, and count skill demand. It helped me uncover insights like top-paying jobs and the most in-demand skills.
- **PostgreSQL** – Served as the database engine to store and manage the simulated dataset. I ran all SQL queries here and tested different analysis scenarios efficiently.
- **VS Code** – Used as my main editor to write SQL scripts, organize project files, and integrate Git for version control. It kept everything structured and easy to manage.
-**Git**– Tracked changes in my project, allowing me to safely commit updates and maintain a history of my work while experimenting with queries.
- **GitHub** – Hosted the repository online so I could share my project, back up my work, and have a central place for the final version
## Here’s what I aimed to achieve with this project

1. what are the top-paying data analyst jobs in india?
2. what skills are required for these top-paying jobs?
3. what skills are most in demand for data analysts?
4. which skills are associated with higher salaries?
5. what are the most optimal skills to learn?



# Analysis & Insights
 ### **what are the top-paying data analyst jobs in india?**

To identify the top-paying Data Analyst jobs in India, I filtered the dataset for full-time Data Analyst positions and sorted the results by average yearly salary in descending order. The analysis revealed that companies like ServiceNow, Bosch Group, Srijan Technologies, and Eagle Genomics Ltd offer the highest-paying roles, with salaries ranging from ₹163,782 to ₹177,283 per year. Most of these high-paying positions are concentrated in Hyderabad, Bengaluru, and Gurugram, highlighting the key cities where top-paying opportunities are available. This insight helps aspiring Data Analysts focus their job search on companies and locations that offer the best salary

``` sql
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
```

### **what skills are required for these top-paying jobs?**

To understand which skills are most important for top-paying Data Analyst roles in India, I analyzed the top 10 highest-paying full-time positions. The analysis shows that SQL and Python dominate the requirements, highlighting their critical role in securing high-paying positions. Most other skills appear less frequently but still add significant value for candidates aiming for these roles.

Key skill counts from the top-paying jobs:

**SQL** – 7 jobs

**Python** – 5 jobs


**Oracle, Spark, Azure, AWS, MongoDB, Excel, Power BI** – 3 jobs each

**Scala, Go, Hadoop, Databricks, GDPR, NoSQL, Flow, Jira** – 2 jobs each

**Tableau, SQL Server, MySQL, PostgreSQL, SAP, Jenkins, GitLab, Airflow, Kafka, Visio, Confluence, PowerPoint, Outlook, Slack** – 1 job each

``` sql
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
``` 

### **What skills are most in demand for data analysts?**

To identify the most in-demand skills for Data Analysts in India, I analyzed job postings for full-time Data Analyst roles across the country. The analysis reveals that companies are looking for a combination of programming, data handling, and visualization skills to equip analysts to work effectively with large datasets and provide actionable insights.

Top 5 most in-demand skills (with number of job postings requiring each):

**SQL** – 2,561 jobs: The most critical skill for querying and managing structured data.

**Python** – 1,802 jobs: Widely used for data analysis, automation, and statistical modeling.

**Excel** – 1,718 jobs: Essential for reporting, data manipulation, and quick analytics.

**Tableau** – 1,346 jobs: Popular for data visualization and dashboard creation.

**Power BI** – 1,043 jobs: Increasingly used for business intelligence and interactive reporting.

Key Insights:

SQL and Python are foundational – Almost all Data Analyst roles in India require these skills, making them non-negotiable for aspiring analysts.
Data visualization is highly valued – Tools like Tableau and Power BI appear frequently, indicating employers want analysts who can translate data into actionable insights.
Excel remains relevant – Despite the rise of programming and BI tools, Excel continues to be widely demanded for reporting and data manipulation tasks

```sql
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
```

### **which skills are associated with higher salaries?**

Analyzing top-paying Data Analyst roles in India reveals that certain advanced technical skills are strongly associated with higher salaries.

Top skills linked to the highest average salaries (₹165,000/year):

**PySpark** – Advanced data processing in distributed systems.

**GitLab** – Version control and collaboration for code and pipelines.

**PostgreSQL** – Advanced relational database management.

**Linux** – System-level expertise for data operations.

**MySQL** – Database design, querying, and management.

```
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
```


### **what are the most optimal skills to learn?**

When considering both salary potential and job demand, certain skills emerge as highly valuable for Data Analysts, especially for work-from-home positions in India.

Top optimal skills:

**Go** – High average salary (₹115,320) with 27 postings.

**Hadoop** – Big data expertise, average salary ₹113,193, 22 postings.

**Snowflake** – Cloud data warehousing, average salary ₹112,948, 37 postings.

**Azure** – Cloud platform knowledge, average salary ₹111,225, 34 postings.

**AWS** – Cloud infrastructure, average salary ₹108,317, 32 postings.

Skills with high demand even if slightly lower pay:

**Python** – Extremely high demand (236 postings), average salary ₹101,397.

**SQL** – Most in-demand (398 postings), average salary ₹97,237.

**Excel** – Widely required (256 postings), average salary ₹87,288.

**Tableau & Power BI** – Popular visualization tools, 230 and 110 postings, salaries around ₹99,288 and ₹97,431 respectively.

Key Insights:

To maximize earnings, focus on cloud, big data, and advanced technical skills like Go, Hadoop, Snowflake, Azure, and AWS.

To ensure employability, include foundational and highly demanded skills like Python, SQL, Excel, and Tableau/Power BI.

A balanced skill set combining high-paying technical skills and widely required tools will make a candidate highly competitive.

```

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
```

# What I Learned

This data analyst experience has sharpened both my technical expertise and problem-solving mindset:

**Mastering SQL Techniques**: Developed strong proficiency in writing complex SQL queries, including multi-table joins and advanced filtering to extract meaningful insights from large datasets.

**Effective Data Summarization**: Leveraged aggregation functions like COUNT, AVG, and SUM to succinctly summarize data trends and support decision-making processes.

**Insight-Driven Analysis**: Enhanced my ability to translate raw data into clear, actionable business insights by crafting precise and optimized queries.

**Market-Ready Skill Set**: Gained clarity on the most valuable skills in the field, such as Python programming, visualization tools like Tableau and Power BI, and cloud platforms, aligning my learning with industry demands.

**Holistic Approach**: Recognized the importance of combining technical know-how with critical thinking and communication skills to deliver impactful results.


# Conclusion

This journey has not only equipped me with essential technical skills like advanced SQL, data aggregation, and visualization but also strengthened my analytical thinking and problem-solving abilities. Understanding the key skills in demand and those linked to higher salaries has helped me strategically focus my learning path. By blending technical expertise with business insight, I’m now better prepared to contribute meaningfully to data-driven projects and drive informed decision-making in any organization.