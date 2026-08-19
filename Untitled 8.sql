USE ROLE ACCOUNTADMIN;

create or replace masking policy emails as (val varchar) returns varchar ->
case
  when current_role() in ('ANALYST_FULL') then val
  when current_role() in ('ANALYST_MASKED') then regexp_replace(val,'.+\@','*****@') -- leave email domain unmasked
  else '********'
end;

alter table customers modify column email set masking policy emails

USE ROLE ANALYST_FULL;
SELECT * FROM CUSTOMERS;

USE ROLE ANALYST_MASKED;
SELECT * FROM CUSTOMERS;

USE ROLE ACCOUNTADMIN

create or replace masking policy sha2 as (val varchar) returns varchar ->
case 
    when current_role() in ('ANALYST_FULL') then val
    else sha2(val) --return hash of the column value
end

alter table if exists customers modify column full_name 
set masking policy sha2

use role analyst_full;
select * from customers;

use role analyst_masked;
select * from customers;

use role accountadmin;
alter table customers modify column email 
unset masking policy

create or replace masking policy dates as (val date) returns date ->
case 
    when current_role() in ('ANALYST_FULL') then val
    else date_from_parts(0001,01,01)::date 
end

alter table customers modify column create_date
set masking policy dates

