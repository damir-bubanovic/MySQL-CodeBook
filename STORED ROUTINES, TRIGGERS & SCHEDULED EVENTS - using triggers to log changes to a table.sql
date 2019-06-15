/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING TRIGGERS TO LOG CHANGES TO A TABLE!!

> You have a table that maintains current values of items that you track (such as auctions
being bid on), but you’d also like to maintain a journal (history) of changes to the table

> Use triggers to “catch” table changes and write them to a separate log table

*/

/*
1) Suppose that you conduct online auctions, and that you maintain information about
each currently active auction in a table that looks like this

> To maintain a journal that shows all changes to auctions as they progress from creation
to removal, set up another table that serves to record a history of changes to the auctions.
> This strategy can be implemented with triggers

2) To maintain a history of how each auction progresses, use an auction_log table with
the following columns


> The auction_log table differs from the auction table in two ways:
	• It contains an action column to indicate for each row what kind of change was
	made.
	• The id column has a nonunique index (rather than a primary key, which requires
	unique values). This permits multiple rows per id value because a given auction
	can generate many rows in the log table.
> To ensure that changes to the auction table are logged to the auction_log table, create
a set of triggers. The triggers write information to the auction_log table as follows:
	• For inserts, log a row-creation operation showing the values in the new row.
	• For updates, log a row-update operation showing the new values in the updated
	row.
	• For deletes, log a row-removal operation showing the values in the deleted row.
	
3) For this application, AFTER triggers are used because they activate only after successful
changes to the auction table
*/
1)
CREATE TABLE auction
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
item VARCHAR(30) NOT NULL,
bid DECIMAL(10,2) NOT NULL,
PRIMARY KEY (id)
);

2)
CREATE TABLE auction_log
(
action ENUM('create','update','delete'),
id INT UNSIGNED NOT NULL,
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
item VARCHAR(30) NOT NULL,
bid DECIMAL(10,2) NOT NULL,
INDEX (id)
);

3)
CREATE TRIGGER ai_auction AFTER INSERT ON auction
FOR EACH ROW
INSERT INTO auction_log (action,id,ts,item,bid)
VALUES('create',NEW.id,NOW(),NEW.item,NEW.bid);

CREATE TRIGGER au_auction AFTER UPDATE ON auction
FOR EACH ROW
INSERT INTO auction_log (action,id,ts,item,bid)
VALUES('update',NEW.id,NOW(),NEW.item,NEW.bid);

CREATE TRIGGER ad_auction AFTER DELETE ON auction
FOR EACH ROW
INSERT INTO auction_log (action,id,ts,item,bid)
VALUES('delete',OLD.id,OLD.ts,OLD.item,OLD.bid);


/*
1) Suppose that an auction is created with an initial bid of five dollars

2) The SELECT statement fetches the auction ID value to use for subsequent actions on the
auction. Then the item receives three more bids before the auction ends and is removed

3) At this point, no trace of the auction remains in the auction table, but the auc
tion_log table contains a complete history of what occurred
*/
1)
mysql> INSERT INTO auction (item,bid) VALUES('chintz pillows',5.00);
mysql> SELECT LAST_INSERT_ID();

2)
mysql> UPDATE auction SET bid = 7.50 WHERE id = 792;
... time passes ...
mysql> UPDATE auction SET bid = 9.00 WHERE id = 792;
... time passes ...
mysql> UPDATE auction SET bid = 10.00 WHERE id = 792;
... time passes ...
mysql> DELETE FROM auction WHERE id = 792;

3)
mysql> SELECT * FROM auction_log WHERE id = 792 ORDER BY ts;
