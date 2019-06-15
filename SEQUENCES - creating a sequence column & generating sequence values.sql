/*

!!GENERATING & USING SEQUENCES - CREATING A SEQUENCE COLUMN & GENERATING SEQUENCE VALUES!!

> A table must include a column containing unique IDs

> Use an AUTO_INCREMENT column to generate a sequence

*/

/*
1) Unique IDs would be helpful to make the rows distinct and to provide values that make 
each row easy to refer to. 
	>> An AUTO_INCREMENT column is good for this purpose
	
2) The following statement inserts the first four of Junior’s specimens into the insect table
that way

3) This statement adds Junior’s other four specimens to the insect table and generates sequence 
values without naming the id column at all
*/
1)
CREATE TABLE insect
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT,
PRIMARY KEY (id),
name VARCHAR(30) NOT NULL, # type of insect
date DATE NOT NULL, # date collected
origin VARCHAR(30) NOT NULL # where collected
);

2)
mysql> INSERT INTO insect (id,name,date,origin) VALUES
	-> (NULL,'housefly','2014-09-10','kitchen'),
	-> (NULL,'millipede','2014-09-10','driveway'),
	-> (NULL,'grasshopper','2014-09-10','front yard'),
	-> (NULL,'stink bug','2014-09-10','front yard');
	
3)
mysql> INSERT INTO insect (name,date,origin) VALUES
	-> ('cabbage butterfly','2014-09-10','garden'),
	-> ('ant','2014-09-10','back yard'),
	-> ('ant','2014-09-10','back yard'),
	-> ('termite','2014-09-10','kitchen woodwork');