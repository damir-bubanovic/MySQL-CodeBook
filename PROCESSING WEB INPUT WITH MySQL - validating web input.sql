/*

!!PROCESSING WEB INPUT WITH MySQL - VALIDATING WEB INPUT!!

> After extracting the parameters supplied to a script, you want to check them to be sure
they’re valid

> Web input processing is one form of data import, so after you’ve extracted the input
parameters, validate them using the techniques learned earlier

*/

/*
> One phase of web form processing is extracting the input returned when the user submits
the form. It’s also possible to receive input in the form of parameters at the end of
a URL. Either way, if you plan to store the input in your database, it’s important to check
it to be sure that it’s valid

> Typical validation operations include the following:
	• Checking content format, such as making sure a value looks like an integer or a
	date. This may involve some reformatting for acceptability to MySQL (for example,
	changing a date from MM/DD/YY to ISO format).
	• Determining whether a value is a member of a legal set of values. Perhaps the value
	must be listed in the definition for an ENUM or SET column, or must be present in a
	lookup table.
	• Filtering out extraneous characters such as spaces or dashes from telephone numbers
	or credit card numbers
*/