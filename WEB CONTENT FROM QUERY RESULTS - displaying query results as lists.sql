/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - DISPLAYING QUERY RESULTS AS LISTS!!

> You want to display a query result as a structured list of items

> There are several HTML list types. Write the list items within tags appropriate for the
desired type of list

*/

/*
> HTML provides several styles of lists, such as ordered lists, unordered lists, and 
definition lists. To nest lists, use list-within-list formatting.

> Two approaches to list generation are common: 
	1) To print the tags as you process the result set, print the list opening tag, fetch 
	and print each result set row as a list item, including the item tags, and print the 
	list closing tag.
	2) Alternatively, to process the list in memory, store the list items in an array, 
	pass the array to a list-generation function that adds the appropriate tags, and print 
	the result
*/

/*
EXAMPLE:
1) Ingredient table contains numbered ingredients for a cooking recipe

2) Perform the operation like this

3) The function must handle two operations:
	+) HTML-encoding the items (if they aren’t already encoded), 
	) and adding the proper HTML tags
	3.1) It takes the list items as an array argument and returns the list as a string
	3.2) To use the utility function, fetch the data and print the HTML like so
*/
1)
mysql> SELECT * FROM ingredient ORDER BY id;

2)
$stmt = "SELECT item FROM ingredient ORDER BY id";
$sth = $dbh->query ($stmt);
print ("<ol>");
while (list ($item) = $sth->fetch (PDO::FETCH_NUM))
print ("<li>" . htmlspecialchars ($item) . "</li>");
print ("</ol>");

3.1)
function make_ordered_list ($items, $encode = TRUE) {
	$result = "";
	
	foreach ($items as $val) {
		if ($encode) {
			$val = htmlspecialchars ($val);
			$result .= "<li>$val</li>";
		}
	}
	return ("<ol>$result</ol>");
}
3.2)
# fetch items for list
$stmt = "SELECT item FROM ingredient ORDER BY id";
$sth = $dbh->query ($stmt);
$items = $sth->fetchAll (PDO::FETCH_COLUMN, 0);

# generate HTML list
print (make_ordered_list ($items));


/*
DEFINITION LISTS
> A definition list consists of two-part items, each including a term and a definition.
“Term” and “definition” have loose meanings because you can display any kind of information
you want.

EXAMPLE:
+) Definition list

1) Fetch the data and then pass it to a utility function that takes arrays of
terms and definitions and returns the list as a string

2) The make_definition_list() function looks like this
*/
+)
<dl>
<dt>do</dt> <dd>A deer, a female deer</dd>
<dt>re</dt> <dd>A drop of golden sun</dd>
<dt>mi</dt> <dd>A name I call myself</dd>
<dt>fa</dt> <dd>A long, long way to run</dd>
<dt>so</dt> <dd>A needle pulling thread</dd>
<dt>la</dt> <dd>A note to follow so</dd>
<dt>ti</dt> <dd>A drink with jam and bread</dd>
</dl>

1)
# fetch items for list
$stmt = "SELECT note, mnemonic FROM doremi ORDER BY id";
$sth = $dbh->query ($stmt);
$terms = array ();
$defs = array ();

while (list ($note, $mnemonic) = $sth->fetch (PDO::FETCH_NUM)) {
	$terms[] = $note;
	$defs[] = $mnemonic;
}

# generate HTML list
print (make_definition_list ($terms, $defs));

2)
function make_definition_list ($terms, $definitions, $encode = TRUE) {
	$result = "";
	$n = count ($terms);
	
	for ($i = 0; $i < $n; $i++) {
		$term = $terms[$i];
		$definition = $definitions[$i];
		
		if ($encode) {
			$term = htmlspecialchars ($term);
			$definition = htmlspecialchars ($definition);
		}
		$result .= "<dt>$term</dt><dd>$definition</dd>";
	}
	return ("<dl>$result</dl>");
}


/*
NESTED LISTS

EXAMPLE:
+) For each item in the list, the term is the initial letter, and the definition is an
unordered list of the state names beginning with that letter


*/
+)
A
	• Alabama
	• Alaska
	• Arizona
	• Arkansas
C
	• California
	• Colorado
	• Connecticut
D
	• Delaware
	...
