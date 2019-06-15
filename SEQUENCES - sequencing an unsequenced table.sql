/*

!!GENERATING & USING SEQUENCES - SEQUENCING AN UNSEQUENCED TABLE!!

> You forgot to include a sequence column when you created a table. 
	>> Is it too late to sequence the table rows?

> No. 
	>> Add an AUTO_INCREMENT column using ALTER TABLE; MySQL creates the column 
	and numbers its rows

*/

/*
>To add a sequence to a table that doesn’t currently contain one, use ALTER TABLE to create
an AUTO_INCREMENT column. 

EXAMPLE:
1) Suppose that a table contains name and age columns, but no sequence column

2) Add a sequence column named id to the table as follows
*/
1)
mysql> SELECT * FROM t;

2)
mysql> ALTER TABLE t
	-> ADD id INT NOT NULL AUTO_INCREMENT,
	-> ADD PRIMARY KEY (id);
mysql> SELECT * FROM t ORDER BY id;

/*
> By default, ALTER TABLE adds new columns to the end of the table. 
	>> To place a column at a specific position, use FIRST or AFTER at the end of the ADD clause. 

EXAMPLE:	
1) The following ALTER TABLE statements are similar to the one just shown, but place the id column 
first in the table or after the name column, respectively
*/
1)
ALTER TABLE t
ADD id INT NOT NULL AUTO_INCREMENT FIRST,
ADD PRIMARY KEY (id);

ALTER TABLE t
ADD id INT NOT NULL AUTO_INCREMENT AFTER name,
ADD PRIMARY KEY (id);