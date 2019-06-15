/*

!!STATISTICS - RANDOMIZING A SET OF ROWS!!

> You want to randomize a set of rows or values

> Use ORDER BY RAND()

*/

/*
> MySQL’s RAND() function can be used to randomize the order in which a query returns
its rows. 
	>> this randomization is achieved by adding an ORDER BY clause to the query
	
	- Suppose that a spreadsheet contains this set of values
	- To place these in random order, first add another column that contains randomly 
	chosen numbers
	- Then sort the rows according to the values of the random numbers
	
EXAMPLE:
1) In MySQL, achieve a similar effect by associating a set of random numbers with a query
result and sorting the result by those numbers. To do this, add an ORDER BY RAND() clause
*/
1)
mysql> SELECT name FROM t ORDER BY RAND();

mysql> SELECT name FROM t ORDER BY RAND();


/*
> Applications for randomizing a set of rows include any scenario that uses selection
without replacement
	• Determining the starting order for participants in an event. List the participants in
	a table, and select them in random order.
	• Assigning starting lanes or gates to participants in a race. List the lanes in a table,
	and select a random lane order.
	• Choosing the order in which to present a set of quiz questions.
	• Shuffling a deck of cards. Represent each card by a row in a table, and shuffle the
	deck by selecting the rows in random order. Deal them one by one until the deck
	is exhausted.
	
> let’s implement a card deck-shuffling algorithm
	>> table named deck that has 52 rows, assuming a set of cards with each combination of 13 
	face values and 4 suits
	
	1. Select the entire table, and store it into an array.
	2. Each time a card is needed, take the next element from the array.
	3. When the array is exhausted, all the cards have been dealt. “Reshuffle” the table to
	generate a new card order.
	
EXAMPLE:
1) PHP code that creates a deck table with face and suit columns, then populates the table 
using nested loops to generate the pairings for the INSERT statements

2) Shuffling the cards is a matter of issuing this statement

3) To do that and store the results in an array within a script, write a shuffle_deck()
function that issues the query and returns the resulting values in an array (again shown
in PHP)
*/
1)
$sth = $dbh->exec ("DROP TABLE IF EXISTS deck");

$sth = $dbh->exec ("CREATE TABLE deck (face ENUM('A', 'K', 'Q', 'J', '10', '9', '8','7', '6', '5', '4', '3', '2') NOT NULL,
					suit ENUM('hearts', 'diamonds', 'clubs', 'spades') NOT NULL) ");
					
$face_array = array ("A", "K", "Q", "J", "10", "9", "8", "7", "6", "5", "4", "3", "2");
$suit_array = array ("hearts", "diamonds", "clubs", "spades");

# insert a "card" into the deck for each combination of suit and face
$sth = $dbh->prepare ("INSERT INTO deck (face,suit) VALUES(?,?)");
foreach ($face_array as $face)
foreach ($suit_array as $suit)
$sth->execute (array ($face, $suit));

2)
SELECT face, suit FROM deck ORDER BY RAND();

3)
function shuffle_deck ($dbh) {
	$sth = $dbh->query ("SELECT face, suit FROM deck ORDER BY RAND()");
	$sth->setFetchMode (PDO::FETCH_OBJ);
	return ($sth->fetchAll ());
}
