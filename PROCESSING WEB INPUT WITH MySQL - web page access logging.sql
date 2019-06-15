/*

!!PROCESSING WEB INPUT WITH MySQL - WEB PAGE ACCESS LOGGING!!

> You want to know things about a page other than the number of times it’s been accessed,
such as when accesses occur and the hosts from which requests originate

> Maintain a hit log rather than a simple counter

*/

/*
EXAMPLE:
1) You must log a row for each page access rather than maintain only a count

> The hitlog table has the useful property that access times are recorded automatically
in the TIMESTAMP column t when you insert new rows
2) To insert new rows into the hitlog table, use this statement


> Although the hitlog table doesn’t maintain page-access counts, you can determine
them easily
3) To determine the number of hits for a given page, use this statement

4) To determine the current counter value for all pages and retrieve them in order with
the most-requested pages first
*/
1)
CREATE TABLE hitlog
(
path VARCHAR(255)
CHARACTER SET latin1 COLLATE latin1_general_cs NOT NULL,
t TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
host VARCHAR(255),
INDEX (path)
);

2)
INSERT INTO hitlog (path, host) VALUES(path_val,host_val);


3)
SELECT COUNT(*) FROM hitlog WHERE path = 'path_name';

4) 
SELECT path, COUNT(*) FROM hitlog GROUP BY path ORDER BY COUNT(*) DESC;