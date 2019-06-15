/*

!!GENERATING & USING SEQUENCES - EFFECT OF THE ROW DELETIONS ON SEQUENCE GENERATION!!

> You want to know what happens to a sequence when you delete rows from a table that
contains an AUTO_INCREMENT column

> It depends on which rows you delete and on the storage engine

*/

/*
> Why it’s useful to have unique ID values: they enable you to specify any row unambiguously

> Removing row 2 creates a gap in the middle of the sequence. 
	>> This has no effect on subsequent inserts, because MySQL makes no attempt to fill in
	holes in a sequence. 
	>> On the other hand, deleting rows 7 and 8 removes values at the top of the sequence. 
		>>> For InnoDB or MyISAM tables, values are not reused
*/

/*
> InnoDB (prevents sequence values from being reused after rows are deleted)
*/