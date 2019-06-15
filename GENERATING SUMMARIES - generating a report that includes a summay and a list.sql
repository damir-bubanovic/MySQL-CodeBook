/*

!!GENERATING SUMMARIES - GENERATING A REPORT THAT INCLUDES A SUMMARY AND A LIST!!

> You want to create a report that displays a summary, together with the list of rows
associated with each summary value

> Use two statements that retrieve different levels of summary information. 
> Or use a programming language to do some of the work so that you can use a single 
statement

*/

/*
> Suppose that you want to produce a report that looks like this

> For each driver in the driver_log table, the report shows the following information:
	• A summary line showing the driver name, the number of days on the road, and the
	number of miles driven.
	• A list that details dates and mileages for the individual trips from which the summary
	values are calculated.
	
> This kind of problem appears in many other forms:
	• You have a database that lists contributions to candidates in your political party.
	The party chair requests a printout that shows, for each candidate, the number of
	contributions and total amount contributed, as well as a list of contributor names
	and addresses.
	• You want to create a handout for a company presentation that summarizes total
	sales per sales region with a list under each region showing the sales for each state
	in the region.
	
> Such problems have multiple solutions:
	• Run separate statements to get the information for each level of detail that you
	require. (A single query won’t produce per-group summary values and a list of each
	group’s individual rows.)
	• Fetch the rows that make up the lists and perform the summary calculations yourself
	to eliminate the summary statement.
*/