ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN full_name 
SET MASKING POLICY phone;
ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN phone
SET MASKING POLICY phone;

use role analyst_masked
select * from customers

SELECT * FROM table(information_schema.policy_references(policy_name=>'phone'));

ALTER TABLE IF EXISTS CUSTOMERS MODIFY COLUMN phone 
UNSET MASKING POLICY;
use role analyst_masked;
select * from customers;


create or replace masking policy names as (val varchar) returns varchar ->
            case
            when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
            else CONCAT(LEFT(val,2),'*******')
            end;

alter table customers modify column full_name
set masking policy names

use role analyst_masked;
select * from customers

create or replace masking policy phone as (val varchar) returns varchar ->
            case
            when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
            else CONCAT(LEFT(val,2),'*******')
            end;

alter table customers modify column phone set masking policy phone


USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS;

use role accountadmin

alter masking policy phone set body ->
case        
 when current_role() in ('ANALYST_FULL', 'ACCOUNTADMIN') then val
 else '**-**-**'
 end;

USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS; 