/*

!!WORKING WITH STRINGS - USING FULL-TEXT SEARCH WITH SHORT WORDS!!

> Full-text searches for short words return no rows

> Change the indexing engine’s minimum word length parameter

*/

/*
EXPLANATION:
+) certain words in Bible (our example) have special significance, such as “God” and “sin.”
and are repeated a lot
	> One property of the indexing engine is that it ignores words that are “too common”
	
+) MyISAM full-text indexing engine doesn’t include words less than four characters long. 
	> The minimum word length is a configurable parameter; to change it, set the 
	ft_min_word_len system variable
		>> 1) npr. include words as short as three characters, add a line to the [mysqld] group of 
		the /etc/my.cnf file
	> After making this change, restart the server. 
	> 2) Next, rebuild the FULLTEXT index to take advantage of the new setting
	> 3) try the new index to verify that it includes shorter words
	

*/
1)
[mysqld]
ft_min_word_len=3

2)
mysql> REPAIR TABLE kjv QUICK;

3)
mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('God');

mysql> SELECT COUNT(*) FROM kjv WHERE MATCH(vtext) AGAINST('sin');