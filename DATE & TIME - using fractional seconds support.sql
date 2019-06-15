/*

!!DATE & TIME - USING FRACTIONAL SECONDS SUPPORT!!

> fractional seconds are supported for temporal types that include a
time part: DATETIME, TIME, and TIMESTAMP
	>> his enables you to specify fractional seconds precision down to 
	the microsecond level

*/

/*
Event 		Resolution Data type
Biathlon 	Tenths TIME(1)
Downhill 	skiing Hundredths TIME(2)
Luge, 		skeleton Thousandths TIME(3)
*/

/*
EXAMPLE:
1) create a TIME column with two fractional digits (resolution to hundredths of seconds)

2) Temporal functions that return current time or date-and-time values also support fractional
seconds
*/
1)
mycol TIME(2)

2)
mysql> SELECT CURTIME(), CURTIME(2), CURTIME(6);