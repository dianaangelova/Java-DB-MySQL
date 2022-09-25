SELECT 
    *
FROM
    projects
WHERE
    start_date is not  NULL
ORDER BY start_date , name , project_id
limit 10;