-- practice problems 1


SELECT
     job_schedule_type,
    avg(salary_year_avg) as yearly_salary,
    avg(salary_hour_avg) as hourly_salary
    
   
FROM
    job_postings_fact
WHERE
    job_posted_date>'2023-06-1'
GROUP BY
    job_schedule_type
ORDER BY
    yearly_salary;







-- practice problems 2


SELECT
    count(job_id) as job_count,
    EXTRACT(MONTH from job_posted_date at time zone 'utc' at time zone 'America/New_York') as posted_month
FROM
    job_postings_fact
where 
    EXTRACT(YEAR from job_posted_date at time zone 'utc' at time zone 'America/New_York')=2023
group BY
    posted_month
ORDER BY
    posted_month;




 -- practice problem 3

SELECT

    distinct cd.name as company,
    job_health_insurance as insurance,
    EXTRACT(month from job_posted_date) as month
    
FROM
    company_dim as cd
join
    job_postings_fact as jp 
on
    cd.company_id= jp.company_id
WHERE 
    job_health_insurance= true and (EXTRACT(quarter from job_posted_date)=2 and EXTRACT(year from job_posted_date)=2023)


SELECT 
    customer_id,
    AVG(order_total) AS avg_order_value
FROM orders
GROUP BY customer_id