/*

!!PROCESSING WEB INPUT WITH MySQL - WEB PAGE ACCESS COUNTING!!

> You want to count the number of times web pages have been accessed

> Implement a hit counter, keyed to the page to be counted. 
	>> This can be used to display a counter in the page. 
	>> Use the same technique to record other types of information as well, 
	such as the number of times each of a set of banner ads has been served

*/

/*
USEFULL
> If you display banner ads in your pages, you likely charge vendors by the number of 
times you serve their ads. To do so, you must count the number of accesses for each

There are several methods for writing a page that displays a count of the number of
times it has been accessed:

	*+) The most basic is to maintain the count in a file
		>>> For each page request, open the file, read the count, increment it, 
		write the new count to the file, and display it in the page
		(Use MYSQL to remove problems that arise)
	
	*+) Assume that you want to log hits for more than one page. To do that, create a table 
	that has one row for each page to be counted. This necessitates a unique identifier 
	for each page, so that counters for different pages don’t get mixed up
	
+) Create a hitcount table as follows

1) MySQL provides a solution that enables each client to retrieve its own count, no matter 
how many simultaneous updates occur

2) An easier approach is to use MySQL’s INSERT … ON DUPLICATE KEY UPDATE syntax to insert 
a row with a count of 1 if it does not exist, and update its counter if it does exist

3) If your API provides a means for direct retrieval of the most recent sequence number,
a further efficiency is gained by eliminating the SELECT statement altogether (Look up in PHP)
*/
+)
CREATE TABLE hitcount
(
path VARCHAR(255)
CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
hits BIGINT UNSIGNED NOT NULL,
PRIMARY KEY (path)
);

1)
UPDATE hitcount SET hits = LAST_INSERT_ID(hits+1) WHERE path = 'page path';
SELECT LAST_INSERT_ID();

2)
INSERT INTO hitcount (path,hits) VALUES('some path',LAST_INSERT_ID(1))
ON DUPLICATE KEY UPDATE hits = LAST_INSERT_ID(hits+1);
SELECT LAST_INSERT_ID();
