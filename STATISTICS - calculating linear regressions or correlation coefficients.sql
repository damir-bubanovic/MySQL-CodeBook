/*

!!STATISTICS - CALCULATING LINEAR REGRESSIONS OR CORRELATION COEFFICIENTS!!

> You want to calculate the least-squares regression line for two variables or the correlation
coefficient that expresses the strength of the relationship between them

> Apply summary functions to calculate the necessary terms

*/

/*
> When the data values for two variables X and Y are stored in a database, the least-squares
regression for them can be calculated easily using aggregate functions. The same is true
for the correlation coefficient

EXAMPLE:
1) Suppose that you want to calculate a least-squares regression using the age and test score
values for the observations in the testscore table

2) The following equation expresses the regression line, where a and b are the intercept
and slope of the line

3) Letting age be X and score be Y, begin by computing the terms needed for the regression
equation. These include the number of observations; the means, sums, and sums of
squares for each variable; and the sum of the products of each variable

4) From those terms, calculate the regression slope and intercept as follows

5) The regression equation then is

6) To compute the correlation coefficient, use many of the same terms
*/
1)
mysql> SELECT age, score FROM testscore;

2)
Y = bX + a

3)
mysql> SELECT
	-> @n := COUNT(score) AS N,
	-> @meanX := AVG(age) AS 'X mean',
	-> @sumX := SUM(age) AS 'X sum',
	-> @sumXX := SUM(age*age) AS 'X sum of squares',
	-> @meanY := AVG(score) AS 'Y mean',
	-> @sumY := SUM(score) AS 'Y sum',
	-> @sumYY := SUM(score*score) AS 'Y sum of squares',
	-> @sumXY := SUM(age*score) AS 'X*Y sum'
	-> FROM testscore\G
	
4)
mysql> SET @b := (@n*@sumXY - @sumX*@sumY) / (@n*@sumXX - @sumX*@sumX);
mysql> SET @a := (@meanY - @b*@meanX);
mysql> SELECT @b AS slope, @a AS intercept;

5)
mysql> SELECT CONCAT('Y = ',@b,'X + ',@a) AS 'least-squares regression';

6)
mysql> SELECT
	-> (@n*@sumXY - @sumX*@sumY)
	-> / SQRT((@n*@sumXX - @sumX*@sumX) * (@n*@sumYY - @sumY*@sumY))
	-> AS correlation;
