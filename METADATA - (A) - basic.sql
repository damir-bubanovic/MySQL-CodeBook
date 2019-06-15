/*

!!METADATA - BASIC!!

> Information that characterizes or describes those values—that is, the statement metadata
> Metadata is used most often to process result sets, but also applies to other aspects of 
your interaction with MySQL

*/

/*
> This chapter describes how to obtain and use several types of metadata:
Information about statement results
	> For statements that delete or update rows, you can determine how many rows were
	changed. 
	> For a SELECT statement, you can obtain the number of columns in the result set, 
	as well as information about each column in the result set, such as the
	column name and its display width. 
	
Information about databases and tables
	> A MySQL server can be queried to determine which databases and tables it manages,
	which is useful for existence tests or producing lists. 
	> Table metadata can be examined to determine column definitions
	
Information about the MySQL server
	> The database server provides information about itself and about the status of your
	current session with it. 
	> Knowing the server version can be useful for determining whether it supports a given 
	feature, which helps you build adaptive applications.
*/