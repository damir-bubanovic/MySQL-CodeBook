/*

!!VALIDATING & REFORMATING DATA - USING PATTERNS TO MATCH NUMERIC VALUES!!

> You must make sure a string looks like a number

> Use a pattern that matches the type of number you’re looking for

*/

/*
> Patterns can be used to classify values into several types of numbers, as shown in the
following table:

Pattern 							Type of value the pattern matches
/^\d+$/ 							Unsigned integer
/^-?\d+$/ 							Negative or unsigned integer
/^[-+]?\d+$/ 						Signed or unsigned integer
/^[-+]?(\d+(\.\d*)?|\.\d+)$/ 		Floating-point number
*/

/*
> ZIP codes

Pattern 			Type of value the pattern matches
/^\d{5}$/ 			ZIP code, five digits only
/^\d{5}-\d{4}$/ 	ZIP+4 code
/^\d{5}(-\d{4})?$/ 	ZIP or ZIP+4 code
*/

/*
> Credit card numbers

> To match such values, use this pattern:
/^[- \d]+/
*/