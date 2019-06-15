/*

!!SELECTING DATA FROM TABLES - SELECTING DATA FROM MULTIPLE TABLES!!

> The answer to a question requires data from more than one table

> Use a join or a subquery
	>> join matches rows in one table with rows in another and enables you to retrieve 
	output rows that contain columns from either or both tables.
	>> subquery is one query nested within another, to perform a comparison between 
	values selected by the inner query against values selected by the outer query

*/


/*
EXAMPLE: 
> you have 2 tables

> The table associates each row with the proper profile row via the profile_id column

1) table

2) table
*/
1)
mysql> SELECT * FROM profile;

2) 
CREATE TABLE profile_contact
(
profile_id INT UNSIGNED NOT NULL, # ID from profile table
service VARCHAR(20) NOT NULL, # social media service name
contact_name VARCHAR(25) NOT NULL, # name to use for contacting person
INDEX (profile_id)
);


/*
QUESTION:
> “For each person in the profile table, show me which services I can use to get in touch, 
and the contact name for each service.”

> The FROM clause indicates the tables from which to select data, and the ON clause tells
MySQL which columns to use to find matches between the tables

ANSWER:
> Select from both tables and match rows by comparing the id column from the profile table 
with the profile_id column from the profile_contact table
*/
mysql> SELECT id, name, service, contact_name
	-> FROM profile INNER JOIN profile_contact ON id = profile_id;
	

	
/*
QUESTION:
> List all the profile_contact records for Nancy

ANSWER:
> To write the query without looking up Nancy’s ID yourself, use a subquery that, 
given her name, looks it up for you
*/
mysql> SELECT * FROM profile_contact
	-> WHERE profile_id = (SELECT id FROM profile WHERE name = 'Nancy');
