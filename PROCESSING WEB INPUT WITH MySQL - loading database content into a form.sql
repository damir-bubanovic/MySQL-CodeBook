/*

!!PROCESSING WEB INPUT WITH MySQL - LOADING DATABASE CONTENT INTO A FORM!!

> You want to display a form but initialize it using the contents of a database record, to
present a record-editing form

> Generate the form as you usually would, but populate it with database content. That is,
instead of setting the form fields to their usual defaults, set them to values retrieved
from the database

*/

/*
> Normally, you would permit the user to specify which record to edit.
	1) npr. assume the use of a record that has an id value of 1, with the following
	contents
	
To generate a form with contents that correspond to a database record, use the column
values for the element defaults as follows:

	• For <input> elements such as radio buttons or checkboxes, add a checked attribute
	to each list item that matches the column value.
	
	• For <select> elements such as pop-up menus or scrolling lists, add a selected
	attribute to each list item that matches the column value.
	
	• For text fields represented as <input> elements of type text, set the value attribute
	to the corresponding column value. 
		2) npr. to present a 60-character field for	cust_name, initialized to Farmer Brown
		3) To present a <textarea> element instead, set the body to the column value. 
		To create a field 40 columns wide and 3 rows high, write it like this:

	• In a record-editing situation, it’s a good idea to include a unique value in the form
	so that you can tell which record the form contents represent when the user submits it. 
		> Use a hidden field to do this. 
			4) Its value is not displayed to the user, but the browser returns it with the 
			rest of the field values. 
			
5) The following procedure outlines how to load the sample cow_table record into an
editing form for a CGI.pm-based Perl script - convert to PHP (ima ga puno)
*/
1)
mysql> SELECT * FROM cow_order WHERE id = 1\G

2)
<input type="text" name="cust_name" value="Farmer Brown" size="60" />

3)
<textarea name="cust_name" cols="40" rows="3">
Farmer Brown
</textarea>

4)
<input type="hidden" name="id" value="1" />
