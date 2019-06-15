/*

!!STATISTICS - CALCULATING SECCESSIVE-ROW DIFFERENCES!!

> A table contains successive cumulative values in its rows, and you want to compute the
differences between pairs of successive rows

> Use a self-join that matches pairs of adjacent rows and calculates the differences between
members of each pair

*/

/*
> Self-joins are useful when you have a set of absolute (or cumulative) values that you
want to convert to relative values representing the differences between successive pairs
of rows. 
	>> npr. if you take an automobile trip and write down the total miles traveled at each 
	stopping point, you can compute the difference between successive points to determine 
	the distance from one stop to the next
	
EXAMPLE:
1) Table that shows the stops for a trip from San Antonio, Texas to Madison, Wisconsin. Each row
shows the total miles driven as of each stop

> A self-join can convert these cumulative values to successive differences that represent
the distances from each city to the next. 
2) Use the sequence numbers in the rows to match pairs of successive rows and compute the 
differences between each pair of mileage values
*/
1)
mysql> SELECT seq, city, miles FROM trip_log ORDER BY seq;

2)
mysql> SELECT t1.seq AS seq1, t2.seq AS seq2,
	-> t1.city AS city1, t2.city AS city2,
	-> t1.miles AS miles1, t2.miles AS miles2,
	-> t2.miles-t1.miles AS dist
	-> FROM trip_log AS t1 INNER JOIN trip_log AS t2
	-> ON t1.seq+1 = t2.seq
	-> ORDER BY t1.seq;