/*

!!METADATA - DETERMINING WHEATER A STATEMENT PRODUCED A RESULT SET!!

> You just executed an SQL statement, but you’re not sure whether it produced a 
result set

> Check the column count in the metadata. 
> There is no result set if the count is zero

*/

/*
> If you write an application that accepts statement strings from an external source such
as a file or a user entering text at the keyboard, you may not necessarily know whether
it’s a statement such as SELECT that produces a result set or a statement such as UP
DATE that does not.

> Assuming that no error occurred, one way to tell the difference is to check the metadata 
value that indicates the column count after executing the statement
*/