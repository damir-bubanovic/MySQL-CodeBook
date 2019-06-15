/*

!!GENERATING SUMMARIES - SELECTING ONLY GROUPS WITH CERTAIN CHARACTERISTICS!!

> You want to calculate group summaries but display results only for groups that match
certain criteria

> Use a HAVING clause

*/

/*
>The problem is that WHERE specifies the initial constraints that determine which rows to
select, but the value of COUNT() can be determined only after the rows have been selected.
> The solution is to put the COUNT() expression in a HAVING clause instead
	>> HAVING is analogous to WHERE, but it applies to group characteristics rather than to 
	single rows
	
EXAMPLE:
1) To identify drivers in the driver_log table who drove more than three days

> When you use HAVING, you can still include a WHERE clause, but only to select rows to be
summarized, not to test already calculated summary values.

2) HAVING can refer to aliases, so the previous query can be rewritten like this
*/
1)
mysql> SELECT COUNT(*), name FROM driver_log
	-> GROUP BY name
	-> HAVING COUNT(*) > 3;
	
2)
mysql> SELECT COUNT(*) AS count, name FROM driver_log
	-> GROUP BY name
	-> HAVING count > 3;