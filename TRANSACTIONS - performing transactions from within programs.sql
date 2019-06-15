/*

!!PERFORMING TRANSACTIONS - PERFORMING TRANSACTIONS FROM WITHIN PROGRAMS!!

> You’re writing a program that must implement transactional operations

> Use the transaction abstraction provided by your language API, if it has such a thing.
	>> If it doesn’t, use the API’s usual statement-execution mechanism to execute the 
	transactional SQL statements directly

*/

/*
> To perform transactional processing from within a program, use your API language to
detect errors and take appropriate action

> Every MySQL API supports transactions, even if only in the sense that you can explicitly
execute transaction-related SQL statements such as START TRANSACTION and COMMIT
	>> However, some APIs also provide a transaction abstraction that enables control over
	transactional behavior without working directly with SQL
	
EXAMPLE:
1) The sample transaction is a simple financial transfer that uses two UPDATE statements
to give six dollars of Eve’s money to Ida

+) That logic can be expressed as follows, where block represents the control structure
used to group statements
*/
1)
UPDATE money SET amt = amt - 6 WHERE name = 'Eve';
UPDATE money SET amt = amt + 6 WHERE name = 'Ida';

+)
block:
statement 1
statement 2
...
statement n
commit
if the block failed:
roll back