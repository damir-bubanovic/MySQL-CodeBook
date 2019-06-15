/*

!!PROCESSING WEB INPUT WITH MySQL - BASIC!!

> This chapter considers the use of MySQL as: 
	>> web-based database programming to collect information sent from user to web server, 
	such as the contents of a submitted form. 
		>>> npr. you might store the information from a survey form for later use, or use 
		keywords from a lookup form as the basis for a query to search the database for 
		information the user wants

> It’s often possible to use information from your database to generate form elements
such as radio buttons, checkboxes, pop-up menus, or scrolling lists	
	• Select a set of items from a table that lists countries, states, or provinces and convert
	them into a pop-up menu in a form that collects address information.
	• Use the list of legal values for an ENUM column that contains permitted colors or
	sizes to generate a set of radio buttons.
	• Use lists of available colors, sizes, or styles stored in an inventory database to construct
	fields for a clothing ordering form.
*/

/*
> Following topics relating to web input processing:
	Generating forms and form elements
		>> One way to use database content for form construction is to select a list of items
		from a table and create the options in a list element. 
		- But metadata can be used as well. 
		- There is a natural correspondence between ENUM columns and single-pick form
		elements like radio button sets or pop-up menus. 
		- There is a similar correspondence between SET columns and multiple-pick elements 
		like checkbox groups; any or all of the possible values may be chosen.
	Initializing forms using database contents
		>> In addition to using the database to create structural elements of forms, you can
		also use it to initialize their values. 
			>>> npr. to enable a user to modify an existing record, retrieve it from the 
			database and load its values into the corresponding form fields before sending 
			the form to the user for editing.
	Processing input gathered over the Web
		>> This includes input not only from form fields, but also the contents of uploaded
		files, or parameters in URLs. 
		- Regardless of how you obtain the information, you	face a common set of issues in 
		dealing with it: extracting and decoding the information, performing constraint or 
		validity checking on it, and re-encoding the information for SQL statement construction 
		to avoid generating malformed statements or storing information inaccurately
*/

/*
+) Table example
*/
+)
CREATE TABLE cow_order
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
# cow color, figurine size, and accessory items
color VARCHAR(20),
size ENUM('small','medium','large') DEFAULT 'medium',
accessories SET('cow bell','horns','nose ring','tail ribbon')
DEFAULT 'cow bell,horns',
# customer name, street, city, and state (abbreviation)
cust_name VARCHAR(40),
cust_street VARCHAR(40),
cust_city VARCHAR(40),
cust_state CHAR(2),
PRIMARY KEY (id)
);
