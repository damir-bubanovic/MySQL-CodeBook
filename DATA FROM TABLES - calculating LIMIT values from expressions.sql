/*

!!SELECTING DATA FROM TABLES - CALCULATING LIMIT VALUES FROM EXPRESSIONS!!

> You want to use expressions to specify the arguments for LIMIT

> YOU CANNOT
	>> LIMIT arguments must be literal integers—unless you issue the statement in a context 
	that permits the statement string to be constructed dynamically. 
		>>> In that case, you can evaluate the expressions yourself and insert the resulting 
		values into the statement string

> Arguments to LIMIT must be literal integers, not expressions
*/

/*
EXAMPLE:
1) BAD - cannot do

2) GOOD - evaluate expression first
*/
1)
$str = "SELECT * FROM profile LIMIT $x + $y";

2)
$z = $x + $y;
$str = "SELECT * FROM profile LIMIT $z";