/*

!!VALIDATING & REFORMATING DATA - IMPORTING NON-ISO DATE VALUES!!

> Date values to be imported are not in the ISO (CCYY-MM-DD) format that MySQL expects

> Use an external utility to convert the dates to ISO format before importing the data into
MySQL (cvt_date.pl is useful here). 
> Or use LOAD DATA’s capability for preprocessing input data prior to loading it into the database

*/

/*
EXAMPLE:
1) Suppose that a table contains three columns, name, date, and value, where date is a
DATE column requiring values in ISO format

> The dates are in MM/DD/YY format and must be converted to ISO format to be stored as
DATE values in MySQL
2) One way to do this is to run the file through the cvt_date.pl script

> This task also can be accomplished entirely in MySQL with no external utilities by 
using SQL to perform the reformatting operation
3) Date-rewriting LOAD DATA statement looks like this, using the STR_TO_DATE() function

> If the dates are not in a format that STR_TO_DATE() can interpret, perhaps you can write
a stored function to handle them and return ISO date values. 
4) In that case, the LOAD DATA statement looks like this, where my_date_interp() is your 
stored function name
*/
2)
% cvt_date.pl --iformat=us --add-century newdata.txt > tmp.txt

3)
mysql> LOAD DATA LOCAL INFILE 'newdata.txt'
	-> INTO TABLE t (name,@date,value)
	-> SET date = STR_TO_DATE(@date,'%m/%d/%y');
	
4)
mysql> LOAD DATA LOCAL INFILE 'newdata.txt'
	-> INTO TABLE t (name,@date,value)
	-> SET date = my_date_interp(@date);