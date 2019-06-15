/*

!!STATISTICS - GENERATING RANDOM NUMBERS!!

> You need a source of random numbers

> Use the RAND() function

*/

/*
EXAMPLE:
1) MySQL has a RAND() function that produces random numbers between 0 and 1:

2) The following example shows that RAND() without an argument produces a different 
column of values per query, whereas RAND(N) produces a repeatable column


3) To seed RAND() randomly, pick a seed value based on a source of entropy. Possible
sources are the current timestamp or connection identifier, alone or perhaps in combination
*/
1)
mysql> SELECT RAND(), RAND(), RAND();

2)
mysql> SELECT i, RAND(), RAND(10), RAND(20) FROM t;

mysql> SELECT i, RAND(), RAND(10), RAND(20) FROM t;


3)
RAND(UNIX_TIMESTAMP())
RAND(CONNECTION_ID())
RAND(UNIX_TIMESTAMP()+CONNECTION_ID())