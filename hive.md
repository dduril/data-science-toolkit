# Hive Tutorial

### Basic Tutorial and Notes for programming and administration using Hive and HiveQL.

Working from **Programming Hive** (*O'Reilly Media, Inc., 2012*)

Notes:

Downloaded and installed datasets and working on a virtual machine running... TODO...

TODO...Coding queries and views to learn how to work with Hive.

---

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

---

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

DESCRIBE DATABASE [database] will show table comments and the directory location for the database:

	hive> DESCRIBE DATABASE prog_hive;
	
USE the prog_hive database:

	hive> USE prog_hive;
	
	hive> SHOW tables;
	dividends
	employees
	stocks
	
**View Table Schema**

There us also a more detailed DESCRIBE EXTENDED and DESCRIBE FORMATTED commands

	hive> DESCRIBE dividends;
	exchange_name       	string              	                    
	symbol              	string              	                    
	ymd                 	string              	                    
	dividend            	float               	                    
	
	hive> DESCRIBE employees;
	name                	string              	                    
	salary              	float               	                    
	subordinates        	array<string>       	                    
	deductions          	map<string,float>   	                    
	address             	struct<street:string,city:string,state:string,zip:int>	                    
	
	hive> DESCRIBE stocks;
	exchange_name       	string              	                    
	symbol              	string              	                    
	ymd                 	string              	                    
	price_open          	float               	                    
	price_high          	float               	                    
	price_low           	float               	                    
	price_close         	float               	                    
	volume              	int                 	                    
	price_adj_close     	float               	                    
	
**Check Table Counts**

	hive> select count(*) from dividends;
	15208
	
	hive> select count(*) from employees;
	7
	
	hive> select count(*) from stocks;
	2075394


	hive> DESCRIBE FORMATTED dividends;

**Select Queries**

	hive> SELECT * FROM dividends;

The above query will return all columns from the table with no ordering or limits. In most cases, it is better to refine the query:

	hive> SELECT symbol, divident, ymd FROM dividends ORDER BY symbol LIMIT 10;

**Additional Queries and Output**

	hive> SELECT name, salary FROM employees;
	John Doe	100000.0
	Mary Smith	80000.0
	Todd Jones	70000.0
	Bill King	60000.0
	Boss Man	200000.0
	Fred Finance	150000.0
	Stacy Accountant	60000.0
	
	hive> SELECT name, subordinates FROM employees;
	John Doe	["Mary Smith","Todd Jones"]
	Mary Smith	["Bill King"]
	Todd Jones	[]
	Bill King	[]
	Boss Man	["John Doe","Fred Finance"]
	Fred Finance	["Stacy Accountant"]
	Stacy Accountant	[]
	
	hive> SELECT name, deductions FROM employees;
	John Doe	{"Federal Taxes":0.2,"State Taxes":0.05,"Insurance":0.1}
	Mary Smith	{"Federal Taxes":0.2,"State Taxes":0.05,"Insurance":0.1}
	Todd Jones	{"Federal Taxes":0.15,"State Taxes":0.03,"Insurance":0.1}
	Bill King	{"Federal Taxes":0.15,"State Taxes":0.03,"Insurance":0.1}
	Boss Man	{"Federal Taxes":0.3,"State Taxes":0.07,"Insurance":0.05}
	Fred Finance	{"Federal Taxes":0.3,"State Taxes":0.07,"Insurance":0.05}
	Stacy Accountant	{"Federal Taxes":0.15,"State Taxes":0.03,"Insurance":0.1}
	
	hive> SELECT name, address FROM employees;
	John Doe	{"street":"1 Michigan Ave.","city":"Chicago","state":"IL","zip":60600}
	Mary Smith	{"street":"100 Ontario St.","city":"Chicago","state":"IL","zip":60601}
	Todd Jones	{"street":"200 Chicago Ave.","city":"Oak Park","state":"IL","zip":60700}
	Bill King	{"street":"300 Obscure Dr.","city":"Obscuria","state":"IL","zip":60100}
	Boss Man	{"street":"1 Pretentious Drive.","city":"Chicago","state":"IL","zip":60500}
	Fred Finance	{"street":"2 Pretentious Drive.","city":"Chicago","state":"IL","zip":60500}
	Stacy Accountant	{"street":"300 Main St.","city":"Naperville","state":"IL","zip":60563}
	
	--
	-- example of accessing an element from an array type
	-- subordinates        	array<string>       	                    
	--

	hive> SELECT name, subordinates[0] FROM employees;
	John Doe	Mary Smith
	Mary Smith	Bill King
	Todd Jones	NULL
	Bill King	NULL
	Boss Man	John Doe
	Fred Finance	Stacy Accountant
	Stacy Accountant	NULL
	
	--
	-- example of accessing a key from a map type - Federal Taxes, State Taxes, or Insurance
	-- deductions          	map<string,float>   	                    
	--

	hive> SELECT name, deductions["State Taxes"] FROM employees;
	John Doe	0.05
	Mary Smith	0.05
	Todd Jones	0.03
	Bill King	0.03
	Boss Man	0.07
	Fred Finance	0.07
	Stacy Accountant	0.03
	
	--
	-- example of accessing a field from a struct type - street, city, state, or zip
	-- address             	struct<street:string,city:string,state:string,zip:int>
	--

	hive> SELECT name, address.city FROM employees;
	John Doe	Chicago
	Mary Smith	Chicago
	Todd Jones	Oak Park
	Bill King	Obscuria
	Boss Man	Chicago
	Fred Finance	Chicago
	Stacy Accountant	Naperville

**Using Functions**

	hive> SELECT upper(name), salary, deductions["Federal Taxes"], 
	    > round(salary * (1 - deductions["Federal Taxes"])) 
	    > FROM employees;
	JOHN DOE			100000.0	0.2		80000.0
	MARY SMITH			80000.0		0.2		64000.0
	TODD JONES			70000.0		0.15	59500.0
	BILL KING			60000.0		0.15	51000.0
	BOSS MAN			200000.0	0.3		140000.0
	FRED FINANCE		150000.0	0.3		105000.0
	STACY ACCOUNTANT	60000.0		0.15	51000.0
	
	hive> SELECT count(*), round(avg(salary), 2) FROM employees;
	7	102857.14
	
	hive> SELECT count(DISTINCT symbol) FROM stocks;
	743
	
	hive> SELECT explode(subordinates) AS sub FROM employees;
	Mary Smith
	Todd Jones
	Bill King
	John Doe
	Fred Finance
	Stacy Accountant
	
	
	hive> SELECT name AS Name, length(name) AS LengthOfName, 
	    > upper(name) AS UpperName, lower(name) AS LowerName 
	    > FROM employees ORDER BY name ASC;
	Bill King			9	BILL KING			bill king
	Boss Man			8	BOSS MAN			boss man
	Fred Finance		12	FRED FINANCE		fred finance
	John Doe			8	JOHN DOE			john doe
	Mary Smith			10	MARY SMITH			mary smith
	Stacy Accountant	16	STACY ACCOUNTANT	stacy accountant
	Todd Jones			10	TODD JONES			todd jones

**LIMIT Clause**

	hive> SELECT upper(name), salary, deductions["Federal Taxes"], 
	    > round(salary * (1 - deductions["Federal Taxes"])) 
	    > FROM employees LIMIT 2;
	JOHN DOE	100000.0	0.2		80000.0
	MARY SMITH	80000.0		0.2		64000.0

**Column Aliases**

	hive> SELECT upper(name), salary, deductions["Federal Taxes"] AS fed_taxes, 
	    > round(salary * (1 - deductions["Federal Taxes"])) AS salary_minus_fed_taxes 
	    > FROM employees LIMIT 2;
	JOHN DOE	100000.0	0.2		80000.0
	MARY SMITH	80000.0		0.2		64000.0

**Nested SELECT Statements**

	hive> FROM (
        > SELECT upper(name), salary, deductions["Federal Taxes"] AS fed_taxes,
        > round(salary * (1 - deductions["Federal Taxes"])) AS salary_minus_fed_taxes
        > FROM employees
        > ) e
        > SELECT e.name, e.salary_minus_fed_taxes
        > WHERE e.salary_minus_fed_taxes > 70000;
	JOHN DOE	100000.0	0.2		80000.0

**CASE...WHEN...THEN Statements**

	hive> SELECT name, salary,
        > CASE
        > WHEN salary < 50000.0 THEN 'low'
        > WHEN salary >= 50000.0 AND salary < 70000.0  THEN 'middle'
        > WHEN salary >= 70000.0 AND salary < 100000.0  THEN 'high'
        > ELSE 'very high'
        > END AS bracket FROM employees;
	John Doe			100000.0	very high
	Mary Smith			80000.0		high
	Todd Jones			70000.0		high
	Bill King			60000.0		middle
	Boss Man			200000.0	very high
	Fred Finance		150000.0	very high
	Stacy Accountant	60000.0		middle

**WHERE Clauses**

	hive> SELECT name, address.street, address.city, address.state, address.zip 
	    > FROM employees
        > WHERE address.city = 'Chicago' AND address.state = 'IL';
	John Doe		1 Michigan Ave.			Chicago	IL	60600
	Mary Smith		100 Ontario St.			Chicago	IL	60601
	Boss Man		1 Pretentious Drive.	Chicago	IL	60500
	Fred Finance	2 Pretentious Drive.	Chicago	IL	60500

**LIKE and RLIKE**

	hive> SELECT name, address.street FROM employees WHERE address.street LIKE '%Ave.';
	John Doe		1 Michigan Ave.
	Todd Jones		200 Chicago Ave.

	hive> SELECT name, address.street FROM employees WHERE address.street LIKE '2%';
	Todd Jones		200 Chicago Ave.
	Fred Finance	2 Pretentious Drive.

	hive> SELECT name, address.street FROM employees WHERE address.street LIKE '%P%';
	Boss Man		1 Pretentious Drive.
	Fred Finance	2 Pretentious Drive.

	hive> SELECT  name, address.street
        > FROM employees WHERE address.street RLIKE '.*(Chicago|Ontario).*';
	Mary Smith	100 Ontario St.
	Todd Jones	200 Chicago Ave.

**GROUP BY Clauses**

	hive> SELECT year(ymd), avg(price_close) FROM stocks
        > WHERE exchange_name = 'NASDAQ' AND symbol = 'AAPL'
        > GROUP BY year(ymd);
	1984	25.578625440597534
	1985	20.193676221040867
	1986	32.46102808021274
	1987	53.88968399108163
	1988	41.540079275138766
	1989	41.65976212516664
	1990	37.56268799823263
	1991	52.49553383386182
	1992	54.80338610251119
	1993	41.02671956450572
	...

**HAVING Clauses**

	hive> SELECT year(ymd), avg(price_close) FROM stocks
	    > WHERE exchange_name = 'NASDAQ' AND symbol = 'AAPL'
	    > GROUP BY year(ymd)
	    > HAVING avg(price_close) > 50.0;
	1987	53.88968399108163
	1991	52.49553383386182
	1992	54.80338610251119
	1999	57.77071460844979
	2000	71.74892876261757
	2005	52.401745992993554
	2006	70.81063753105255
	2007	128.27390423049016
	2008	141.9790115054888
	2009	146.81412711976066
	2010	204.72159912109376

**JOIN Statements**

**Inner JOIN**

	hive> SELECT a.ymd, a.price_close, b.price_close
        > FROM stocks a JOIN stocks b ON a.ymd = b.ymd
        > WHERE a.symbol = 'AAPL' AND b.symbol = 'IBM'
        > LIMIT 10;
	1984-09-07	26.5	121.62
	1984-09-10	26.37	122.75
	1984-09-11	26.87	122.25
	1984-09-12	26.12	122.5
	1984-09-13	27.5	126.12
	1984-09-14	27.87	126.75
	1984-09-17	28.62	127.62
	1984-09-18	27.62	126.62
	1984-09-19	27.0	125.87
	1984-09-20	27.12	126.0

**LEFT OUTER JOIN**

**RIGHT OUTER JOIN**

**FULL OUTER JOIN**

**LEFT SEMI-JOIN**

**ORDER BY and SORT BY**

**DISTRIBUTE BY with SORT BY**

**CLUSTER BY**

**Casting**








