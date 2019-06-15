/*

!!STATISTICS - ASSIGNING RANKS!!

> You want to assign ranks to a set of values

> Decide on a ranking method, then put the values in the desired order and apply the
method to them

*/

/*
> This section describes three ranking methods and shows how each can be implemented 
by using user-defined variables

EXAMPLE:
+) table t contains the following scores, which are to be ranked with the values in descending order

1) One type of ranking simply assigns each value its row number within the ordered set of values
	> That kind of ranking doesn’t take into account the possibility of ties 
	(instances of values that are the same)
	
2) Second ranking method does so by advancing the rank only when values change

3) A third ranking method is something of a combination of the other two methods. It
ranks values by row number, except when ties occur

> Ranks are easy to assign within a program as well (PHP)
*/
+)
mysql> SELECT score FROM t ORDER BY score DESC;

1)
mysql> SET @rownum := 0;
mysql> SELECT @rownum := @rownum + 1 AS rank, score
	-> FROM t ORDER BY score DESC;
	
2)
mysql> SET @rank = 0, @prev_val = NULL;
mysql> SELECT @rank := IF(@prev_val=score,@rank,@rank+1) AS rank,
	-> @prev_val := score AS score
	-> FROM t ORDER BY score DESC;
	
3)
mysql> SET @rownum = 0, @rank = 0, @prev_val = NULL;
mysql> SELECT @rownum := @rownum + 1 AS row,
	-> @rank := IF(@prev_val<>score,@rownum,@rank) AS rank,
	-> @prev_val := score AS score
	-> FROM t ORDER BY score DESC;