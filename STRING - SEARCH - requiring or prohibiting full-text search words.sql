/*

!!WORKING WITH STRINGS - REQUIRING OR PROHIBITING FULL-TEXT SEARCH WORDS!!

> You want to require or prohibit specific words in a full-text search

> Use a Boolean mode search

*/

/*
> Normally, full-text searches return rows that contain any of the words in the search
string, even if some of them are missing

EXAMPLE:
1) rows that contain either of the names David or Goliath

> This behavior is undesirable if you want only rows that contain both words. 
2) One way to do this is to rewrite the statement to look for each word separately 
and join the conditions with AND

> An easier way to require multiple words is with a Boolean mode search. 
3) precede each word in the search string with a + character and add IN BOOLEAN MODE after
the string

> Boolean mode searches also permit you to exclude words by preceding each one with
a - character. 
4) select kjv rows containing the name David but not Goliath, and vice versa

> Another useful special character in Boolean searches is *; when appended to a search
word, it acts as a wildcard operator. 
5) find rows containing not only whirl, but also words such as whirls, whirleth, and whirlwind
*/
1)
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('David Goliath');

2)
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('David')
	-> AND MATCH(vtext) AGAINST('Goliath');

3) 
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('+David +Goliath' IN BOOLEAN MODE);

4)
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('+David -Goliath' IN BOOLEAN MODE);
	
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('-David +Goliath' IN BOOLEAN MODE);
	
5)
mysql> SELECT COUNT(*) FROM kjv
	-> WHERE MATCH(vtext) AGAINST('whirl*' IN BOOLEAN MODE);	
