/*

!!SELECTING DATA FROM TABLES - WRITING COMPARISONS INVOLVING NULL IN PROGRAMS!!

> You’re writing a program that looks for rows containing a specific value, 
but it fails when the value is NULL

> Choose the proper comparison operator according to whether the comparison value is
or is not NULL

> If a value stored in a variable might represent a NULL value, you must account for 
that when you use the value in comparisons

*/


/*
> To take into account the possibility that $score could be undef, construct the statement 
using the appropriate comparison operator like this

EXAMPLE:
*/
$operator = defined ($score) ? "=" : "IS";
$sth = $dbh->prepare ("SELECT * FROM expt WHERE score $operator ?");
$sth->execute ($score);
/*
This results in statements as follows for $score values of undef (NULL) or 43 (not NULL):
*/
SELECT * FROM expt WHERE score IS NULL
SELECT * FROM expt WHERE score = 43


/*
> For inequality tests, set $operator like this instead

EXAMPLE:
*/
$operator = defined ($score) ? "<>" : "IS NOT";