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

SELECT 
    deposit_group, MAX(magic_wand_size) as longest_magic_wand
FROM
    wizzard_deposits
GROUP BY deposit_group
order by  longest_magic_wand, deposit_group;																																																																																																																																																																																																																																								


-- 04. Smallest Deposit Group per Magic Wand Size

SELECT 
    deposit_group
FROM
    wizzard_deposits
GROUP BY deposit_group 
order by AVG(magic_wand_size)
LIMIT 1;	

-- 05. Deposits Sum

SELECT 
    deposit_group, SUM(deposit_amount) as total_sum
FROM
    wizzard_deposits
GROUP BY deposit_group
order by  total_sum;


