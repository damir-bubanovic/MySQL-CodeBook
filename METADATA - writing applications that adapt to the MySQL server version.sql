/*

!!METADATA - WRITING APPLICATIONS THAT ADAPT TO THE MYSQL SERVER VERSION!!

> You want to use a given feature that is available only as of a particular version of MySQL

> Ask the server for its version number. 
	>> If the server is too old to support a given feature, maybe you can fall back to a 
	workaround, if one exists

*/

/*
> To get the server version, invoke the VERSION() function. 
	>> The result is a string that looks something like 5.5.25a or 5.7.4-m14.
*/