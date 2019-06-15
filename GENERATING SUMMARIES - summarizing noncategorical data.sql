/*

!!GENERATING SUMMARIES - SUMMARIZING NONCATEGORICAL DATA!!

> You want to summarize a set of values that are not naturally categorical

> Use an expression to group the values into categories

*/

/*
> In situations in which values do not group nicely into a small number of sets,
use a transformation that forces them into categories. 


EXAMPLE:
1) Begin by determining the range of population values

2) For categories of size n, place a value x into the proper category using this
expression
3) Final form of our query looks like this

> In some instances, it may be more appropriate to categorize groups on a logarithmic
scale. 
	4) npr. treat the state population values that way as follows
*/
1)
mysql> SELECT MIN(pop), MAX(pop) FROM states;

2)
FLOOR((x+(n-1))/n)
3)
mysql> SELECT FLOOR((pop+4999999)/5000000)*5 AS `max population (millions)`,
	-> COUNT(*) AS `number of states`
	-> FROM states GROUP BY `max population (millions)`;
	
4)
mysql> SELECT FLOOR(LOG10(pop)) AS `log10(population)`,
	-> COUNT(*) AS `number of states`
	-> FROM states GROUP BY `log10(population)`;