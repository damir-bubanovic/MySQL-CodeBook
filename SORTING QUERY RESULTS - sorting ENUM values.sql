/*

!!SORTING QUERY RESULTS - SORTING ENUM VALUES!!

> ENUM values don’t sort like other string columns

> Learn how they work, and exploit those properties to your advantage

*/

/*
> ENUM is a string data type, but ENUM values actually are stored numerically with values
ordered the same way they are listed in the table definition

> Suppose that a table named
weekday contains an enumeration column named day that has weekday names as its
members
*/
CREATE TABLE weekday
(
day ENUM('Sunday','Monday','Tuesday','Wednesday',
'Thursday','Friday','Saturday')
);


/*
> Internally, MySQL defines the enumeration values Sunday through Saturday in that
definition to have numeric values from 1 to 7

EXAMPLE:
1) To make the insertion order differ from sorted order (so that you can see the effect of
sorting), add the days in random order

2) Then select the values, both as strings and as the internal numeric value (obtain the
latter using +0 to force a string-to-number conversion)

3) If you add an ORDER BY day clause, it becomes apparent that MySQL
uses the internal numeric values for sorting

4) What about occasions when you want to sort ENUM values in lexical order? Force them
to be treated as strings for sorting using the CAST() function
*/
1)
mysql> INSERT INTO weekday (day) VALUES('Monday'),('Friday'),
	-> ('Tuesday'), ('Sunday'), ('Thursday'), ('Saturday'), ('Wednesday');	
	
2)
mysql> SELECT day, day+0 FROM weekday;

3)
mysql> SELECT day, day+0 FROM weekday ORDER BY day;

4)
mysql> SELECT day, day+0 FROM weekday ORDER BY CAST(day AS CHAR);


/*
>If you always (or nearly always) sort a non-enumeration column in a specific nonlexical
order, consider changing the data type to ENUM, with its values listed in the desired sort order

EXAMPLE:
1) create a color table containing a string column, and populate it with some sample rows

2) Sorting by the name column at this point produces lexical order because the column
contains CHAR values

> Now suppose that you want to sort the column by the order in which colors occur in
the rainbow
3) One way to produce a rainbow sort is to use FIELD()


4) To accomplish the same end without FIELD(), use ALTER TABLE to convert the name
column to an ENUM that lists the colors in the desired sort order

5) After converting the table, sorting on the name column produces rainbow sorting naturally
with no special treatment
*/
1)
mysql> CREATE TABLE color (name CHAR(10));
mysql> INSERT INTO color (name) VALUES ('blue'),('green'),
	-> ('indigo'),('orange'),('red'),('violet'),('yellow');

2)
mysql> SELECT name FROM color ORDER BY name;

3)
mysql> SELECT name FROM color
	-> ORDER BY
	-> FIELD(name,'red','orange','yellow','green','blue','indigo','violet');

	
4)
mysql> ALTER TABLE color
	-> MODIFY name
	-> ENUM('red','orange','yellow','green','blue','indigo','violet');

5)
mysql> SELECT name FROM color ORDER BY name;
