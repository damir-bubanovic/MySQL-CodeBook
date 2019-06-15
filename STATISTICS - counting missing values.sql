/*

!!STATISTICS - COUNTING MISSING VALUES!!

> A set of observations is incomplete. You want to find out how much so

> Count the number of NULL values in the set

*/

/*
> Values can be missing from a set of observations for any number of reasons: 
	+) a test may not yet have been administered
	+) something may have gone wrong during the test that requires invalidating the observation
	+) ...

> You can represent such observations in a dataset as NULL values to signify that they’re missing 
or otherwise invalid, then use summary statements to characterize the completeness of the dataset

EXAMPLE:
> If a table t contains values to be summarized along a single dimension, a simple summary
suffices to characterize the missing values. 
1) Suppose that t looks like this

2) COUNT(*) counts the total number of rows, and COUNT(score) counts the number of nonmissing scores. 
The difference between the two values is the number of missing scores, and that difference in relation 
to the total provides the percentage of missing scores

3) As an alternative to counting NULL values as the difference between counts, count them directly 
using SUM(ISNULL(score)). The ISNULL() function returns 1 if its argument is NULL, zero otherwise
> If values are arranged in groups, occurrences of NULL values can be assessed on a pergroup basis
*/
1)
mysql> SELECT subject, score FROM t ORDER BY subject;

2)
mysql> SELECT COUNT(*) AS 'n (total)',
	-> COUNT(score) AS 'n (nonmissing)',
	-> COUNT(*) - COUNT(score) AS 'n (missing)',
	-> ((COUNT(*) - COUNT(score)) * 100) / COUNT(*) AS '% missing'
	-> FROM t;
	
3)
mysql> SELECT COUNT(*) AS 'n (total)',
	-> COUNT(score) AS 'n (nonmissing)',
	-> SUM(ISNULL(score)) AS 'n (missing)',
	-> (SUM(ISNULL(score)) * 100) / COUNT(*) AS '% missing'
	-> FROM t;
	
/*
EXAMPLE:
1) Suppose that t contains scores for subjects that are distributed among conditions for two factors 
A and B, each of which has two levels

2) To produce a summary for each combination of conditions, use a GROUP BY clause
*/
1)
mysql> SELECT subject, A, B, score FROM t ORDER BY subject;

2)
mysql> SELECT A, B, COUNT(*) AS 'n (total)',
	-> COUNT(score) AS 'n (nonmissing)',
	-> COUNT(*) - COUNT(score) AS 'n (missing)',
	-> ((COUNT(*) - COUNT(score)) * 100) / COUNT(*) AS '% missing'
	-> FROM t
	-> GROUP BY A, B;
