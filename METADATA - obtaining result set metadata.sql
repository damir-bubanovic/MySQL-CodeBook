/*

!!METADATA - OBTAINING RESULT SET METADATA!!

> You already know how to retrieve the rows of a result set
> Now you want to know things about the result set, such as the column names and data types, 
or how many rows and columns there are

> Use the capabilities provided by your API

*/

/*
> Statements such as SELECT that generate a result set produce several types of metadata

EXAMPLE:
> When you retrieve a row from a result set and you want to process the column values in a loop, 
the column count stored in the metadata serves as the upper bound on the loop iterator

> Metadata for SELECT statements is available from PDO after a successful call to query(). 
> If you execute a statement using prepare() plus execute() instead (which can be used for 
SELECT or non-SELECT statements), metadata becomes available after execute()

> To determine metadata availability, check whether the statement handle columnCount() method 
returns a value greater than zero. 
	>> If so, the handle’s getColumnMeta() method returns an associative array containing 
	metadata for a single column
	
> The following table shows the elements of this array
	NAME 			VALUE
	pdo_type 		Column type (corresponds to a PDO::PARAM_XXX value)
	native_type 	PHP native type for the column value
	name 			Column name
	len 			Column length
	precision 		Column precision
	flags 			Array of flags describing the column attributes
	table 			Name of table the column is part of
*/

/*
EXAMPLE:
1) This example code shows how to execute a statement and display result set metadata

2) The program produces this output
*/
1)
$stmt = "SELECT name, birth FROM profile";
print ("Statement: $stmt\n");

$sth = $dbh->prepare ($stmt);
$sth->execute ();

# metadata information becomes available at this point ...
$ncols = $sth->columnCount ();
print ("Number of columns: $ncols\n");
if ($ncols == 0) {
	print ("Note: statement has no result set\n");
}

for($i = 0; $i < $ncols; $i++) {
	$col_info = $sth->getColumnMeta ($i);
	$flags = implode (",", array_values ($col_info["flags"]));
	
	printf ("--- Column %d (%s) ---\n", $i, $col_info["name"]);
	printf ("pdo_type: %d\n", $col_info["pdo_type"]);
	printf ("native_type: %s\n", $col_info["native_type"]);
	printf ("len: %d\n", $col_info["len"]);
	printf ("precision: %d\n", $col_info["precision"]);
	printf ("flags: %s\n", $flags);
	printf ("table: %s\n", $col_info["table"]);
}

2)
Statement: SELECT name, birth FROM profile
Number of columns: 2
--- Column 0 (name) ---
PDO type: 2
native type: VAR_STRING
len: 20
precision: 0
flags: not_null
table: profile
--- Column 1 (birth) ---
PDO type: 2
native type: DATE
len: 10
precision: 0
flags:
table: profile
