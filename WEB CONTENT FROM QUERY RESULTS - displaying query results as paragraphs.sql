/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - DISPLAYING QUERY RESULTS AS PARAGRAPHS!!

> You want to display a query result as free text

> Display it within paragraph tags

*/

/*
> Paragraphs are useful for displaying free text with no particular structure. Retrieve the
text to be displayed, encode it to convert any special characters to the corresponding
HTML entities, and wrap each paragraph within <p> and </p> tags

EXAMPLE:
1) Produce paragraphs for a status display that includes the current date and time, 
the server version, and the default database name

> One complication is that the DATABASE() result is NULL if there is no default database.
The examples show how to handle this
*/
1)
mysql> SELECT NOW(), VERSION(), DATABASE();

2)
$sth = $dbh->query ("SELECT NOW(), VERSION(), DATABASE()");
list ($now, $version, $db) = $sth->fetch (PDO::FETCH_NUM);
if ($db === NULL) {
}
$db = "NONE";
$para = "Local time on the MySQL server is $now.";
print ("<p>" . htmlspecialchars ($para) . "</p>");
$para = "The server version is $version.";
print ("<p>" . htmlspecialchars ($para) . "</p>");
$para = "The default database is $db.";
print ("<p>" . htmlspecialchars ($para) . "</p>");