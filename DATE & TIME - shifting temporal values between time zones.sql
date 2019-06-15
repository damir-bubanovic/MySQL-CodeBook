/*

!!DATE & TIME - SHIFTING TEMPORAL VALUES BETWEEN TIME ZONES!!

> You have a date-and-time value, but need to know what it would be in a different time
zone. 
	>> npr. you’re having a teleconference with people in different parts of the world 
	and you must tell them the meeting time in their local time zones

> Use the CONVERT_TZ() function	
	
*/

/*
> Suppose that I live in Chicago, Illinois in the US, and that I have a meeting with people
in several other parts of the world. 
	>> The following table shows the location of each meeting participant and the time zone 
	name for each

Location 				Time zone name
Chicago, Illinois, 		US US/Central
Berlin, Germany 		Europe/Berlin
London, United Kingdom 	Europe/London
Edmonton, Alberta, 		Canada America/Edmonton
Brisbane, Australia 	Australia/Brisbane
*/

/*
EXAMPLE:
1) If the meeting is to take place at 9 AM local time for me on November 23, 2014, what
time will that be for the other participants? The following statement uses CON
VERT_TZ() to calculate the local times for each time zone

2) If you can’t use named time zones, specify them in terms of their numeric relationship to UTC.
(This can be a little trickier; you might need to account for daylight saving time.) The
corresponding statement with numeric time zones looks like this
*/
1)
mysql> SET @dt = '2014-11-23 09:00:00';
mysql> SELECT @dt AS Chicago,
	-> CONVERT_TZ(@dt,'US/Central','Europe/Berlin') AS Berlin,
	-> CONVERT_TZ(@dt,'US/Central','Europe/London') AS London,
	-> CONVERT_TZ(@dt,'US/Central','America/Edmonton') AS Edmonton,
	-> CONVERT_TZ(@dt,'US/Central','Australia/Brisbane') AS Brisbane\G
	
2)
mysql> SELECT @dt AS Chicago,
	-> CONVERT_TZ(@dt,'-06:00','+01:00') AS Berlin,
	-> CONVERT_TZ(@dt,'-06:00','+00:00') AS London,
	-> CONVERT_TZ(@dt,'-06:00','-07:00') AS Edmonton,
	-> CONVERT_TZ(@dt,'-06:00','+10:00') AS Brisbane\G