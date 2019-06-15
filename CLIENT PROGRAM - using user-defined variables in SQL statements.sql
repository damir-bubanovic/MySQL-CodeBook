/*

!!BASIC - CLIENT PROGRAM - USING USER-DEFINED VARIABLES IN SQL STATEMENTS!!

> You want to use a value in one statement that is produced by an earlier statement

> Save the value in a user-defined variable to store it for later use

> To save a value returned by a SELECT statement, assign it to a user-defined variable. 
This enables you to refer to it in other statements later in the same session (but not 
across sessions)
	>> To assign a value to a user variable within a SELECT statement, 
		use @var_name := value syntax

		
EXAMPLE:		
> Here is an example that assigns a value to a user variable, then refers to that variable
later. This is a simple way to determine a value that characterizes some row in a table,
then select that particular row
*/
mysql> SELECT @max_limbs := MAX(arms+legs) FROM limbs;

mysql> SELECT * FROM limbs WHERE arms+legs = @max_limbs;

/*
> Another use for a variable is to save the result from LAST_INSERT_ID() after creating a
new row in a table that has an AUTO_INCREMENT column
*/
mysql> SELECT @last_id := LAST_INSERT_ID();

/*
> User variables hold single values. If a statement returns multiple rows, the value from
the last row is assigned
*/
mysql> SELECT @name := thing FROM limbs WHERE legs = 0;

mysql> SELECT @name;

/*
> If the statement returns no rows, no assignment takes place, and the variable retains 
its previous value. If the variable has not been used previously, its value is NULL
*/
mysql> SELECT @name2 := thing FROM limbs WHERE legs < 0;
Empty set (0.00 sec)
mysql> SELECT @name2;

/*
> To set a variable explicitly to a particular value, use a SET statement. 
SET syntax can use either := or = as the assignment operator
*/
mysql> SET @sum = 4 + 7;
mysql> SELECT @sum;

/*
> You can assign a SELECT result to a variable, provided that you write it as a scalar 
subquery (a query within parentheses that returns a single value)
*/
mysql> SET @max_limbs = (SELECT MAX(arms+legs) FROM limbs);
