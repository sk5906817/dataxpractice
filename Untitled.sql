create file format ff_csv
type=csv
skip_header=1
field_delimiter=','
trim_space=True

create or replace stage stg_orders
file_format=ff_csv

create or replace stage stg_customers
file_format=ff_csv

CREATE OR REPLACE TABLE customers_raw (
  customer_id STRING,
  customer_name STRING,
  email STRING,
  city STRING,
  updated_at TIMESTAMP_NTZ
);

select * from customers_raw
