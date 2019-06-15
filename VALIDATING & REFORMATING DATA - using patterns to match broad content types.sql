/*

!!VALIDATING & REFORMATING DATA - USING PATTERNS TO MATCH BROAD CONTENT TYPES!!

> You want to classify values into broad categories

> Use a pattern that is similarly broad

*/

/*
> To check whether values are empty or nonempty, or consist only of certain types of
characters, the patterns listed in the following table may suffice

Pattern 		Type of value the pattern matches
/^$/ 			Empty value
/./ 			Nonempty value
/^\s*$/ 		Whitespace, possibly empty
/^\s+$/ 		Nonempty whitespace
/\S/ 			Nonempty, and not only whitespace
/^\d+$/ 		Digits only, nonempty
/^[a-z]+$/i 	Alphabetic characters only (case insensitive), nonempty
/^\w+$/ 		Alphanumeric or underscore characters only, nonempty
*/