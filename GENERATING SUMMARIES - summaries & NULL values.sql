/*

!!GENERATING SUMMARIES - SUMMARIES & NULL VALUES!!

> You’re summarizing a set of values that may include NULL values and you need to know
how to interpret the results

> Understand how aggregate functions handle NULL values

*/

/*
> Most aggregate functions ignore NULL values. COUNT() is different
> COUNT(expr) ignores NULL instances of expr, but COUNT(*) counts rows, regardless of content

EXAMPLE:
1) Suppose that an expt table contains experimental results for subjects who are to be given
four tests each and that lists the test score as NULL for tests not yet administered

2) By using a GROUP BY clause to arrange the rows by subject name, the number of tests
taken by each subject, as well as the total, average, lowest, and highest scores, can be
calculated like this

3) However, be aware that even though aggregate functions may ignore NULL values, some
of them can still produce NULL as a result. 
	>> This happens if there’s nothing to summarize, which occurs if the set of values is 
	empty or contains only NULL values
	
4) If you don’t want an aggregate value of NULL to display as NULL, use IF
NULL() to map it appropriately
*/
1)
mysql> SELECT subject, test, score FROM expt ORDER BY subject, test;

2) mysql> SELECT subject,
	-> COUNT(score) AS n,
	-> SUM(score) AS total,
	-> AVG(score) AS average,
	-> MIN(score) AS lowest,
	-> MAX(score) AS highest
	-> FROM expt GROUP BY subject;
	
3)
mysql> SELECT subject,
	-> COUNT(score) AS n,
	-> SUM(score) AS total,
	-> AVG(score) AS average,
	-> MIN(score) AS lowest,
	-> MAX(score) AS highest
	-> FROM expt WHERE score IS NULL GROUP BY subject;
	
4)
mysql> SELECT subject,
	-> COUNT(score) AS n,
	-> IFNULL(SUM(score),0) AS total,
	-> IFNULL(AVG(score),0) AS average,
	-> IFNULL(MIN(score),'Unknown') AS lowest,
	-> IFNULL(MAX(score),'Unknown') AS highest
	-> FROM expt WHERE score IS NULL GROUP BY subject;
