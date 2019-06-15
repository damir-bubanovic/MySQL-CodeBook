/*

!!STATISTICS - GENERATING FREQUENCY DISTRIBUTIONS!!

> You want to know the frequency of occurrence for each value in a table

> Derive a frequency distribution that summarizes the contents of your dataset

*/

/*
> A common application for per-group summary techniques is to generate a frequency
distribution that shows how often each value occurs

EXAMPLE:
1) For the testscore table, the frequency distribution looks like this

> Expressing the results in percentages rather than counts yields relative frequency 
distribution.
2) To show each count as a percentage of the total, use one query to get the total 
number of observations and another to calculate the percentages for each group

> If the dataset contains a large number of distinct values and you want a distribution
that shows only a small number of categories, you may want to lump values into categories 
and produce a count for each category
*/
1)
mysql> SELECT score, COUNT(score) AS counts
	-> FROM testscore GROUP BY score;
	
2)
mysql> SET @n = (SELECT COUNT(score) FROM testscore);
mysql> SELECT score, (COUNT(score)*100)/@n AS percent
	-> FROM testscore GROUP BY score;
	
/*
> One typical use of frequency distributions is to export the results for use in a graphing
program.

EXAMPLE:
1) Display an ASCII bar chart of the test score counts, convert the counts to strings of * 
characters

2) To chart the relative frequency distribution instead, use the percentage values

> Quick way to get a picture of the distribution of observations and requires no other tools
*/
1)
mysql> SELECT score, REPEAT('*',COUNT(score)) AS 'count histogram'
	-> FROM testscore GROUP BY score;
	
2)
mysql> SET @n = (SELECT COUNT(score) FROM testscore);
mysql> SELECT score,
	-> REPEAT('*',(COUNT(score)*100)/@n) AS 'percent histogram'
	-> FROM testscore GROUP BY score;
	
	
/*
> If you generate a frequency distribution for a range of categories where some of the
categories are not represented in your observations, the missing categories do not appear
in the output. To force each category to be displayed, use a reference table and a LEFT
JOIN

EXAMPLE:
1) For the testscore table, the possible scores range from 0 to 10, so a reference table 
should contain each of those values

> Then join the reference table to the test scores to generate the frequency distribution.
2) This query shows the counts as well as the histogram

3) The same principle applies to relative frequency distributions
*/
1)
mysql> CREATE TABLE ref (score INT);
mysql> INSERT INTO ref (score)
	-> VALUES(0),(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);
	
2)
mysql> SELECT ref.score, COUNT(testscore.score) AS counts,
	-> REPEAT('*',COUNT(testscore.score)) AS 'count histogram'
	-> FROM ref LEFT JOIN testscore ON ref.score = testscore.score
	-> GROUP BY ref.score;
	
3)
mysql> SET @n = (SELECT COUNT(score) FROM testscore);
mysql> SELECT ref.score, (COUNT(testscore.score)*100)/@n AS percent,
	-> REPEAT('*',(COUNT(testscore.score)*100)/@n) AS 'percent histogram'
	-> FROM ref LEFT JOIN testscore ON ref.score = testscore.score
	-> GROUP BY ref.score;	
	