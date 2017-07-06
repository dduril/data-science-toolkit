# Hive Tutorial

#### Basic Tutorial and Notes for programming and administration using Hive and HiveQL.

**Start Hive**

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











