/*

!!DATE & TIME - USING TIMESTAMP OR DATETIME TO TRACK ROW MODIFICATION TIME!!

> You want to record row-creation time or last modification time automatically

> Use the auto-initialization and auto-update properties of the TIMESTAMP and DATE
TIME data types

*/

/*
> Column attributes that enable you to track row-creation and -update times automatically
	• A TIMESTAMP or DATETIME column declared with the DEFAULT CURRENT_TIME	STAMP attribute 
	initializes automatically for new rows. 
		>> Simply omit the column from INSERT statements and MySQL sets it to the row-creation time.
	• A TIMESTAMP or DATETIME column declared with the ON UPDATE CURRENT_TIME STAMP attribute 
	automatically updates to the current date and time when you change any other column in the row 
	from its current value.
*/

/*
EXAMPLE TABLE:
*/
CREATE TABLE tsdemo
(
val INT,
ts_both TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
ts_create TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
ts_update TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

/*
> The TIMESTAMP columns have these properties
	• ts_both auto-initializes and auto-updates. 
		>> This is useful for tracking the time of any change to a row, for both inserts and updates.
	• ts_create auto-initializes only. 
		>> This is useful when you want a column to be set to the time at which a row is created, 
		but remain constant thereafter.
	• ts_update auto-updates only. 
		>> It is set to the column default (or value you specify explicitly) at row-creation time and 
		it auto-updates for changes to the row thereafter.
			>>> The use cases for this are more limited—for example, to track row-creation and 
			last-modification times separately (using ts_update in conjunction with	ts_create), 
			rather than together in a single column like ts_both.


EXAMPLE:			
1) To see how the table works, insert some rows into the table (a few seconds apart so the
timestamps differ), then select its contents

2) To see auto-updating in action, issue a statement that changes one row’s val column
and check its effect on the table’s contents

3) If you modify multiple rows, updates occur for the auto-update columns in each row

4) An UPDATE statement that doesn’t actually change any value in a row doesn’t modify
auto-update columns.
*/
1)
mysql> INSERT INTO tsdemo (val) VALUES(5);
mysql> INSERT INTO tsdemo (val,ts_both,ts_create,ts_update)
	-> VALUES(10,NULL,NULL,NULL);
mysql> SELECT * FROM tsdemo;

2)
mysql> UPDATE tsdemo SET val = 11 WHERE val = 10;
mysql> SELECT * FROM tsdemo;

3)
mysql> UPDATE tsdemo SET val = val + 1;
mysql> SELECT * FROM tsdemo;

4)
mysql> UPDATE tsdemo SET val = val;
mysql> SELECT * FROM tsdemo;


/*
> automatic TIMESTAMP properties also apply to DATETIME, with some differences
	• For the first TIMESTAMP column in a table, if neither of the DEFAULT or ON UPDATE
	attributes are specified, the column is implicitly defined with both. 
		>> For DATETIME, automatic properties never apply implicitly; only those specified explicitly. 
		(To	suppress implicit attribute definition for TIMESTAMP columns, enable the explic	
		it_defaults_for_timestamp system variable.)
	• You can set a TIMESTAMP column to the current date and time at any time by setting
	it to NULL, unless it has specifically been defined to permit NULL values. 
		>> Assigning NULL to a DATETIME column never sets it to the current date and time.
		>> To prevent a TIMESTAMP column from being set to the current date and time when
		assigned a NULL value, include the NULL attribute in the column definition. 
		>> Then	assigning NULL to the column stores NULL.
*/
