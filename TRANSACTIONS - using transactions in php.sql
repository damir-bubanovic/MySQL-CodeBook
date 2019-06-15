/*

!!PERFORMING TRANSACTIONS - USING TRANSACTIONS IN PHP!!

> You want to perform a transaction in a PHP script

> Use the standard PDO transaction support mechanism

*/

/*
+) To begin a transaction, use the beginTransaction() method. Then, after executing your 
statements, invoke either commit() or rollback() to commit or roll back the transaction
*/
+)
try {
	$dbh->beginTransaction ();
	$dbh->exec ("UPDATE money SET amt = amt - 6 WHERE name = 'Eve'");
	$dbh->exec ("UPDATE money SET amt = amt + 6 WHERE name = 'Ida'");
	$dbh->commit ();
} catch (Exception $e) {
	print ("Transaction failed, rolling back. Error was:\n");
	print ($e->getMessage () . "\n");
	
	# empty exception handler in case rollback fails
	try 	{
		$dbh->rollback ();
	} catch (Exception $e2) { 
	}
}