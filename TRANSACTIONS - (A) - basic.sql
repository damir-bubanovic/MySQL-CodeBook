/*

!!PERFORMING TRANSACTIONS - BASIC!!

> The MySQL server can handle multiple clients at the same time because it is multithreaded.
	>> To deal with contention among clients, the server performs any necessary locking so 
	that two clients cannot modify the same data at once. 

> However, as the server executes SQL statements, it’s very possible that successive statements 
received from a given client will be interleaved with statements from other clients. 
	>> If a client executes multiple statements that are dependent on each other, the fact that 
	other clients may be updating tables in between those statements can cause difficulties. 

> Statement failures can be problematic, too, if a multiple-statement operation does not run to 
completion

*/

/*
GENERAL PROGLEMS:
- flight table contains information about airline flight schedules
	Concurrency issues
		> If two clients want to schedule pilots, it’s possible for both to run the initial SELECT 
		query and retrieve the same pilot ID number before either has a chance to set the pilot’s 
		status to unavailable. 
			>> If that happens, the same pilot is scheduled for two	flights at once.
			
	Integrity issues
		All three statements must execute successfully as a unit. 
			> npr. if the SELECT and the first UPDATE run successfully, but the second UPDATE fails, 
			the pilot’s	status is set to unavailable without the pilot being assigned a flight. 
				>> The database	becomes inconsistent.
*/

/*
SOLUTIONS:
- To prevent concurrency and integrity problems in these types of situations, transactions
are helpful
> They have following properties
	• No other client can update the data used in the transaction while the transaction is
	in progress; it’s as though you have the server all to yourself
		>> Transactions solve concurrency problems arising from the multiple-client nature of the 
		MySQL server. 
		>> In effect, transactions serialize access to a shared resource across multiple-statement 
		operations.
	• Statements grouped within a transaction are committed (take effect) as a unit, but only if 
	they all succeed. 
		>> If an error occurs, any actions that occurred prior to the error are rolled back, 
		leaving the relevant tables unaffected as though none of the statements had been executed. 
			>>> This keeps the database from becoming inconsistent.
		>> Rollback frees you from having to figure out how to undo a partially completed operation 
		yourself.
*/
