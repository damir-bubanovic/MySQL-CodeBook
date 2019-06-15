/*

!!GENERATING SUMMARIES - GROUPING BY EXPRESSION RESULTS!!

> You want to group rows into subgroups based on values calculated from an expression

> In the GROUP BY clause, use an expression that categorizes values

*/

/*
> GROUP BY, like ORDER BY, can refer to expressions. 
	>> This means you can use calculations as the basis for grouping
	
EXAMPLE:
1) To find days of the year on which more than one state joined the Union, group by
statehood month and day, and then use HAVING and COUNT() to find the nonunique
combinations
*/
1)
mysql> SELECT
	-> MONTHNAME(statehood) AS month,
	-> DAYOFMONTH(statehood) AS day,
	-> COUNT(*) AS count
	-> FROM states GROUP BY month, day HAVING count > 1;