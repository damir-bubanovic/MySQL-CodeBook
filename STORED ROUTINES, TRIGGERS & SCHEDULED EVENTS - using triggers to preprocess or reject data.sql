/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING TRIGGERS TO PREPROCESS OR REJECT DATA!!

> There are conditions you want to check for data entered into a table, but you don’t want
to write the validation logic for every INSERT

> Centralize the input-testing logic into a BEFORE INSERT trigger

*/

/*
> You can use triggers to perform several types of input checks
	• Reject bad data by raising a signal. 
		>> This gives you access to stored program logic for more latitude in checking 
		values than is possible with static constraints such as NOT NULL.
	• Preprocess values and modify them, if you won’t want to reject them outright. 
		>> npr. map out-of-range values to be in range or sanitize values to put them in
		canonical form, if you permit entry of close variants.
		
EXAMPLE:
1) Table of contact information such as name, state of residence,
email address, and website URL

> For entry of new rows, you want to enforce constraints or perform preprocessing as
follows:
	• State of residence values are two-letter US state codes, valid only if present in the
	states table. (In this case, you could declare the column as an ENUM with 50 members,
	so it’s more likely you’d use this lookup-table technique with columns for
	which the set of valid values is arbitrarily large or changes over time.)
	• Email address values must contain an @ character to be valid.
	• For website URLs, strip any leading http:// to save space.
2) To handle these requirements, create a BEFORE INSERT trigger

3) To also handle updates, define a BEFORE UPDATE trigger with the same body as bi_con
tact_info

4) Test the trigger by executing some INSERT statements to verify that it accepts valid values,
rejects bad ones, and trims URLs
*/
1)
CREATE TABLE contact_info
(
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(30), # state of residence
state CHAR(2), # state of residence
email VARCHAR(50), # email address
url VARCHAR(255), # web address
PRIMARY KEY (id)
);

2)
CREATE TRIGGER bi_contact_info BEFORE INSERT ON contact_info
FOR EACH ROW
BEGIN
IF (SELECT COUNT(*) FROM states WHERE abbrev = NEW.state) = 0 THEN
SIGNAL SQLSTATE 'HY000'
SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'invalid state code';
END IF;
IF INSTR(NEW.email,'@') = 0 THEN
SIGNAL SQLSTATE 'HY000'
SET MYSQL_ERRNO = 1525, MESSAGE_TEXT = 'invalid email address';
END IF;
SET NEW.url = TRIM(LEADING 'http://' FROM NEW.url);
END;

4)
mysql> INSERT INTO contact_info (name,state,email,url)
-> VALUES('Jen','NY','jen@example.com','http://www.example.com');
mysql> INSERT INTO contact_info (name,state,email,url)
-> VALUES('Jen','XX','jen@example.com','http://www.example.com');
ERROR 1525 (HY000): invalid state code
mysql> INSERT INTO contact_info (name,state,email,url)
-> VALUES('Jen','NY','jen','http://www.example.com');
ERROR 1525 (HY000): invalid email address
mysql> SELECT * FROM contact_info;
