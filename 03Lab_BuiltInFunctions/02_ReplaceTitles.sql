SELECT 
    replace(title, 'The', '***') title
FROM
    books
WHERE
    SUBSTR(title, 1, 3) = 'The'
ORDER BY id;
