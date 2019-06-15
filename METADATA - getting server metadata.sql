/*

!!METADATA - GETTING SERVER METADATA!!

> You want the MySQL server to tell you about itself

> Several SQL functions and SHOW statements return information about the server

*/

/*
> MySQL has several SQL functions and statements that provide you with information
about the server itself and about your current client session. 
> The following table shows a few that you may find useful
STATEMENT 				INFORMATION PRODUCED BY STATEMENT
SELECT VERSION() 		Server version string
SELECT DATABASE() 		Default database name (NULL if none)
SELECT USER() 			Current user as given by client when connecting
SELECT CURRENT_USER() 	User used for checking client privileges
SHOW [GLOBAL|SESSION] 	STATUS Server global or session status indicators
SHOW [GLOBAL|SESSION] 	VARIABLES Server global or status configuration variables

> To obtain the information provided by any statement in the table, execute it and process
its result set
*/