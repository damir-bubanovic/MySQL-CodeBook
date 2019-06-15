/*

!!WORKING WITH STRINGS - BASIC!!

> String values can be compared for equality or inequality or relative ordering. 
However, strings have additional properties to consider:

	• A string can be binary or nonbinary. 
		>> Binary strings are used for raw data such as	images, music files, or encrypted values. 
		>> Nonbinary strings are used for character data such as text and are associated with a 
		character set and collation (sort order).
		
	• A character set determines which characters are legal in a string. 
		>> You can choose collations according to whether you need comparisons to be case 
		sensitive or case insensitive, or to use the rules of a particular language.
		
	• Data types for binary strings are BINARY, VARBINARY, and BLOB. 
		>> Data types for nonbinary strings are CHAR, VARCHAR, and TEXT, each of which permits 
		CHARACTER SET and COLLATE attributes.
		
	• You can convert a binary string to a nonbinary string and vice versa, or convert a
	nonbinary string from one character set or collation to another.
	
	• You can use a string in its entirety or extract substrings from it. 
		>> Strings can be combined with other strings.
		
	• You can apply pattern-matching operations to strings.
	
	• Full-text searching is available for efficient queries on large collections of text.

*/
