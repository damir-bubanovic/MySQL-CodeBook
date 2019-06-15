/*

!!STATISTICS - PER-GROUP DESCRIPTIVE STATISTICS!!

> You want to produce descriptive statistics for each subgroup of a set of observations

> Use aggregate functions, but employ a GROUP BY clause to arrange observations into the
appropriate groups

*/

/*
> To be more specific, use GROUP BY to divide the observations into groups and calculate 
statistics for each of them.
	>> npr. the subjects in the test score table are listed by age and sex, so it’s possible 
	to calculate similar statistics by age or sex (or both) by application of appropriate 
	GROUP BY clauses

EXAMPLE:
1) How to calculate by age

2) By sex

3) By age and sex
*/
1)
mysql> SELECT age, COUNT(score) AS n,
	-> SUM(score) AS sum,
	-> MIN(score) AS minimum,
	-> MAX(score) AS maximum,
	-> AVG(score) AS mean,
	-> STDDEV_SAMP(score) AS 'std. dev.',
	-> VAR_SAMP(score) AS 'variance'
	-> FROM testscore
	-> GROUP BY age;
	
2)
mysql> SELECT sex, COUNT(score) AS n,
	-> SUM(score) AS sum,
	-> MIN(score) AS minimum,
	-> MAX(score) AS maximum,
	-> AVG(score) AS mean,
	-> STDDEV_SAMP(score) AS 'std. dev.',
	-> VAR_SAMP(score) AS 'variance'
	-> FROM testscore
	-> GROUP BY sex;
	
3)
mysql> SELECT age, sex, COUNT(score) AS n,
	-> SUM(score) AS sum,
	-> MIN(score) AS minimum,
	-> MAX(score) AS maximum,
	-> AVG(score) AS mean,
	-> STDDEV_SAMP(score) AS 'std. dev.',
	-> VAR_SAMP(score) AS 'variance'
	-> FROM testscore
	-> GROUP BY age, sex;
