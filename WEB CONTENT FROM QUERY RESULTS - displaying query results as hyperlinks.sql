/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - DISPLAYING QUERY RESULTS AS HYPERLINKS!!

> You want to create clickable hyperlinks from database content

> Add the proper tags to the content to generate anchor elements

*/

/*
> Website URLs or email addresses stored in a table are easily converted to active links in 
web pages. 
	>> You need only properly encode the information and add the appropriate HTML tags
	
EXAMPLE:
1) Table named book_vendor contains bookseller and publisher names and websites

2) Hyperlinked text

3) Use foreach to generate list
*/
1)
mysql> SELECT * FROM book_vendor ORDER BY name;

2)
<a href="http://www.barnesandnoble.com">Barnes &amp; Noble</a>


/*
> Generating links using email addresses is another common web programming task

EXAMPLE:
1) Table named newsstaff lists the department, name, and (if known) email
address for the news anchors and reporters employed by a television station

2) Email formating

3) Use function
	> First, put the code to generate an email link into a helper function because 
	that operation is likely to be useful in multiple scripts
	> The function handles instances where the person has no email address by returning 
	just the name as static text. 
		>> To use the function, write a loop that pulls out names and addresses and 
		displays each email link preceded by the staff member’s department
*/
1)
mysql> SELECT * FROM newsstaff;

2) 
Sports: <a href="mailto:bwinthrop@wrrr-news.com">Becky Winthrop</a>