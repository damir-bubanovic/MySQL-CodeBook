<?php 
/*1) aktiviramo database tj. instantiate MYSQLi class u objekt u varijablu $myDataBase*/
$myDataBase = new mysqli('localhost', 'dbUserName', 'dbPassword', 'dbName');

/*2) stvaramo SQL command string u varijablu $sql*/
$sql = "INSERT INTO dbName (firstName, lastName, comments)
VALUES ('$_POST[firstName]', '$_POST[lastName]', '$_POST[comments]')";

/*3) testiramo da li je veza uspostavljena*/
if($myDataBase->query($sql) === TRUE) {
	print "Guest entry saved sucessfully";
} else {
	print "INSERT attemp failed, please try again, or call tech support";
}

/*Zatvaranje database tj. class i destroy class iz memory*/
$myDataBase->close();
?>