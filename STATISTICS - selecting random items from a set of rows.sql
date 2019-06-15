/*

!!STATISTICS - SELECTING RANDOM ITEMS FROM A SET OF ROWS!!

> You want to pick an item or items randomly from a set of values

> Randomize the values, then pick the first one (or the first few, if you need more than
one)

*/

/*
> If a set of items is stored in MySQL, choose one at random as follows:
	1. Select the items in the set in random order, using ORDER BY RAND() as described earlier
	2. Add LIMIT 1 to the query to pick the first item
	
EXAMPLE:
1) Perform a simple simulation of tossing a die, create a die table containing
rows with values from 1 to 6 corresponding to the six faces of a die cube

2) Then pick rows from the table at random

3) To pick more than one item, change the LIMIT argument

4) Pick a random number in that range and select the matching row
*/
1)
CREATE TABLE die (n INT);

2)
mysql> SELECT n FROM die ORDER BY RAND() LIMIT 1;

mysql> SELECT n FROM die ORDER BY RAND() LIMIT 1;

mysql> SELECT n FROM die ORDER BY RAND() LIMIT 1;

mysql> SELECT n FROM die ORDER BY RAND() LIMIT 1;

3)
SELECT * FROM drawing ORDER BY RAND() LIMIT 5;

4)
SET @id = FLOOR(RAND()*n)+1;
SELECT ... FROM tbl_name WHERE id = @id;


/*
> Other examples of selection with replacement include
	• Selecting a banner ad to display on a web page
	• Picking a row for a “quote of the day” application
	• “Pick a card, any card” magic tricks that begin with a full deck of cards each time
*/
