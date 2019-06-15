/*

!!VALIDATING & REFORMATING DATA - USING PATTERNS TO MATCH EMAIL ADDRESSES OR URLs!!

> You want to determine whether a value looks like an email address or a URL

> Use a pattern, tuned to the desired level of strictness

*/

/*
1) To check values that are expected to be email addresses, the pattern should require at
least an @ character with nonempty strings on either side

2) In addition to being nonempty, the username and the domain name should consist entirely 
of characters other than @ characters or spaces

3) You may also want to require that the domain name part contain at least two parts
separated by a dot

4) To look for URL values that begin with a protocol specifier of http://, ftp://, or
mailto
*/
1)
/.@./

2)
/^[^@ ]+@[^@ ]+$/

3)
/^[^@ ]+@[^@ .]+\.[^@ .]+/

4)
m#^(http://|ftp://|mailto:)#i