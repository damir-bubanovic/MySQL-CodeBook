/*

!!VALIDATING & REFORMATING DATA - USING TABLE METADATA TO VALIDATE DATA!!

> You must check input values against the legal members of an ENUM or SET column

> Get the column definition, extract the list of members from it, and check data values
against the list

*/

/*
> One way to check input values that correspond to the legal values of ENUM or SET columns
is to get the list of legal column values into an array using the information in INFORMA
TION_SCHEMA, then perform an array membership test
1) Favorite-color column color from the profile table is an ENUM defined as follows
*/
1)
mysql> SELECT COLUMN_TYPE FROM INFORMATION_SCHEMA.COLUMNS
	-> WHERE TABLE_SCHEMA = 'cookbook' AND TABLE_NAME = 'profile'
	-> AND COLUMN_NAME = 'color';
	
/*
> Efficient to perform hash lookups than array lookups
	>> To do so, retrieve the legal enumeration values and store them as keys of a hash. 
	>> Then test each input value by checking whether it exists as a hash key
	
1) Begin by getting the metadata for the column and convert the list of legal enumeration
members to a hash

2) By converting the enumeration values to a given lettercase before storing them in the hash, 
and then converting the values you want to check similarly, you perform, in effect, a caseinsensitive
key existence test

3) Dosta ima proučavaj dalje
*/