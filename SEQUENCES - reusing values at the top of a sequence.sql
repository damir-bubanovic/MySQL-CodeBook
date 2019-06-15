/*

!!GENERATING & USING SEQUENCES - RESUING VALUES AT THE TOP OF A SEQUENCE!!

> You’ve deleted rows at the top end of your sequence. Can you avoid resequencing the
column but still reuse the values that have been deleted

> Yes. 
	>> Use ALTER TABLE to reset the sequence counter. 
	>> New sequence numbers will begin with the value one larger than the current maximum 
	in the table

*/

/*
>If you have removed rows only from the top of the sequence, those that remain are still
in order with no gaps
	1) Tell MySQL to resume the sequence beginning with the value one larger than the highest
	existing sequence number by executing this statement, which causes MySQL to reset the 
	sequence counter down as far as it can for new rows
*/
1)
ALTER TABLE tbl_name AUTO_INCREMENT = 1;