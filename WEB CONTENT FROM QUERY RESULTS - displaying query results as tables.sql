/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - DISPLAYING QUERY RESULTS AS TABLES!!

> You want to display a query result as an HTML table

> Use each row of the result as a table row. To present an initial row of column labels,
supply your own or use the query metadata to obtain the column names

*/

/*
> They’re popular for displaying the results of queries that consist of rows and columns 
due to the natural conceptual correspondence between HTML tables and database tables 
or query results.
> In addition, you can obtain column headers for the table by accessing the query metadata

EXAMPLE:
1) Suppose that you want to display the contents of your CD collection

2) To display this query result as a bordered HTML table, produce output that looks
something like this

+) Većinom su PERL primjeri pa pogledaj kako da transofmiraš u PHP
*/
1)
mysql> SELECT year, artist, title FROM cd ORDER BY artist, year;

2)
<table border="1">
<tr>
<th>Year</th>
<th>Artist</th>
<th>Title</th>
</tr>
<tr>
<td>2002</td>
<td>Aradhna</td>
<td>Marga Darshan</td>
</tr>
<tr>
<td>1999</td>
<td>Charlie Peacock</td>
<td>Kingdom Come</td>
</tr>
... other rows here ...
<tr>
<td>1982</td>
<td>Undercover</td>
<td>Undercover</td>
</tr>
</table>
