/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING EVENTS TO SCHEDULE DATABASE ACTIONS!!

> You want to set up a database operation that runs periodically without user intervention

> Create an event that executes according to a schedule

*/

/*
EXAMPLE:
> Simple event that writes a row to a table at regular intervals

1) Begin with a table to hold the mark rows. It contains a TIMESTAMP column (which MySQL
will initialize automatically) and a column to store a message

2) Our logging event will write a string to a new row. To set it up, use a CREATE EVENT
statement

3) If this is the first event that you’ve set up, you might find that the table remains 
empty no matter how long you wait

4) If that’s the case, very likely the event scheduler isn’t running (which is its default state
until you enable it). Check the scheduler status by examining the value of the
event_scheduler system variable

5) To enable the scheduler interactively if it’s not running, execute the following statement
(which requires the SUPER privilege)

6) That statement enables the scheduler, but only until the server shuts down. To start the
scheduler each time the server starts, enable the system variable in your my.cnf option
file

> For an event body that executes multiple statements, use BEGIN … END compound-statement 
syntax
*/
1)
CREATE TABLE mark_log
(
ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
message VARCHAR(100)
);

2)
CREATE EVENT mark_insert
ON SCHEDULE EVERY 5 MINUTE
DO INSERT INTO mark_log (message) VALUES('-- MARK --');

3)
mysql> SELECT * FROM mark_log;
Empty set (0.00 sec)

4)
mysql> SHOW VARIABLES LIKE 'event_scheduler';

5)
SET GLOBAL event_scheduler = 1;

6)
[mysqld]
event_scheduler=1


/*
> There are several ways that you can affect event execution to prevent
the table from growing forever

1) Drop the event
	>> This is the simplest way to stop an event from occurring. 
	>> But if you want it to resume later, you must re-create it
	
2) Disable event execution
	>> That leaves the event in place but causes it not to run until you reactivate it
	
3) Let the event continue to run, but set up another event that “expires” old mark_log
rows. This second event need not run so frequently (perhaps once a day). Its body
should remove rows older than a given threshold. 
	>> The following definition creates an event that deletes rows that are more than 
	two days old
*/
1)
DROP EVENT mark_insert;

2)
ALTER EVENT mark_insert DISABLE

3)
CREATE EVENT mark_expire
ON SCHEDULE EVERY 1 DAY
DO DELETE FROM mark_log WHERE ts < NOW() - INTERVAL 2 DAY;
