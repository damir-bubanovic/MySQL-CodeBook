/*

!!PROCESSING WEB INPUT WITH MySQL - WRITING SCRIPTS THAT GENERATE WEB FORMS!!

> You want to write a script that gathers input from a user

> Create a form within your script and send it to the user. The script can arrange to have
itself invoked again to process the form’s contents when the user fills it in and submits
it.

*/

/*
> Web forms are a convenient way to enable your visitors to submit information such as
a set of search keywords, a completed survey result, or a response to a questionnaire

> Most of the form-based web scripts shown in this chapter share some common behaviors:
	• When first invoked, the script generates a form and sends it to the user to be filled
	in.
	• The action attribute of the form points back to the same script. When the user
	completes the form and submits it, the web server invokes the script again to process
	the form’s contents.
	• The script checks its execution environment to see what input parameters are
	present. For the initial invocation, the environment contains none of the parameters
	named in the form. This enables the script to determine whether it’s being invoked
	by a user for the first time or whether it should process a submitted form.
*/

/*
> PHP scripts access the script pathname as the PHP_SELF member of the $_SERVER array,
which is a “superglobal” array (accessible in any scope without being declared as global).
1) Scripts can obtain their own pathname and use it to generate a form as follows
*/
1)
print ('<form action="' . $_SERVER['PHP_SELF'] . '" method="post">');
# ... generate form elements here ...
print ('</form>');