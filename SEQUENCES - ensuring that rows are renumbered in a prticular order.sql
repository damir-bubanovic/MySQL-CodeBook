/*

!!GENERATING & USING SEQUENCES - ENSURING THAT ROWS ARE RENUMBERED IN A PARTICULAR ORDER!!

> You resequenced a column, but MySQL didn’t number the rows the way you want

> Select the rows into another table, using an ORDER BY clause to place them in the order
you want, and let MySQL number them according to the sort order as it performs the
operation

*/

/*
> When you resequence an AUTO_INCREMENT column, MySQL is free to pick the rows from
the table in any order, so it doesn’t necessarily renumber them in the order that you
expect.
> You might have an application for which it’s important that the rows be assigned 
sequence numbers in a particular order

USE THIS SEQUENCE:
1. Create an empty clone of the table
2. Copy rows from the original into the clone using INSERT INTO … SELECT. 
	> Copy all columns except the AUTO_INCREMENT column, using an ORDER BY clause to specify
	the order in which rows are copied (and thus the order in which MySQL assigns numbers 
	to the AUTO_INCREMENT column).
3. Drop the original table and rename the clone to have the original table’s name.
4. If the table is a large MyISAM table and has multiple indexes, it is more efficient to
create the new table initially with no indexes except the one on the AUTO_INCREMENT column. 
	> Then copy the original table into the new table and use ALTER TABLE to add the remaining 
	indexes afterward.
*/