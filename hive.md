# Hive Tutorial

### Basic Tutorial and Notes for programming and administration using Hive and HiveQL.

Working from **Programming Hive** (*O'Reilly Media, Inc., 2012*)

### Data Ingestion

Load data from HiveQL script file:

	$ hive -f /home/cloudera/Desktop/programming_hive/data/data_ingest.hql

data_ingest.hql
	
	CREATE DATABASE IF NOT EXISTS prog_hive;
	
	USE prog_hive;
	
	CREATE EXTERNAL TABLE IF NOT EXISTS employees(
	name 			STRING,
	salary 			FLOAT,
	subordinates 	ARRAY<STRING>,
	deductions		MAP<STRING, FLOAT>,
	address			STRUCT<street:STRING, city:STRING, state:STRING, zip:INT>
	)
	COMMENT 'Employee data'
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY '\001'
	COLLECTION ITEMS TERMINATED BY '\002'
	MAP KEYS TERMINATED BY '\003'
	LINES TERMINATED BY '\n'
	STORED AS TEXTFILE;
	
	LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/programming_hive/data/employees/employees.txt' OVERWRITE INTO TABLE employees;
	
	CREATE EXTERNAL TABLE IF NOT EXISTS stocks(
	exchange_name	STRING,
	symbol 			STRING,
	ymd 			STRING,
	price_open 		FLOAT,
	price_high 		FLOAT,
	price_low 		FLOAT,
	price_close 	FLOAT,
	volume 			INT,
	price_adj_close FLOAT)
	COMMENT 'Financial data for Stocks'
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	STORED AS TEXTFILE;
	
	LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/programming_hive/data/stocks/stocks.csv' OVERWRITE INTO TABLE stocks;
	
	CREATE EXTERNAL TABLE IF NOT EXISTS dividends(
	exchange_name	STRING,
	symbol 			STRING,
	ymd 			STRING,
	dividend 		FLOAT)
	COMMENT 'Financial data for Dividends'
	ROW FORMAT DELIMITED
	FIELDS TERMINATED BY ','
	LINES TERMINATED BY '\n'
	STORED AS TEXTFILE;
	
	LOAD DATA LOCAL INPATH '/home/cloudera/Desktop/programming_hive/data/dividends/dividends.csv' OVERWRITE INTO TABLE dividends;

### Hive Session

**Starting Hive**

Silent mode ( -S, --silent), Verbose mode ( -v, --verbose)

	$ hive -S

**Databases and Tables**

Hive keywords are often capitalized - as in SHOW or USE, but this is not mandatory. When queries become more complex, readability can be improved by upper-casing the Hive keywords. Another argument can be made to lower-case the Hive keywords to speed up typing the complex multi-line queries. As is the case for many things in the programming world, it's up to the individual user and their style.

	hive> SHOW databases;
	default
	prog_hive
	stocks
	
	hive> USE prog_hive;
	
	hive> SHOW tables;
	dividends
	employees
	stocks

**View Table Schema**

	hive> DESCRIBE dividends;

	hive> DESCRIBE FORMATTER dividends;

**Select Queries**

	hive> SELECT * FROM dividends;

The above query will return all columns from the table with no ordering or limits. In most cases, it is better to refine the query:

	hive> SELECT symbol, divident, ymd FROM dividends ORDER BY symbol LIMIT 10;











