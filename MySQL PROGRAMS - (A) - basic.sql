/*

!!BASIC - MySQL-BASED PROGRAMS - basic!!

> This chapter discusses how to use MySQL from within the context of a 
general-purpose programming language

> These operations include:
	+) connecting to the MySQL server
	+) executing statements
	+) retrieving the results

*/


/*
MySQL CLIENT API ARCHITECTORE
> MySQL programming interface covered in this book uses a two-level architecture
	• The upper level provides database-independent methods that implement database
	access in a portable way that’s the same whether you use MySQL, PostgreSQL, Oracle,
	or whatever.
	• The lower level consists of a set of drivers, each of which implements the details 
	for a single database system.
	
> This two-level architecture enables application programs to use an abstract interface
not tied to details specific to any particular database server. 
	>> This enhances portability of your programs: to use a different database system, 
	just select a different lower-level driver.
*/