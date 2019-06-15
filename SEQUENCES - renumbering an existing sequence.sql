/*

!!GENERATING & USING SEQUENCES - RENUMBERING AN EXISTING SEQUENCE!!

> You have gaps in a sequence column, and you want to resequence it

> Don’t bother. Or at least don’t do so without a good reason, of which there are very few
	>> You should not resequence a column containing values that are referenced by another 
	table

*/

/*
Here are reasons I have seen advanced for resequencing a column:

Aesthetics
	> Really no need for this
Performance
	> By removing gaps this enables MySQL to run statements more quickly (NOT TRUE)

Running out of numbers
	> If an AUTO_INCREMENT sequence is approaching the upper limit of its data type,
	change the column data type to increase its upper limit without changing the 
	values stored in the column

*/