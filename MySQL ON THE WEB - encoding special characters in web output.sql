/*

!!MySQL ON THE WEB - ENCODING SPECIAL CHARACTERS IN WEB OUTPUT!!

> Certain characters are special in web pages and must be encoded if you want to display
them literally. Because database content often contains instances of these characters,
scripts that include query results in web pages should encode those results to prevent
browsers from misinterpreting the information

> Use the methods provided by your API for performing HTML-encoding and URLencoding

*/

/*
> There are actually two kinds of encoding, depending on the context in which you use a character
	+) One encoding is appropriate for HTML text
	+) Another is used for text that is part of a URL in a hyperlink
	
	> In the general case, it’s unsafe to assume that a query result contains no special characters, 
	so you must be prepared to encode it for display in a web page
*/

/*
GENERAL ENCODING PRINCIPLES

	+) Encoding characters that are special in HTML
		>> Convert & deconvert them:
			Special character  	HTML entity
			< 					&lt;
			> 					&gt;
			& 					&amp;
			" 					&quot;
			
	+) Encoding characters that are special in URLs
		>> URLs for hyperlinks that occur within HTML pages have their own syntax and their own encoding. 
		>> This encoding applies to attributes within several tags
			<a href="URL">
			<img src="URL">
			<form action="URL">
			<frame src="URL">
		>> Many characters have special meaning within URLs, such as :, /, ?, =, &, and ;.
		>> ASCII value of the space character is 32 decimal, or 20 hexadecimal, so write
		the preceding hyperlink like this
			<a href="http://localhost/my%20home%20page.html">My Home Page</a>
*/

/*
ENCOGING SPECIAL CHARACTERS USING WEB APIs
> The following encoding examples show how to retrieve values from MySQL and perform
both HTML-encoding and URL-encoding on them to generate hyperlinks

EXAMPLE:
1) The table contains the following rows

> The goal here is to generate a list of hyperlinks using each phrase both as the hyperlink
label (which requires HTML-encoding) and in the URL as a parameter to the search
script (which requires URL-encoding)
2) The resulting links look something like this

3) In PHP, the htmlspecialchars() and urlencode() functions perform HTMLencoding
and URL-encoding
*/
1)
mysql> SELECT phrase_val FROM phrase ORDER BY phrase_val;

2)
<a href="/cgi-bin/mysearch.pl?phrase=are%20we%20%22there%22%20yet%3F">
are we &quot;there&quot; yet?</a>
<a href="/cgi-bin/mysearch.pl?phrase=cats%20%26%20dogs">
cats &amp; dogs</a>
<a href="/cgi-bin/mysearch.pl?phrase=rhinoceros">
rhinoceros</a>
<a href="/cgi-bin/mysearch.pl?phrase=the%20whole%20%3E%20sum%20of%20parts">
whole &gt; sum of parts</a>

3)
$stmt = "SELECT phrase_val FROM phrase ORDER BY phrase_val";
$sth = $dbh->query ($stmt);

while (list ($phrase) = $sth->fetch (PDO::FETCH_NUM)) {
	# URL-encode the phrase value for use in the URL
	$url = "/mcb/mysearch.php?phrase=" . urlencode ($phrase);
	
	# HTML-encode the phrase value for use in the link label
	$label = htmlspecialchars ($phrase);
	printf ('<a href="%s">%s</a><br />', $url, $label);
}
