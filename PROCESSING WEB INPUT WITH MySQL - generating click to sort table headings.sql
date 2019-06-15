/*

!!PROCESSING WEB INPUT WITH MySQL - GENERATING “Click to Sort” TABLE HEADINGS!!

> You want to display a query result in a web page as a table that enables the user to select
the column by which to sort the table rows

> Make each column heading a hyperlink that redisplays the table, sorted by the corresponding
column

*/

/*
> You have solution in PHP cookbook

EXAMPLE:
1) To make the headings active links that reinvoke the script to produce a display sorted
by a given column name, we must produce a header row that looks like this

2) in PHP, a script can generate the header row for the columns in a given statement as follows,
where getColumnMeta(i) returns metadata for column i

3) It checks its environment for a sort parameter that indicates which column to use for sorting, 
then uses the parameter to construct a statement of the following form
*/
1)
<tr>
<th><a href="script_name?sort=rec_id">rec_id</a></th>
<th><a href="script_name?sort=name">name</a></th>
<th><a href="script_name?sort=trav_date">trav_date</a></th>
<th><a href="script_name?sort=miles">miles</a></th>
</tr>

2)
print ('<tr>');
$ncols = $sth->columnCount ();
for ($i = 0; $i < $ncols; $i++) {
	$col_info = $sth->getColumnMeta ($i);
	$col_name = $col_info['name'];
	printf ('<th><a href="%s?sort=%s">%s</a></th>',
	$_SERVER['PHP_SELF'],
	urlencode ($col_name),
	htmlspecialchars ($col_name));
}
print ('</tr>');

3)
SELECT * FROM $tbl_name ORDER BY $sort_col LIMIT 50


/*
+) The following script looks up the name from INFORMATION_SCHEMA. It also uses a LIM
IT clause when retrieving results as a precaution that prevents the script from dumping
huge amounts of output if the table is large
*/
+)
<?php
# clicksort.php: display query result as HTML table with "click to sort"
# column headings
# Rows from the database table are displayed as an HTML table.
# Column headings are presented as hyperlinks that reinvoke the
# script to redisplay the table sorted by the corresponding column.
# The display is limited to 50 rows in case the table is large.
require_once "Cookbook.php";
require_once "Cookbook_Utils.php";
require_once "Cookbook_Webutils.php";
$title = "Table Display with Click-To-Sort Column Headings";
?>
<html>
<head><title><?php print ($title); ?></title></head>
<body>
<?php
# names for database and table and default sort column; change as desired
$db_name = "cookbook";
$tbl_name = "driver_log";
$dbh = Cookbook::connect ();
print ("<p>" . htmlspecialchars ("Table: $db_name.$tbl_name") . "</p>");
print ("<p>Click a column name to sort by that column.</p>");
# Get the name of the column to sort by: If missing, use the first column.
$sort_col = get_param_val ("sort");
if (!isset ($sort_col))
{
$stmt = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = ? AND TABLE_NAME = ?
AND ORDINAL_POSITION = 1";
$sth = $dbh->prepare ($stmt);
$sth->execute (array ($db_name, $tbl_name));
list ($sort_col) = $sth->fetch (PDO::FETCH_NUM);
}
# Construct query to select records from the table, sorting by the
# named column. Limit output to 50 rows to avoid dumping entire
# contents of large tables.
$stmt = sprintf ("SELECT * FROM %s.%s ORDER BY %s LIMIT 50",
quote_identifier ($db_name),
quote_identifier ($tbl_name),
quote_identifier ($sort_col));
$sth = $dbh->query ($stmt);
# Display query results as HTML table. Use query metadata to get column
# names, and display names in first row of table as hyperlinks that cause
# the table to be redisplayed, sorted by the corresponding table column.
print ('<table border="1">');
print ('<tr>');
$ncols = $sth->columnCount ();
for ($i = 0; $i < $ncols; $i++)
{
$col_info = $sth->getColumnMeta ($i);
$col_name = $col_info['name'];
printf ('<th><a href="%s?sort=%s">%s</a></th>',
$_SERVER['PHP_SELF'],
urlencode ($col_name),
htmlspecialchars ($col_name));
}
print ('</tr>');
while ($row = $sth->fetch (PDO::FETCH_NUM))
{
print ('<tr>');
for ($i = 0; $i < $ncols; $i++)
{
# encode values, using &nbsp; for empty cells
$val = $row[$i];
if (isset ($val) && $val != '')
$val = htmlspecialchars ($val);
else
$val = '&nbsp;';
printf ('<td>%s</td>', $val);
}
print ('</tr>');
}
print ('</table>');
$dbh = NULL;
?>
</body>
</html>
