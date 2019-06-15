/*

!!VALIDATING & REFORMATING DATA - PERFORMING VALIDITY CHECKING ON DATE OR TIME SUBPARTS!!

> A string passes a pattern test as a date or time, but you want to perform further validity
checking

> Break the value into parts and perform the appropriate range checking on each part

*/

/*
> Combine pattern matching with range checking. 
	>> Break out the year, month, and day values, then check whether each is within the proper range. 
	>> Years should be less than 9999 (MySQL represents dates to an upper limit of 9999-12-31),
	month values must be in the range from 1 to 12, and days must be in the range from 1 to the number 
	of days in the month. 
	>> That last part is the trickiest: it’s month-dependent, and also year-dependent for February 
	because it changes for leap years
*/