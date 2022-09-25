 CREATE OR REPLACE VIEW v_employees_job_titles AS
    SELECT 
    CONCAT(first_name,
            ' ',
            middle_name,
            ' ',
            last_name) full_name,
    job_title
FROM
    employees;