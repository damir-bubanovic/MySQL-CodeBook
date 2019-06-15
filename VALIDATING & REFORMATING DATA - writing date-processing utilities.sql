/*

!!VALIDATING & REFORMATING DATA - WRITING DATE-PROCESSING UTILITIES!!

> There’s a date-processing operation that you must perform frequently
	> You want to write a utility that does it for you
	
> The utilities in this recipe provide some examples that show how to do that

*/

/*
>Due to the idiosyncratic nature of dates, you might occasionally find it necessary to
write date converters. 
	>> Exsample converters that serve various purposes:
		• isoize_date.pl reads a file looking for dates in US format (MM-DD-YY) and converts
		them to ISO format.
		• cvt_date.pl converts dates to and from any of ISO, US, or British formats. It is more
		general than isoize_date.pl, but requires that you tell it what kind of input to expect
		and what kind of output to produce
		• monddccyy_to_iso.pl looks for dates like Feb. 6, 1788 and converts them to ISO
		format. It illustrates how to map dates with nonnumeric parts to a format that
		MySQL understands.
		
1) isoize_date.pl, looks for dates in US format and rewrites them into ISO format
	>> isoize_date.pl serves a specific purpose: it converts only from US to ISO format. 
	>> It does not perform validity checking on date subparts or permit the transition point 
	for adding the century to be specified
	
2) cvt_date.pl, extends the capabilities of isoize_date.pl; it recognizes input dates in ISO,
US, or British formats and converts any of them to any other. 
	> It also can convert twodigit years to four digits, enable you to specify the conversion 
	transition point, and warn about bad dates
*/


/*
> cvt_date.pl understands the following options:
	--iformat=format, --oformat=format, --format=format
		Set the date format for input, output, or both. The default format value is iso;
		cvt_date.pl also recognizes any string beginning with us or br as indicating US or
		British date format.
		
	--add-century
		Convert two-digit years to four digits.
		
	--columns=column_list
		Convert dates only in the named columns. By default, cvt_date.pl looks for dates in
		all columns. If this option is given, column_list should be a list of one or more
		column positions or ranges separated by commas. (Ranges can be given as m-n to
		specify columns m through n.) Positions begin at 1.
		
	--transition=n
		Specify the transition point for two-digit to four-digit year conversions. The default
		transition point is 70. This option turns on --add-century.
	--warn
		Warn about bad dates. (This option can produce spurious warnings if the dates
		have two-digit years and you don’t specify --add-century, because leap-year testing
		won’t always be accurate in that case.)
*/
