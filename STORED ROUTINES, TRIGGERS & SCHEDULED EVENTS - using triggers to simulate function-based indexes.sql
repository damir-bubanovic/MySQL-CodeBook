/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING TRIGGERS TO SIMULATE FUNCTION-BASED INDEXES!!

> You need a function-based index, but MySQL doesn’t support that capability

> Use a secondary column and triggers to simulate a function-based index

*/

/*
> Some types of information are more easily analyzed using not the original values, but
an expression computed from them
> A disadvantage of such expressions is that referring to the value column within a function
call prevents the optimizer from using any index on it

> SOLUTION:
	1. Define a secondary column to store the function values and index that column.
	2. Define triggers that keep the secondary column up to date when the original column
	is initialized or modified.
	3. Refer directly to the secondary column in queries so that the optimizer can use the
	index on it for efficient lookups.
*/

/*
EXAMPLE:
1) Table designed to store values that lie along an exponential curve

2) Create an INSERT trigger to initialize the log10_value value from value for new rows,
and an UPDATE trigger to keep log10_value up to date when value changes

3) To test the implementation, insert and modify some data and check the result of each
operation

4) With that implementation, using a log10_value column that stores the LOG10() values
of the value column, the SELECT query shown earlier can be rewritten


> Disadvantages of this technique
	• It requires extra storage for the secondary column.
	• It requires more processing for statements that modify the original column (to
	activate the triggers that keep the secondary column and its index up to date).
*/
1)
CREATE TABLE expdata
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
value FLOAT, # original values
log10_value FLOAT, # LOG10() function of original values
INDEX (value), # index on original values
INDEX (log10_value) # index on function-based values
);

2)
CREATE TRIGGER bi_expdata BEFORE INSERT ON expdata
FOR EACH ROW SET NEW.log10_value = LOG10(NEW.value);

CREATE TRIGGER bu_expdata BEFORE UPDATE ON expdata
FOR EACH ROW SET NEW.log10_value = LOG10(NEW.value);

3)
mysql> INSERT INTO expdata (value) VALUES (.01),(.1),(1),(10),(100);
mysql> SELECT * FROM expdata;

mysql> UPDATE expdata SET value = value * 10;
mysql> SELECT * FROM expdata;

4) SELECT * FROM expdata WHERE log10_value < 2;
