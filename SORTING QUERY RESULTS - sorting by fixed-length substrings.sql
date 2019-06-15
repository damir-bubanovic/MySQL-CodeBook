/*

!!SORTING QUERY RESULTS - SORTING BY FIXED-LENGTH SUBSTRINGS!!

> You want to sort using parts of a column that occur at a given position within the column

> Pull out the parts you need with LEFT(), MID(), or RIGHT(), and sort them

*/

/*
> Suppose that a housewares table catalogs houseware furnishings, each identified by 10-
character ID values consisting of three subparts: a three-character category abbreviation
(such as DIN for “dining room” or KIT for “kitchen”), a five-digit serial number, and a
two-character country code indicating where the part is manufactured

EXAMPLE:
1) To sort rows from this table based on the id values, use the entire column value

> But you might also have a need to sort on any of the three subparts
2) functions such as LEFT(), MID(), and RIGHT() are useful to extract id value components

3) To sort by product category, extract and use the category in the ORDER BY clause

4) To sort by product serial number, use MID() to extract the middle five characters from
the id values, beginning with the fourth

5) To sort by country code, use the rightmost two characters of the id values
*/
1)
mysql> SELECT * FROM housewares ORDER BY id;

2)
mysql> SELECT id,
	-> LEFT(id,3) AS category,
	-> MID(id,4,5) AS serial,
	-> RIGHT(id,2) AS country
	-> FROM housewares;
	
3)
mysql> SELECT * FROM housewares ORDER BY LEFT(id,3);

4)
mysql> SELECT * FROM housewares ORDER BY MID(id,4,5);

5)
mysql> SELECT * FROM housewares ORDER BY RIGHT(id,2), MID(id,4,5);