/*

!!PROCESSING WEB INPUT WITH MySQL - STORING WEB INPUT IN A DATABASE!!

> Input obtained over the Web cannot be trusted and should not be entered into a database
without taking the proper precautions

> Sanitize data values by using placeholders or a quoting function so that SQL statements
you construct are valid and not subject to SQL injection attacks. Enable strict SQL mode
so the MySQL server rejects values that are invalid for column data types

*/

/*
EXAMPLE:
> convert this to PHP
1) handle an input parameter in Perl using a placeholder:

2) Or by using quote():
*/
1)
$sth = $dbh->prepare ("SELECT * FROM mytbl WHERE keyword = ?");
$sth->execute (param ("keyword"));
# ... fetch result set ...

2)
$keyword = $dbh->quote (param ("keyword"));
$sth = $dbh->prepare ("SELECT * FROM mytbl WHERE keyword = $keyword");
$sth->execute ();
# ... fetch result set ...