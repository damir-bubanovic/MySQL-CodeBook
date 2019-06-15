/*

!!GENERATING SUMMARIES - BASIC!!

> Database systems are useful for data storage and retrieval, but can also summarize your
data in more concise forms. 
> Summaries are useful when you want the overall picture, not the details

> Two common summary types: 
	1) Counting summaries
		>> The first (the number of customer records per state) is a counting summary. 
		>> The content of each record is important only for purposes of placing it into the 
		proper group or category for counting. Such summaries are essentially histograms,
		where you sort items into a set of bins and count the number of items in each bin
	2) Content summaries
		>> The second example (sales volume per month) is a content summary, in which sales
		totals are based on sales values in order records

> Another summary type produces neither counts nor sums, but simply a list of unique
values. 
	>> This is useful if you care which values are present rather than how many of each
	there are
	
> The summary types available to you depend on the nature of your data. 
> A counting summary can be generated from all kinds of values, whether they be numbers, strings,
or dates. 
> Summaries that produce sums or averages apply only to numeric values. 
> You can count instances of customer state names to produce a demographic analysis of your
customer base. 
> And sometimes it makes sense to apply one summary technique to the result of another.
*/


/*
>Summary operations in MySQL involve the following SQL constructs:
	• To compute a summary value from a set of individual values, use one of the functions
	known as aggregate functions. 
		>> Aggregate functions include COUNT(), which counts rows or values in a query result; 
		MIN() and MAX(), which find smallest and largest values; and SUM() and AVG(), which 
		produce sums and means of values. 
		>> These functions can be used to compute a value for the entire result set, or with a 
		GROUP BY clause to group rows into subsets and obtain an aggregate value for each one.
	• To obtain a list of unique values, use SELECT DISTINCT rather than SELECT.
	• To count unique values, use COUNT(DISTINCT) rather than COUNT().
*/