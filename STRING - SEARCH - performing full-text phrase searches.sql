/*

!!WORKING WITH STRINGS - PERFORMING FULL-TEXT PHRASE SEARCHES!!

> You want to perform a full-text search for a phrase; that is, for words that occur adjacent
to each other and in a specific order

> Use the full-text phrase-search capability

*/

/*
> Use full-text Boolean mode, which supports phrase searching. 
	>> Enclose the phrase in double quotes within the search string
*/
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('"still small voice"' IN BOOLEAN MODE);