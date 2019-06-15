/*

!!VALIDATING & REFORMATING DATA - USING A LOOKUP TABLE TO VALIDATE DATA!!

> You must check values to make sure they’re listed in a lookup table

> Issue statements to check whether the values are in the table. The best way to do this
depends on the number of input values and the table size

*/

/*
> Whereas ENUM and SET columns usually have a small number of member values, a
lookup table can have an essentially unlimited number of values. You might not want
to read them all into memory
*/

/*
ISSUE INDIVIDUAL STATEMENTS
> For one-shot operations, test a value by checking whether it’s listed in the lookup table.
	>> query returns true (nonzero) for a value that is present and false otherwise
*/

/*
CONSTRUCT A HASH FROM THE ENTIRE LOOKUP TABLE
> To validate a large number of values, it’s more efficient to pull the lookup values into
memory, save them in a data structure, and check each input value against the contents
of that structure. 
	>> Using an in-memory lookup avoids the overhead of executing a query for each value
	
	- First, run a query to retrieve all the lookup table values and construct a hash from them
	- Perform a hash key existence test to check a given value
	
> This technique reduces database traffic to a single query. However, for a large lookup
table, that could still be a lot of traffic, and you might not want to hold the entire table
in memory


1) In PHP, use an associative array, and perform a key lookup with isset()
*/
1)
$valid = isset ($members[$val]);

/*
REMEMBER ALREADY SEEN VALUES TO AVOID DATABASE LOOKUPS
> Another lookup technique mixes individual statements with a hash that stores lookup
value existence information. 
	>> This approach can be useful if you have a very large lookup table
> Then, for each value to be tested, check whether it’s present in the hash. 
	>> If not, execute a query to check whether the value is present in the lookup table, 
	and record the result of the query in the hash. 
	>> The validity of the input value is determined by the value associated with the key, 
	not by the existence of the key
*/
