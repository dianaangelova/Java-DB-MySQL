-- 01. Records’ Count

use gringotts;

SELECT 
    COUNT(id)
FROM
    wizzard_deposits;
    
    
-- 02. Longest Magic Wand

SELECT 
    MAX(magic_wand_size) AS 'longest_magic_wand'
FROM
    wizzard_deposits;
    

-- 03. Longest Magic Wand per Deposit Groups

																																																																																																																																																																																																																																					
