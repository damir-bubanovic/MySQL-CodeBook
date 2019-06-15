/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - CREATING NAVIGATION INDEXES FROM DATABASE CONTENT!!

> A list of items in a web page is long. You want to make it easier for users to move around
in the list

> Create a navigation index containing links to different sections of the list

*/

/*
> If you retrieve rows from a table and display them grouped into sections, you can include an index 
that lets the user jump to any section. 
> The same idea applies to multiple-page displays as well, using a navigation index in each page that 
enables users to reach any other page easily
*/

/*
CREATING A SINGLE-PAGE NAVIGATION INDEX
> This example displays all verses in Esther in a single page, with verses grouped into
sections by chapter

EXAMPLE:
1) To display the page so that each section contains a navigation marker, place an 
<a name> anchor element before each chapter’s verses

2) To construct the navigation index, build a set of hyperlinks, each of which points 
to one of the name markers
	> The # in each href attribute signifies that the link points to a location within the same
	page. 
		>> npr. href="#3" points to the anchor with the name="3" attribute
		
		
> To implement this kind of navigation index, use one of these approaches:
	• Retrieve the verse rows into memory and determine from them the entries needed
	in the navigation index. Then print both the index and verse list.
	
	• Figure out all the applicable anchors in advance and construct the index first. 
	> This statement determines the list of chapter numbers:
		SELECT DISTINCT cnum FROM kjv WHERE bname = 'Esther' ORDER BY cnum;
	> Use the query result to build the navigation index, then fetch the verses for the
	chapters later to create the page sections to which the index entries point

3) Script to convert to PHP on Cookbook
*/
1)
<a name="1">Chapter 1</a>
... list of verses in chapter 1...
<a name="2">Chapter 2</a>
... list of verses in chapter 2...
<a name="3">Chapter 3</a>
... list of verses in chapter 3...
…

2)
<a href="#1">Chapter 1</a>
<a href="#2">Chapter 2</a>
<a href="#3">Chapter 3</a>
…


/*
CREATING A MULTIPLE-PAGE NAVIGATION INDEX
> The initial page displays a list of the chapters in the book, along with the verses from chapter 1.
Each item in the chapter list is a hyperlink that reinvokes the script to display the list of verses 
in one of the other chapters

> Because the script is responsible for generating multiple pages, it must be able to determine which 
page to display each time it runs. To make that possible, the script examines its own URL for a chapter 
parameter that indicates the number of the chapter to display

EXAMPLE:
1) The URL to request the initial page looks like this

2) The links to individual chapter pages have the following form, where cnum is a chapter
number

3) Script to convert to PHP on Cookbook
*/
1)
http://localhost/cgi-bin/esther2.pl

2)
http://localhost/cgi-bin/esther2.pl?chapter=cnum
