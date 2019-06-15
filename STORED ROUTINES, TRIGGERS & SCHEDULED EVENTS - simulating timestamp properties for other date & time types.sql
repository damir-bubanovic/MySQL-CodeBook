/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - SIMULATING TIMESTAMP PROPERTIES FOR OTHER DATE & TIME TYPES!!

> The TIMESTAMP data type provides auto-initialization and auto-update properties. 
	>> You would like to use these properties for other temporal data types that permit only constant
	values for initialization and don’t auto-update

> Use an INSERT trigger to provide the appropriate current date or time value at row creation time. 
	>> Use an UPDATE trigger to update the column to the current date or time when the row is changed

*/

/*
PROBLEM:
> TIMESTAMP and DATETIME initialization and update properties enable you to record row-creation and 
row-modification times automatically.
	>> These properties are not available for other temporal types
	
SOLUTION:
> One way to simulate TIMESTAMP properties for other temporal data types is to use the
following strategy:
	• When you create a row, initialize a DATE column to the current date and a TIME
	column to the current time.
	• When you update a row, set the DATE and TIME columns to the new date and time.
*/

/*
> The following example shows how to use triggers to simulate TIMESTAMP properties for
the DATE and TIME data types

EXAMPLE:
1) Begin by creating the following table, which has a nontemporal
column for storing data and columns for the DATE and TIME temporal types

2) When applications insert or update values in the data column, MySQL should set the temporal columns 
appropriately to reflect the time at which modifications occur. 
	>> To accomplish this, set up triggers that use the current date and time to initialize the 
	temporal columns for new rows, and to update them when existing rows are changed

3) An IF statement is required here to emulate the TIMESTAMP property that an update occurs only if 
the data value in the row actually changes from its current value

4) To test the INSERT trigger, create a couple rows, but supply a value only for the data
column. 
	>> Then verify that MySQL provides the proper default values for the temporal columns
	
5) Change the data value of one row to verify that the BEFORE UPDATE trigger updates the
temporal columns of the changed row

6) Issue another UPDATE, but this time use one that does not change any data column
values. 
	>> In this case, the BEFORE UPDATE trigger should notice that no value change occurred
	and leave the temporal columns unchanged
*/
1)
CREATE TABLE ts_emulate (data CHAR(10), d DATE, t TIME);

2)
CREATE TRIGGER bi_ts_emulate BEFORE INSERT ON ts_emulate
FOR EACH ROW SET NEW.d = CURDATE(), NEW.t = CURTIME();

3)
CREATE TRIGGER bu_ts_emulate BEFORE UPDATE ON ts_emulate
FOR EACH ROW # update temporal columns only if nontemporal column changes
IF NEW.data <> OLD.data THEN
SET NEW.d = CURDATE(), NEW.t = CURTIME();
END IF;

4)
mysql> INSERT INTO ts_emulate (data) VALUES('cat');
mysql> INSERT INTO ts_emulate (data) VALUES('dog');
mysql> SELECT * FROM ts_emulate;

5)
mysql> UPDATE ts_emulate SET data = 'axolotl' WHERE data = 'cat';
mysql> SELECT * FROM ts_emulate;

6)
mysql> UPDATE ts_emulate SET data = data;
mysql> SELECT * FROM ts_emulate;
