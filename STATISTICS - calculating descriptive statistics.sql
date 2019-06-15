/*

!!STATISTICS - CALCULATING DESCRIPTIVE STATISTICS!!

> You want to characterize a dataset by computing general descriptive or summary statistics

> Many common descriptive statistics, such as mean and standard deviation, are obtained
by applying aggregate functions to your data. 
> Others, such as median or mode, are calculated based on counting queries.

*/

/*
> Suppose that a testscore table contains observations representing subject ID, age, sex,
and test score

> Common statistical values
	• The number of observations, their sum, and their range (minimum and maximum)
	• Measures of central tendency, such as mean, median, and mode
	• Measures of variation, such as standard deviation and variance
*/

/*
EXAMPLE:
1) Aside from the median and mode, all of these can be calculated easily by invoking
aggregate functions

2) Select values that lie more than three standard deviations from the mean

3) Computing the mode or median of a set of values
	> To determine the mode (the value that occurs most frequently), count each value 
	and see which is most common
*/
1)
mysql> SELECT COUNT(score) AS n,
	-> SUM(score) AS sum,
	-> MIN(score) AS minimum,
	-> MAX(score) AS maximum,
	-> AVG(score) AS mean,
	-> STDDEV_SAMP(score) AS 'std. dev.',
	-> VAR_SAMP(score) AS 'variance'
	-> FROM testscore;
	
2)
SELECT @mean := AVG(score), @std := STDDEV_SAMP(score) FROM testscore;
SELECT score FROM testscore WHERE ABS(score-@mean) > @std * 3;

3)
mysql> SELECT score, COUNT(score) AS frequency
	-> FROM testscore GROUP BY score ORDER BY frequency DESC;
	
	
/*
> The median of a set of ordered values can be calculated like this:1
	• If the number of values is odd, the median is the middle value.
	• If the number of values is even, the median is the average of the two middle values.
	
> Based on that definition, use the following procedure to determine the median of a set
of observations stored in the database:
	1. Issue a query to count the number of observations. From the count, you can determine
	whether the median calculation requires one or two values, and what their
	indexes are within the ordered set of observations.
	2. Issue a query that includes an ORDER BY clause to sort the observations and a LIM
	IT clause to pull out the middle value or values.
	3. If there is a single middle value, it is the median. Otherwise, take the average of the
	middle values.
*/

/*
EXAMPLE:
1) Suppose that a table t contains a score column with 37 values (an odd number). To get
the median, select a single value using a statement like this

2) If the column contains 38 values (an even number), select two values

3) Then take the values returned by the statement and compute the median from their
average (with PHP?)
*/
1)
SELECT score FROM t ORDER BY score LIMIT 18,1

2)
SELECT score FROM t ORDER BY score LIMIT 18,2
