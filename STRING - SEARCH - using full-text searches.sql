/*

!!WORKING WITH STRINGS - USING FULL-TEXT SEARCHES!!

> You want to search a lot of text

> Use a FULLTEXT index

*/

/*
> Pattern matches enable you to look through any number of rows, but as the amount of
text goes up, the match operation can become quite slow. 
> It’s also a common task to search for the same text in several string columns, 
but with pattern matching, that results in unwieldy queries

> A useful alternative is full-text searching, which is designed for looking through large
amounts of text and can search multiple columns simultaneously. 
	>> To use this capability, add a FULLTEXT index to your table, and then use the MATCH 
	operator to look for strings in the indexed column or columns
*/

/*
EXAMPLE:
> searching the Bible
	>> TAble (Bible)

1) How many times does the name Hadoram occur?

2) To find out what those verses are, select the columns you want to see

3) To make sure a search result is sorted the way you want, 
add an explicit ORDER BY clause

4) To narrow the search further, include additional criteria
	> The following queries perform progressively more specific searches to determine how 
	often the name Abraham occurs in the entire KJV, the New Testament, the Book of Hebrews, 
	and Chapter 11 of Hebrews
*/
CREATE TABLE kjv
(
bsect ENUM('O','N') NOT NULL, # book section (testament)
bname VARCHAR(20) NOT NULL, # book name
bnum TINYINT UNSIGNED NOT NULL, # book number
cnum TINYINT UNSIGNED NOT NULL, # chapter number
vnum TINYINT UNSIGNED NOT NULL, # verse number
vtext TEXT NOT NULL, # text of verse
FULLTEXT (vtext) # full-text index
) ENGINE = MyISAM; # can be InnoDB for MySQL 5.6+

1)
mysql> SELECT COUNT(*) from kjv WHERE MATCH(vtext) AGAINST('Hadoram');

2)
mysql> SELECT bname, cnum, vnum, LEFT(vtext,65) AS vtext
	-> FROM kjv WHERE MATCH(vtext) AGAINST('Hadoram')\G
	
3)
SELECT bname, cnum, vnum, vtext
FROM kjv WHERE MATCH(vtext) AGAINST('search string')
ORDER BY bnum, cnum, vnum;

4)
mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham');

mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham')
	-> AND bsect = 'N';

mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham')
	-> AND bname = 'Hebrews';

mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham')
	-> AND bname = 'Hebrews' AND cnum = 11;


/*
> If you expect to use search criteria frequently that include other non-FULLTEXT columns,
add regular indexes to those columns so that queries perform better. npr:
1) to index the book, chapter, and verse columns, do this

> Search strings in full-text queries can include more than one word, and you might
suppose that adding words would make a search more specific
2) identify successively larger numbers of verses as additional search words are added

3) To use full-text searches that look through multiple columns simultaneously, name all
the columns when you construct the FULLTEXT index

4) To issue a search query that uses the index, name those same columns in the MATCH()
list
*/
1)
mysql> ALTER TABLE kjv ADD INDEX (bnum), ADD INDEX (cnum), ADD INDEX (vnum);

2)
mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham');

mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham Sarah');
	
mysql> SELECT COUNT(*) from kjv
	-> WHERE MATCH(vtext) AGAINST('Abraham Sarah Ishmael Isaac');

3) 
ALTER TABLE tbl_name ADD FULLTEXT (col1, col2, col3);

4)
SELECT ... FROM tbl_name
WHERE MATCH(col1, col2, col3) AGAINST('search string');
