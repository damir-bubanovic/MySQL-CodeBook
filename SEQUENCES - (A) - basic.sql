/*

!!GENERATING & USING SEQUENCES - BASIC!!

> A sequence is a set of integers (1, 2, 3, …) generated in order on demand. 
> Sequences see frequent use in databases because many applications require each row in a table to
contain a unique value, and sequences provide an easy way to generate them. 

	Using AUTO_INCREMENT columns
		> The AUTO_INCREMENT column is MySQL’s mechanism for generating a sequence
		over a set of rows. Each time you create a row in a table that contains an AUTO_IN
		CREMENT column, MySQL automatically generates the next value in the sequence as
		the column’s value. This value serves as a unique identifier, making sequences an
		easy way to create items such as customer ID numbers, shipping package waybill
		numbers, invoice or purchase order numbers, bug report IDs, ticket numbers, or
		product serial numbers.
		
	Retrieving sequence values
		> For many applications, it’s not enough just to create sequence values. It’s also necessary
		to determine the sequence value for a just-inserted row. A web application
		may need to redisplay to a user the contents of a row created from the contents of
		a form just submitted by the user. The value may need to be retrieved so it can be
		stored in rows of a related table.
		
	Resequencing techniques
		> It’s possible to renumber a sequence that has holes in it due to row deletions, reuse
		deleted values at the top of a sequence, or add a sequence column to a table that has
		none.
		
	Managing multiple simultaneous sequences
		Special care is necessary when you need to keep track of multiple sequence values,
		such as when you create rows in multiple tables that each have an AUTO_INCREMENT column.
		
	Using single-row sequence generators
		Sequences can be used as counters. For example, to count votes in a poll, you might
		increment a counter each time a candidate receives a vote. The counts for a given
		candidate form a sequence, but because the count itself is the only value of interest,
		there is no need to generate a new row to record each vote. MySQL provides a
		solution for this problem using a mechanism that enables a sequence to be easily
		generated within a single table row over time. To store multiple counters in the
		table, use a column that identifies each counter uniquely. The same mechanism also
		enables creation of sequences that increase by values other than one or by nonuniform
		values.
*/