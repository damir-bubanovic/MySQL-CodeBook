/*

!!PROCESSING WEB INPUT WITH MySQL - PERFORMING WEB-BASED DATABASE SEARCHES!!

> You want to implement a web-based search interface

> Present a form containing fields that enable the user to supply search parameters such
as keywords. Use the submitted keywords to construct a database query, then display
the query results

*/

/*
> You have that in PHP cookbook

> As the writer of such a script, you must handle these operations:
	1. Generate the form and send it to the users.
	2. Interpret the submitted form and construct an SQL statement based on its contents.
		>> This includes proper use of placeholders or quoting to prevent bad input from
		crashing or subverting your script.
	3. Execute the statement and display its result. This can be simple if the result set is
	small, or more complex if it is large. In the latter case, you may want to present the
	matching records using a paged display—that is, a display consisting of multiple
	pages, each of which shows a subset of the entire statement result.
*/