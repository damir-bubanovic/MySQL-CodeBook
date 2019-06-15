/*

!!VALIDATING & REFORMATING DATA - CONVERTING TWO-DIGIT YEAR VALUES TO FOUR-DIGIT FORM!!

> You must convert years in date values from two digits to four digits

> Let MySQL do this for you, or perform the operation yourself if MySQL’s conversion
rules aren’t appropriate

*/

/*
> Two-digit year values are a problem because the century is not explicit in the data values.
	>> If you know the range of years spanned by your input, you can add the century without 
	ambiguity
	
> One way to convert years to four digits is to let MySQL do it. If you store a date containing
a two-digit year, MySQL automatically converts it to four-digit form. 
	>> MySQL uses a transition point of 1970; it interprets values from 00 to 69 as the 
	years 2000 to 2069, and values from 70 to 99 as the years 1970 to 1999
> To use a different transition point, convert years to four-digit form yourself
*/