/*
!!UNICODE CHARACTER SETS!!
*/

/*
BASIC:

MySQL supports multiple Unicode character sets:

	> utf8, a UTF-8 encoding of the Unicode character set using one to three bytes per character.

	> utf8mb4, a UTF-8 encoding of the Unicode character set using one to four bytes per character.

	> ucs2, the UCS-2 encoding of the Unicode character set using 16 bits per character.

	> utf16, the UTF-16 encoding for the Unicode character set; like ucs2 but with an extension for supplementary 
	characters.

	> utf16le, the UTF-16LE encoding for the Unicode character set; like utf16 but little-endian rather than big-endian.

	> utf32, the UTF-32 encoding for the Unicode character set using 32 bits per character.

	*utf8 and ucs2 support Basic Multilingual Plane (BMP) characters. utf8mb4, utf16, utf16le, and utf32 support 
	BMP and supplementary characters.
*/

/*
USERS SAY:
1)
> The main difference is sorting accuracy (when comparing characters in the language) and performance. 
> The only special one is utf8_bin which is for comparing characters in binary format.

> utf8_general_ci is somewhat faster than utf8_unicode_ci, but less accurate (for sorting). 
> The specific language utf8 encoding (such as utf8_swedish_ci) contain additional language rules that make 
them the most accurate to sort for those languages. Most of the time I use utf8_unicode_ci 
(I prefer accuracy to small performance improvements), unless I have a good reason to prefer a specific language.

2)
Actually, you probably want to use utf8_unicode_ci or utf8_general_ci.
	> utf8_general_ci sorts by stripping away all accents and sorting as if it were ASCII
	> utf8_unicode_ci uses the Unicode sort order, so it sorts correctly in more languages
	
3)
The xxx_croatian_ci collations are tailored for these Croatian letters: Č, Ć, Dž, Đ, Lj, Nj, Š, Ž.
	> As of version 5.1, MySQL supports two Croatian collations: cp1250_croatian_ci and latin2_croatian_ci.
	
	LOOK UP -> http://collation-charts.org/articles/croatian.htm
*/

/*
PHP - ENCODE
> always write
$db->set_charset("utf8");

The data is stored as UTF-8 in MySQL, but the PHP's client connection collation is not. 
Which is why you have to use set_charset in PHP for the DB connection
php.ini : default_charset utf-8
.htaccess : AddDefaultCharset utf-8
*/