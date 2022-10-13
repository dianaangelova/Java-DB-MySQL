-- 11. Calculating Interest

DELIMITER $$

create procedure usp_calculate_future_value_for_account(id INT, interest_rate DECIMAL(10,4))
begin

select accounts.id, first_name, last_name, accounts.balance, ufn_calculate_future_value(accounts.balance, interest_rate, 5)
from accounts join account_holders on accounts.account_holder_id = account_holders.id and accounts.id = id;

end $$

DELIMITER ;

-- 12. Deposit Money

DELIMITER $$

create procedure usp_deposit_money(account_id INT, money_amount DECIMAL(10,4))
begin

start transaction;

IF (money_amount>0) then update accounts set balance = accounts.balance+money_amount
where accounts.id = account_id;
COMMIT;
else  rollback;
end if;
end $$

DELIMITER ;

-- 13. Withdraw Money

DELIMITER $$

create procedure usp_withdraw_money(account_id INT, money_amount DECIMAL(19,4))
begin
declare balance_var DECIMAL(19,4);
start transaction;

set balance_var:= (select balance from accounts where accounts.id = account_id);

IF (balance_var >= money_amount and money_amount>0 ) then update accounts set balance = accounts.balance-money_amount
where accounts.id = account_id;
COMMIT;
else  rollback;
end if;
end$$

DELIMITER ;

-- 14. Money Transfer

DELIMITER $$

create procedure usp_transfer_money(from_account_id INT, to_account_id INT, amount DECIMAL(19,4))
begin
declare from_account_valid INT DEFAULT NULL;
declare to_account_valid INT DEFAULT NULL;
declare from_balance DECIMAL(19,4);
start transaction;

set from_account_valid:= (select id from accounts where accounts.id = from_account_id);
set to_account_valid:= (select id from accounts where accounts.id = to_account_id);
set from_balance:= (select balance from accounts where accounts.id = from_account_id);

IF (from_account_valid is not NULL and to_account_valid is not NULL and  amount>0 and from_account_id!=to_account_id and (from_balance-amount)>=0) then 
update accounts set balance = accounts.balance-amount
where accounts.id = from_account_id;
update accounts set balance = accounts.balance+amount
where accounts.id = to_account_id;
COMMIT;
else  rollback;
end if;
end$$

DELIMITER ;