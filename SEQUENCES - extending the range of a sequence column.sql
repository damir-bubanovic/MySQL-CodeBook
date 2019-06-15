/*

!!GENERATING & USING SEQUENCES - EXTENDING THE RANGE OF A SEQUENCE COLUMN!!

> You want to avoid resequencing a column, but you’re running out of room for new
sequence numbers

> Check whether you can make the column UNSIGNED or change it to use a larger integer
type.

*/

/*
STRATEGY:

• If the data type is signed, make it UNSIGNED to double the range of available values.
	1.1) Suppose that an id column currently is defined like this:
		> The upper range of a signed MEDIUMINT column is 8,388,607. 
		1.2) To increase this to 16,777,215, make the column UNSIGNED with ALTER TABLE:

• If your column is already UNSIGNED and it is not already the largest integer type
(BIGINT), converting it to a larger type increases its range. 
	> Use ALTER TABLE for this, too. 
	2) Convert the id column in the previous example from MEDIUMINT to BIGINT like so:

*/
1.1)
id MEDIUMINT NOT NULL AUTO_INCREMENT
1.2)
ALTER TABLE tbl_name MODIFY id MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT;

2)
ALTER TABLE tbl_name MODIFY id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT;