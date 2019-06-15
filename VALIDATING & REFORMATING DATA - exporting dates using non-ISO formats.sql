/*

!!VALIDATING & REFORMATING DATA - EXPORTING DATES USING NON-ISO FORMATS!!

> You want to export date values using a format other than MySQL’s default ISO (CCYYMM-
DD) format. 
	>> This might be a requirement when exporting dates from MySQL to applications 
	that don’t use ISO format
	
> Use an external utility to rewrite the dates to non-ISO format after exporting the data
from MySQL (cvt_date.pl is useful here). 
> Or use the DATE_FORMAT() function to rewrite the values during the export operation

*/

/*
1) One way to do this is to export the data into a file, leaving the dates in ISO format. 
Then run the file through a utility such as cvt_date.pl that rewrites the dates into the 
required format

2) Another approach is to export the dates directly in the required format by rewriting
them with DATE_FORMAT(). 
	2.1) Suppose that you have the following table
	2.2) Suppose also that you need to export data from this table, but with the dates in any DATE,
		DATETIME, or TIMESTAMP columns rewritten in US format (MM-DD-CCYY). A SELECT
		statement that uses the DATE_FORMAT() function to rewrite the dates as required looks
		like this
*/
2.1)
CREATE TABLE datetbl
(
i INT,
c CHAR(10),
d DATE,
dt DATETIME,
ts TIMESTAMP
);

2.2)
SELECT
i,
c,
DATE_FORMAT(d, '%m-%d-%Y') AS d,
DATE_FORMAT(dt, '%m-%d-%Y %T') AS dt,
DATE_FORMAT(ts, '%m-%d-%Y %T') AS ts
FROM datetbl
