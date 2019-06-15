/*

!!VALIDATING & REFORMATING DATA - USING PATTERNS TO MATCH DATES OR TIMES!!

> You must make sure a string looks like a date or time

> Use a pattern that matches the type of temporal value you expect. 
	>> Be sure to consider issues such as how strict to be about delimiters 
	between subparts and the lengths of the subparts

*/

/*
1) To require values to be dates in ISO (CCYY-MM-DD) format, use this pattern

2) The pattern requires the - character as the delimiter between date parts. 
> To permit either - or / as the delimiter, use a character class between the 
numeric parts

3) To avoid the backslashes, use a different delimiter around the pattern

4) To permit any nondigit delimiter 
	(which corresponds to how MySQL operates when it interprets strings as dates)
	
5) To permit leading zeros in values like 03 to be missing, just look for three 
nonempty digit sequences

6) To constrain the subpart lengths by requiring two to four digits in the year 
part and one or two digits in the month and day parts, use this pattern

7) For dates in other formats such as MM-DD-YY or DD-MM-YY, similar patterns apply, but
the subparts are arranged in a different order. 
	> This pattern matches both of those formats
	
8) To check the values of individual date parts, use parentheses in the pattern and extract
the substrings after a successful match. 
	> If you expect dates to be in ISO format, for example, do this
	
> You’ll often find additional processing necessary with dates because date-matching patterns
help to weed out values that are syntactically malformed, but don’t assess whether the individual 
components contain legal values
*/
1)
/^\d{4}-\d{2}-\d{2}$/

2)
/^\d{4}[-\/]\d{2}[-\/]\d{2}$/

3)
m|^\d{4}[-/]\d{2}[-/]\d{2}$|

4)
/^\d{4}\D\d{2}\D\d{2}$/

5)
/^\d+\D\d+\D\d+$/

6)
/^\d{2,4}?\D\d{1,2}\D\d{1,2}$/

7)
/^\d{2}-\d{2}-\d{2}$/

8)
if ($val =~ /^(\d{2,4})\D(\d{1,2})\D(\d{1,2})$/) {
	($year, $month, $day) = ($1, $2, $3);
}


/*
1) Rewrite values assumed to be in MM-DD-YY format into YYMM-DD format, do this

2) Time values are somewhat more orderly than dates, usually being written with hours
first and seconds last, with two digits per part

3) To be more lenient, permit the hours part to have a single digit, or the seconds 
part to be missing
*/
1)
$val =~ s/^(\d+)\D(\d+)\D(\d+)$/$3-$1-$2/;

2)
/^\d{2}:\d{2}:\d{2}$/

3)
/^\d{1,2}:\d{2}(:\d{2})?$/


/*
> Date and time testing and conversion can be highly idiosyncratic,
and the sheer number of issues to consider is mind-boggling:

	• What is the basic date format? Dates come in several common styles, such as ISO
	(CCYY-MM-DD), US (MM-DD-YY), and British (DD-MM-YY) formats 
	
	• Are trailing times permitted on dates, or perhaps required? 
		> When times are expected, is the full time required or just the hour and minute?
		
	• Do you permit special values like now or today?
	
	• Are date parts required to be delimited by a particular character, such as - or /, or
	are other delimiters permitted?
	
	• Are date parts required to have a specific number of digits? Or are leading zeros 
	on month and year values permitted to be missing?
	
	• Are months written numerically, or represented as month names like January or
	Jan?
	
	• Are two-digit year values permitted? Should they be converted to have four digits?
	If so, what is the transition point within the range 00 to 99 at which values change
	from one century to another?
	
	• Should date parts be checked to ensure their validity? Patterns can recognize strings
	that look like dates or times, but while they’re extremely useful for detecting malformed
	values, they may not be sufficient. 
		> A value like 1947-15-99 may match a pattern but isn’t a legal date. 
		> Pattern testing is thus most useful in conjunction with range checks on the 
		individual parts of the date.
*/





