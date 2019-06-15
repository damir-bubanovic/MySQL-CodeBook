/*

!!HANDLING DUPLICATES - PREVENTING DUPLICATES FROM OCCURING IN A TABLE!!

> You want to prevent a table from ever containing duplicates

> Use a PRIMARY KEY or a UNIQUE index

*/

/*
EXAMPLE:
> To prevent multiple rows with the same first and last name values from being created
in this table, add a PRIMARY KEY to its definition. 
1) When you do this, the indexed columns must be NOT NULL, because a PRIMARY KEY prohibits 
NULL values

> UNIQUE index can be created on columns that permit NULL values
2) For the person table, it’s likely that you’d require both the first and last names to be 
filled in. If so, you still declare the columns as NOT NULL, and the following table definition 
is effectively equivalent to the preceding one:

> NULL is special because it is the one value that can occur multiple times

> Each person must be assigned some sort of unique identifier
3) Use an AUTO_INCREMENT column

> Another possibility is to assign identifiers externally and use those IDs as unique keys. 
4) Citizens in a given country might have unique taxpayer ID numbers. If so, those numbers 
can serve as the basis for a unique index
*/
1)
CREATE TABLE person
(
last_name CHAR(20) NOT NULL,
first_name CHAR(20) NOT NULL,
address CHAR(40),
PRIMARY KEY (last_name, first_name)
);

2)
CREATE TABLE person
(
last_name CHAR(20) NOT NULL,
first_name CHAR(20) NOT NULL,
address CHAR(40),
UNIQUE (last_name, first_name)
);

3)
CREATE TABLE person
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
last_name CHAR(20),
first_name CHAR(20),
address CHAR(40),
PRIMARY KEY (id)
);

4)
CREATE TABLE person
(
tax_id INT UNSIGNED NOT NULL,
last_name CHAR(20),
first_name CHAR(20),
address CHAR(40),
PRIMARY KEY (tax_id)
);
