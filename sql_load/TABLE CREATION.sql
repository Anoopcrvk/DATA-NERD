
-- CREATING A TABLE FROM AN EXISTING DATA


CREATE TABLE jan_2023_jobs
AS
SELECT * from job_postings_fact
WHERE 
    EXTRACT(MONTH from job_posted_date)=1 and EXTRACT(YEAR from job_posted_date)=2023;







CREATE TABLE feb_2023_jobs
AS
SELECT * from job_postings_fact
WHERE 
    EXTRACT(MONTH from job_posted_date)=2 and EXTRACT(YEAR from job_posted_date)=2023;





CREATE TABLE mar_2023_jobs
AS
SELECT * from job_postings_fact
WHERE 
    EXTRACT(MONTH from job_posted_date)=3 and EXTRACT(YEAR from job_posted_date)=2023;





-- RENAMING TABLES

alter table jan_2023_jobs
rename to january_jobs

alter table feb_2023_jobs
rename to february_jobs


alter table mar_2023_jobs
rename to march_jobs





SELECT * FROM january_jobs

SELECT * FROM february_jobs