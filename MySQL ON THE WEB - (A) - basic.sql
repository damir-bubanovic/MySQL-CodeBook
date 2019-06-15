/*

!!MySQL ON THE WEB - BASIC!!

> Dynamic content is created on demand. Rather than opening a file and serving its contents 
directly to the client, the web server executes a script that generates the page and sends 
the resulting output. 
	>> npr. a script can process a keyword request and return a page that lists items in a 
	catalog that match the keyword

*/

/*
The topics covered here include:
	• How web scripting differs from writing static HTML documents or scripts intended
	to be executed from the command line.
	• Prerequisites for running web scripts. In particular, you must have a web server
	installed and it must be set up to recognize your scripts as programs to be executed,
	rather than as static files to be served without change over the network.
	• How to use each of our API languages to write a short web script that queries the
	MySQL server and displays the results in a web page.
	• How to properly encode output. HTML consists of text to be displayed interspersed
	with special markup constructs. If the text contains special characters, you must
	encode them to avoid generating malformed web pages. Each API provides a way
	to do this.
*/