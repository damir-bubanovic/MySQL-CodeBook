/*

!!BASIC - MySQL-BASED PROGRAMS - IDENTIFYING NULL VALUES IN RESULT SETS!!

> A query result includes NULL values, but you’re not sure how to identify them

> Your API probably has some special value that represents NULL by convention. 
You just have to know what it is and how to test for it
	>> example -> PHP PDO -> NULL value

> An alternative to === for NULL value tests is is_null()

*/

/*
> To make sure that the profile table has a row that contains some NULL values, use mysql
to execute the following INSERT statement, then execute the SELECT statement to verify
that the resulting row has the expected values
*/
mysql> INSERT INTO profile (name) VALUES('Amabel');
mysql> SELECT * FROM profile WHERE name = 'Amabel';


/*
> To determine whether a value from a result set represents a NULL value, compare it to the 
PHP NULL value using the === “triple equal” operator
*/
if($val === NULL) {
	# $val is a NULL value
}


/*
> The following code uses the === operator to identify NULL values in a result set and print
them as the string "NULL"
*/
$sth = $dbh->query ("SELECT name, birth, foods FROM profile");
while($row = $sth->fetch (PDO::FETCH_NUM)) {
	foreach (array_keys ($row) as $key) {
		if ($row[$key] === NULL)
		$row[$key] = "NULL";
	}
	print ("name: $row[0], birth: $row[1], foods: $row[2]\n");
}