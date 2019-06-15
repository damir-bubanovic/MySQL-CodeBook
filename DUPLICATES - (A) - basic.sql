/*

!!HANDLING DUPLICATES - BASIC!!

> Operations involved in handling duplicate rows include the following:
	• Preventing duplicates from being created in the first place. 
		>> If each row in a table is intended to represent a single entity (such as a person, 
		an item in a catalog, or a specific observation in an experiment), the occurrence of 
		duplicates presents significant	difficulties in using it that way. 
		>> Duplicates make it impossible to refer to each row unambiguously, so it’s best to 
		make sure duplicates never occur.
	• Counting the number of duplicates to determine whether they are present and to
	what extent.
	• Identifying duplicated values (or the rows containing them) so you can see where
	they occur.
	• Eliminating duplicates to ensure that each row is unique. 
		>> This may involve removing rows from a table to leave only unique rows or selecting 
		a result set in such a way that no duplicates appear in the output. 

*/


/*
> Several tools are at your disposal for dealing with duplicate rows. 

> Choose them according to the objective that you want to achieve
	• When you create a table, include a primary key or unique index to prevent duplicates
	from being added to the table
	• In conjunction with a unique index, the INSERT IGNORE and REPLACE statements
	enable you to handle insertion of duplicate rows gracefully without generating errors.
		>> For bulk-loading operations, the same options are available in the form of the
		IGNORE or REPLACE modifiers for the LOAD DATA statement.
	• To determine whether a table contains duplicates, use GROUP BY to categorize rows
	into groups, and COUNT() to see how many rows are in each group. 
		>> Producing summaries - they’re useful	for duplicate counting and identification as well. 
		>> A counting summary groups values into categories to determine how frequently each one 
		occurs.
	• SELECT DISTINCT removes duplicate rows from a result set.
		>> For an existing table that already contains duplicates, you can select unique rows into 
		a second table and use it to replace the original table. 
		>> Or, if you determine that there are n identical rows in a table, you can use DELETE … LIMIT
		to eliminate n–1 instances from that specific set of rows.
*/