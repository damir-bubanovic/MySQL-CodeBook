/*

!!BASIC - CLIENT PROGRAM - CONTROLLING MySQL OUTPUT DESTINATION & FORMAT!!

> You want mysql output to go somewhere other than your screen. 
And you don’t necessarily want the default output format

> Redirect the output to a file, or use a pipe to send the output to a program. 
	>> You can also control other aspects of mysql output to produce tabular, 
	tab-delimited, HTML, or XML output; suppress column headers; or make mysql 
	more or less verbose

	
EXAMPLE:
Unless you send mysql output elsewhere, it goes to your screen. To save 
output from mysql in a file, use your shell’s redirection capability
*/
% mysql cookbook > outputfile

/*
> If you run mysql interactively with the output redirected, you can’t see what you type,
so in this case you usually also read the input from a file (or another program)
*/
% mysql cookbook < inputfile > outputfile

/*
> To send the output to another program (for example, to mail query results to someone),
use a pipe
*/
% mysql cookbook < inputfile | mail paul



/*
PRODUCING TABULAR OR TAB-DELIMITED OUTPUT
> mysql chooses its default output format by whether it runs interactively or noninteractively.
	>> For interactive use, mysql writes output to the terminal using tabular (boxed) format
*/
% mysql
mysql> SELECT * FROM limbs WHERE legs=0;

/*
> For noninteractive use (when the input or output is redirected), mysql writes 
tabdelimited output
*/
% echo "SELECT * FROM limbs WHERE legs=0" | mysql cookbook

/*
> To override the default output format, use the appropriate command option
*/
% mysql cookbook < inputfile | mail paul

/*
> Use the -t (or --table) option to produce more readable tabular output
*/
% mysql -t cookbook < inputfile | mail paul



/*
PRODUCING HTML or XML OUTPUT
> mysql generates an HTML table from each query result set if you use the -H (or --html) option. 
	>> This enables you to easily produce output for inclusion in a web page that shows a query 
	result
*/
% mysql -H -e "SELECT * FROM limbs WHERE legs=0" cookbook
<TABLE BORDER=1>
	<TR><TH>thing</TH><TH>legs</TH><TH>arms</TH></TR>
	<TR><TD>squid</TD><TD>0</TD><TD>10</TD></TR>
	<TR><TD>fish</TD><TD>0</TD><TD>0</TD></TR>
	<TR><TD>phonograph</TD><TD>0</TD><TD>1</TD></TR>
</TABLE>

/*
> To generate an XML document instead of HTML, use the -X (or --xml) option
*/
% mysql -X -e "SELECT * FROM limbs WHERE legs=0" cookbook
<?xml version="1.0"?>

<resultset statement="select * from limbs where legs=0">
	<row>
		<field name="thing">squid</field>
		<field name="legs">0</field>
		<field name="arms">10</field>
	</row>
	<row>
		<field name="thing">fish</field>
		<field name="legs">0</field>
		<field name="arms">0</field>
	</row>
	<row>
		<field name="thing">phonograph</field>
		<field name="legs">0</field>
		<field name="arms">1</field>
	</row>
</resultset>

/*
> Basic transform that produces plain-text output showing the original 
query, plus the row values separated by commas
*/
<?xml version="1.0" encoding="ISO-8859-1"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<!-- mysql-xml.xsl: interpret XML-format output from mysql client -->

<xsl:output method="text"/>

<!-- Process rows in each resultset -->
<xsl:template match="resultset">
	<xsl:text>Query: </xsl:text>
	<xsl:value-of select="@statement"/>
	<xsl:value-of select="'&#10;'"/>
	<xsl:text>Result set:&#10;</xsl:text>
	<xsl:apply-templates select="row"/>
</xsl:template>

<!-- Process fields in each row -->
<xsl:template match="row">
	<xsl:apply-templates select="field"/>
</xsl:template>

<!-- Display text content of each field -->
<xsl:template match="field">
<xsl:value-of select="."/>
	<xsl:choose>
		<xsl:when test="position() != last()">
			<xsl:text>, </xsl:text> <!-- comma after all but last field -->
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="'&#10;'"/> <!-- newline after last field -->
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>
/*
> Use the transform like this
*/
% mysql -X -e "SELECT * FROM limbs WHERE legs=0" cookbook \
| xsltproc mysql-xml.xsl -



/*
SUPPRESSING COLUMN HEADINGS IN QUERY OUTPUT
> Tab-delimited format is convenient for generating datafiles for import 
into other programs

> To create output that contains only data values, suppress the header row with the 
--skip-column-names option
*/
% mysql --skip-column-names -e "SELECT arms FROM limbs" cookbook | summarize

/*
> Specifying the “silent” option (-s or --silent) twice achieves the same effect
*/
% mysql -ss -e "SELECT arms FROM limbs" cookbook | summarize




/*
SPECIFYING THE OUTPUT COLUMN DELIMITER
> Suppose that you want to create an output file for use by a
program that expects values to be separated by colon characters (:) 
rather than tabs
*/
% mysql cookbook < inputfile | sed -e "s/TAB/:/g" > outputfile
% mysql cookbook < inputfile | tr "TAB" ":" > outputfile
% mysql cookbook < inputfile | tr "\011" ":" > outputfile

/*
> sed is more powerful than tr because it understands regular expressions and permits
multiple substitutions. 
> This is useful for producing output in something like commaseparated values (CSV) format, 
which requires three substitutions:
	1. Escape any quote characters that appear in the data by doubling them, so that when
	you use the resulting CSV file, they won’t be interpreted as column delimiters.
	2. Change the tabs to commas.
	3. Surround column values with quotes
	
> sed permits all three substitutions to be performed in a single command line
*/
% mysql cookbook < inputfile \
| sed -e 's/"/""/g' -e 's/TAB/","/g' -e 's/^/"/' -e 's/$/"/' > outputfile




/*
CONTROLLING MySQL VERBOSITY LEVEL
> To tell mysql to be more verbose, use -v or --verbose, specifying the option 
multiple times for increasing verbosity
*/
% echo "SELECT NOW()" | mysql
% echo "SELECT NOW()" | mysql -v
% echo "SELECT NOW()" | mysql -vv
% echo "SELECT NOW()" | mysql -vvv
