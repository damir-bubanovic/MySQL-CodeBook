/*

!!GENERATING SUMMARIES - FINDING VALUES ASSOCIATED WITH MINIMUM & MAXIMUM VALUES!!

> You want to know the values for other columns in the row that contains a minimum or
maximum value

> Use two statements and a user-defined variable. Or a subquery. Or a join

*/

/*
EXAMPLE:
> MIN() and MAX() find an endpoint of a range of values, but you may also be interested
in other values from the row in which the value occurs
1) You can find the largest state population like this

> Aggregate functions such as MIN() and MAX() cannot be used in WHERE clauses, which 
require expressions that apply to individual rows. Solution
2) Save the maximum population value in a user-defined variable, then compare rows to the 
variable value

3) Alternatively, for a single-statement solution, use a subquery in the WHERE clause that
returns the maximum population value

> This technique also works even if the minimum or maximum value itself isn’t actually
contained in the row, but is only derived from it. 
4) To determine the length of the shortest verse in the King James Version

5) If you want to know “Which verse is that?” do this instead

> Yet another way to select other columns from rows containing a minimum or maximum
value is to use a join. Select the value into another table, then join it to the original table
to select the row that matches the value. 
6) To find the row for the state with the highest population, use a join like this
*/
1)
mysql> SELECT MAX(pop) FROM states;

2)
mysql> SET @max = (SELECT MAX(pop) FROM states);
mysql> SELECT pop AS 'highest population', name FROM states WHERE pop = @max;

3)
SELECT pop AS 'highest population', name FROM states
WHERE pop = (SELECT MAX(pop) FROM states);

4)
mysql> SELECT MIN(CHAR_LENGTH(vtext)) FROM kjv;

5)
mysql> SELECT bname, cnum, vnum, vtext FROM kjv
	-> WHERE CHAR_LENGTH(vtext) = (SELECT MIN(CHAR_LENGTH(vtext)) FROM kjv);
	
6)
mysql> CREATE TEMPORARY TABLE tmp SELECT MAX(pop) as maxpop FROM states;
mysql> SELECT states.* FROM states INNER JOIN tmp
	-> ON states.pop = tmp.maxpop;
	