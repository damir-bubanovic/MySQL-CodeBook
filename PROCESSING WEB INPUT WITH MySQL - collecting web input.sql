/*

!!PROCESSING WEB INPUT WITH MySQL - COLLECTING WEB INPUT!!

> You want to extract input parameters submitted as part of a form or specified at the end
of a URL

> Use the capabilities of your API that provide a means of accessing names and values of
the input parameters in the execution environment of a web script

*/

/*
> How to collect input from the Web

> A script that receives input over the Web and uses it to interact with MySQL generally
processes the information in a series of stages

	1. Extract the input from the execution environment. When a request arrives that
	contains input parameters, the web server places the input into the environment of
	the script that handles the request, and the script queries its environment to obtain
	the parameters.
	
	2. Validate the input to make sure that it’s legal. You cannot trust users to send legal
	values, so check input parameters to make sure they look reasonable. If you don’t check input, 
	you run the risk of storing garbage in your database or	corrupting existing content.
		>> For these reasons, it might be best to consider strict SQL mode a valuable
		additional level of protection, not necessarily sufficient in itself. 
		>> That is, combine	strict mode on the server side with client-side validation.
	
	3. Construct an SQL statement based on the input. Use the input to construct a statement 
	and send it to the MySQL server. 
		>> Use of placeholders is a good idea here
*/

/*
> Input obtained over the Web can be received in several ways, two of which are most
common
	• As part of a get request, in which case input parameters are appended to the end
	of the URL
		1) npr. the following URL invokes a PHP script named price_quote.php and specifies 
		item and quantity parameters with values D-0214 and 60
		> Such requests are generated when a user selects a hyperlink or submits a form that
		specifies method="get" in the <form> tag		
	• As part of a post request, such as a form submission that specifies method="post" in 
	the <form> tag
*/
1)
http://localhost/mcb/price_quote.php?item=D-0214&quantity=60


/*
WEB INPUT EXTRACTION CONVENTIONS
> You should know the answers to these questions
	• How do you determine which parameters are available?
	• How do you obtain a parameter value from the environment?
	• Are values thus obtained the actual values submitted by the client, or do you need
	to decode them further?
	• How are multiple-valued parameters handled (for example, when several items in
	a checkbox group are selected)?
	• For parameters submitted in a URL, which separator character does the API expect
	between parameters?
	
Input parameters are available to PHP several ways, depending on your configuration
settings:
	• If the track_vars variable is enabled (which it is by default), parameters are available
	in the $_GET and $_POST arrays. If a form contains a field named id, the value
	is available as $_GET["id"] or $_POST["id"], depending on whether the form was
	submitted via get or post. $_GET and $_POST are “superglobal” arrays (accessible
	in any scope without being declared as global).
	• If the register_globals variable is enabled, parameters are assigned to global
	variables of the same name. In this case, the value of a field named id is available
	as the variable $id, regardless of whether the request was sent via get or post. It’s
	dangerous to rely on this variable, for reasons described shortly. PHP scripts in this
	book do not rely on register_globals (which in any case is deprecated in PHP
	5.3 and removed in 5.4). Instead, they obtain input through the global parameter
	arrays.
*/
