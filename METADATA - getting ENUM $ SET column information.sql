/*

!!METADATA - GETTING ENUM & SET COLUMN INFORMATION!!

> You want to know the members of an ENUM or SET column

> This problem is a subset of getting table structure metadata. 
	>> Obtain the column definition from the table metadata, then extract the member 
	list from the definition

*/

/*
> It’s often useful to know the list of legal values for an ENUM or SET column. 
	>> Suppose that you want to present a web form containing a pop-up menu that has 
	options corresponding to each legal value of an ENUM column, such as the sizes 
	in which a garment can be ordered, or the available shipping methods for delivering 
	a package
	
> To determine the permitted values for an ENUM or SET column, get its definition using
one of the techniques described before
	1) npr. if you select from the INFORMATION_SCHEMA COLUMNS table, the COLUMN_TYPE 
	value for the colors column of the item table looks like this
*/
1)
enum('chartreuse','mauve','lime green','puce')

/*
> Equivalent routines for other APIs are similar. You can find implementations in the lib
directory of the recipes distribution. Such routines are useful for validation of input
values, and are especially handy for generating list elements in web forms
*/