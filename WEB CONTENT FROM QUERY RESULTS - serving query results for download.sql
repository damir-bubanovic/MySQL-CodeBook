/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - SERVING QUERY RESULTS FOR DOWNLOAD!!

> You want to send database information to a browser for downloading rather than for
display

> A browser processes information sent to it according to the Content-Type: header value, 
and if it has a handler for that value, it treats the information accordingly. 
> However, you may be able to trick the browser by using a “generic” content type for 
which it’s unlikely to have a handler

*/

/*
EXAMPLE:
+) The following PHP script, download.php, demonstrates one way to produce downloadable
content

> When first invoked, it presents a page containing a link that can be selected
to initiate the download. The link points back to download.php but includes a down
load parameter. When you select the link, it reinvokes the script, which sees the parameter
and responds by issuing a query, retrieving a result set, and sending it to the
browser for downloading. The header() function sets the Content-Type: and Content-
Disposition: headers in the response
*/
+)
<?php
# download.php: retrieve result set and send it to user as a download
# rather than for display in a web page
require_once "Cookbook.php";
require_once "Cookbook_Webutils.php";

$title = "Result Set Downloading Example";

# If no download parameter is present, display instruction page
if (!get_param_val ("download")) {
	# construct self-referential URL that includes download parameter
	$url = $_SERVER["PHP_SELF"] . "?download=1";
?>

<html>
<head><title><?php print ($title); ?></title></head>
<body>
<p>
Select the following link to commence downloading:
<a href="<?php print ($url); ?>">download</a>
</p>
</body>
</html>

<?php
	exit ();
} # end of "if"

# The download parameter was present; retrieve a result set and send
# it to the client as a tab-delimited, newline-terminated document.
# Use a content type of application/octet-stream in an attempt to
# trigger a download response by the browser, and suggest a default
# filename of "result.txt".

$dbh = Cookbook::connect ();

$stmt = "SELECT * FROM profile";
$sth = $dbh->query ($stmt);

header ('Content-Type: application/octet-stream');
header ('Content-Disposition: attachment; filename="result.txt"');

while ($row = $sth->fetch (PDO::FETCH_NUM))
	print (implode ("\t", $row) . "\n");
	
$dbh = NULL;
?>

/*
> Another way to produce downloadable content is to generate the query result, write it
to a file on the server side, compress it, and send the result to the browser. The browser
likely will download it and run some kind of uncompress utility to recover the
original file
*/
