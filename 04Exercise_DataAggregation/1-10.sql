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

-- 06. Deposits Sum for Ollivander Family


SELECT 
    deposit_group, SUM(deposit_amount) AS total_sum
FROM
    wizzard_deposits
WHERE
    magic_wand_creator = 'Ollivander family'
GROUP BY deposit_group
ORDER BY deposit_group;


-- 07. Deposits Filter

SELECT 
    *
FROM
    (SELECT 
        deposit_group, SUM(deposit_amount) AS total_sum
    FROM
        wizzard_deposits
    WHERE
        magic_wand_creator = 'Ollivander family'
    GROUP BY deposit_group
    ORDER BY total_sum DESC) dep
WHERE
    total_sum < 150000;
    
-- 08. Deposit Charge

SELECT 
    deposit_group, magic_wand_creator, MIN(deposit_charge)
FROM
    wizzard_deposits
GROUP BY deposit_group , magic_wand_creator
ORDER BY magic_wand_creator , deposit_group;

-- 09. Age Groups

SELECT 
    age_group, SUM(wizard_count)
FROM
    (SELECT 
        CASE
                WHEN (age >= 0 AND age <= 10) THEN '[0-10]'
                WHEN (age >= 11 AND age <= 20) THEN '[11-20]'
                WHEN (age >= 21 AND age <= 30) THEN '[21-30]'
                WHEN (age >= 31 AND age <= 40) THEN '[31-40]'
                WHEN (age >= 41 AND age <= 50) THEN '[41-50]'
                WHEN (age >= 51 AND age <= 60) THEN '[51-60]'
                WHEN (age >= 61) THEN '[61+]'
            END AS 'age_group',
            COUNT(*) AS wizard_count
    FROM
        wizzard_deposits
    GROUP BY age
    ORDER BY age ASC) group_data
GROUP BY age_group;
