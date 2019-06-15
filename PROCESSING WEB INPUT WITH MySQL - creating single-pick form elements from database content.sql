/*

!!PROCESSING WEB INPUT WITH MySQL - CREATING SINGLE-PICK FORM ELEMENTS FROM DATABASE CONTENT!!

> A form must present a field that enables the user to select one of several options

> Use a single-pick list element. These include radio button sets, pop-up menus, and
scrolling lists

*/

/*
EXAMPLE:
1) The list of colors in the cow_color table. These can be obtained with the following
statement

2) The list of legal figurine sizes in the size column of the cow_order table. The column
is represented as an ENUM, so the permitted and default values can be obtained
from INFORMATION_SCHEMA

3) The list of state names and abbreviations. These are stored in the states table


> The differing numbers of choices lead to different decisions about how to
represent the lists in a form:
	• The figurine size values are best represented as a set of radio buttons or a pop-up
	menu; a scrolling list is unnecessary because the number of choices is small.
	• The set of colors can reasonably be displayed using any of the single-pick element
	types; it’s small enough that a set of radio buttons wouldn’t take a lot of space, but
	large enough that you may want to enable scrolling—particularly if you make additional
	colors available.
	• The list of states has more items than feasible to present as a set of radio buttons.
	It’s more reasonably displayed as a pop-up menu or scrolling list.
*/
1)
mysql> SELECT color FROM cow_color ORDER BY color;

2)
mysql> SELECT COLUMN_TYPE, COLUMN_DEFAULT
	-> FROM INFORMATION_SCHEMA.COLUMNS
	-> WHERE TABLE_SCHEMA='cookbook' AND TABLE_NAME='cow_order'
	-> AND COLUMN_NAME='size';
	
3)
mysql> SELECT abbrev, name FROM states ORDER BY name;

/*
EXAMPLE:
1) Radio buttons

2) Pop-up menus

3) Scrolling lists
*/
1)
<input type="radio" name="size" value="small" />small
<input type="radio" name="size" value="medium" checked="checked" />medium
<input type="radio" name="size" value="large" />large

2)
<select name="color">
<option value="Black">Black</option>
<option value="Black &amp; White">Black &amp; White</option>
<option value="Brown">Brown</option>
<option value="Cream">Cream</option>
<option value="Red">Red</option>
<option value="Red &amp; White">Red &amp; White</option>
<option value="See-Through">See-Through</option>
</select>

3)
<select name="state" size="6">
<option value="AL">Alabama</option>
<option value="AK">Alaska</option>
<option value="AZ">Arizona</option>
<option value="AR">Arkansas</option>
<option value="CA">California</option>
…
<option value="WV">West Virginia</option>
<option value="WI">Wisconsin</option>
<option value="WY">Wyoming</option>
</select>


/*
> Radio button sets, pop-up menus, and scrolling lists have several things in common:
	A name for the element
		> When the user submits the form, the browser associates this name with the value
		the user selected.
	A set of values, one for each item in the list
		> The internal values available to be selected.
	A set of labels, one for each item
		> The values that the user sees in the displayed form.
	An optional default value
		> Which item in the list is selected initially when the browser displays the list.
*/


/*
1) radio buttons for the colors

2) pop-up menu

3) scrolling list
*/
1)
<sql:query dataSource="${conn}" var="rs">
SELECT color FROM cow_color ORDER BY color
</sql:query>
<c:forEach items="${rs.rows}" var="row">
<input type="radio" name="color"
value="<c:out value="${row.color}"/>"
/><c:out value="${row.color}"/><br />
</c:forEach>

2)
<select name="color">
<c:forEach items="${rs.rows}" var="row">
<option value="<c:out value="${row.color}"/>">
<c:out value="${row.color}"/></option>
</c:forEach>
</select>

3)
<select name="color" size="3">
<c:forEach items="${rs.rows}" var="row">
<option value="<c:out value="${row.color}"/>">
<c:out value="${row.color}"/></option>
</c:forEach>
</select>


/*
+) To create a group of radio buttons, a pop-up menu, or a single-pick scrolling list, 
invoke the functions as follows
*/
+)
print radio_group (	-name => "color",
					-values => $color_ref,
					-linebreak => 1); # display buttons vertically
print popup_menu (	-name => "color",
					-values => $color_ref);
print scrolling_list (	-name => "color",
						-values => $color_ref,
						-size => 3); # display 3 items at a time

/*
+) Construct the value list and label hash as follows
*/
+)
my @state_values;
my %state_labels;
my $sth = $dbh->prepare (qq{
SELECT abbrev, name FROM states ORDER BY name
});
$sth->execute ();
while (my ($abbrev, $name) = $sth->fetchrow_array ())
{
push (@state_values, $abbrev); # save each value in an array
$state_labels{$abbrev} = $name; # map each value to its label
}


/*
+) In PHP, to present the list of values from the cow_color table in a pop-up menu, use a
fetch-and-print loop like this
*/
$stmt = "SELECT color FROM cow_color ORDER BY color";
$sth = $dbh->query ($stmt);

print ('<select name="color">');
while (list ($color) = $sth->fetch (PDO::FETCH_NUM)) {
	$color = htmlspecialchars ($color);
	printf ('<option value="%s">%s</option>', $color, $color);
}
print ("</select>\n");


/*
+) In PHP, the make_radio_group() function for creating a set of radio buttons looks like
this
*/
+)
function make_radio_group ($name, $values, $labels, $default, $vertical)
{
$result = '';
for ($i = 0; $i < count ($values); $i++)
{
# select the item if it corresponds to the default value
$checked = ($values[$i] == $default ? ' checked="checked"' : '');
$result .= sprintf (
'<input type="radio" name="%s" value="%s"%s />%s',
htmlspecialchars ($name),
htmlspecialchars ($values[$i]),
$checked,
htmlspecialchars ($labels[$i]));
if ($vertical)
$result .= '<br />'; # display items vertically
}
return ($result);
}

/*
+) The function constructs the form element as a string, which it returns. To use make_ra
dio_group() to present cow colors, invoke it after fetching the items from the cow_col
or table, as follows
*/
+)
$stmt = "SELECT color FROM cow_color ORDER BY color";
$sth = $dbh->query ($stmt);
$values = $sth->fetchAll (PDO::FETCH_COLUMN, 0);
print (make_radio_group ("color", $values, $values, "", TRUE));

/*
+) To present a pop-up menu, use the following function instead
*/
+)
function make_popup_menu ($name, $values, $labels, $default)
{
$result = '';
for ($i = 0; $i < count ($values); $i++)
{
# select the item if it corresponds to the default value
$checked = ($values[$i] == $default ? ' selected="selected"' : '');
$result .= sprintf (
'<option value="%s"%s>%s</option>',
htmlspecialchars ($values[$i]),
$checked,
htmlspecialchars ($labels[$i]));
}
$result = sprintf (
'<select name="%s">%s</select>',
htmlspecialchars ($name),
$result);
return ($result);
}


/*
1) The make_scrolling_list() function is similar to make_popup_menu(), so I don’t show
its implementation here. To invoke it to produce a single-pick list, pass the same arguments
as for make_popup_menu(), but indicate how many rows should be visible at once,
and add a multiple argument of FALSE

2) The state list uses labels that differ from the values. Fetch the labels and values like this

3) Use the values and labels to generate the type of list you want
*/
1)
print (make_scrolling_list ("color", $values, $values, "", 3, FALSE));

2)
$values = array ();
$labels = array ();
$stmt = "SELECT abbrev, name FROM states ORDER BY name";
$sth = $dbh->query ($stmt);
while ($row = $sth->fetch (PDO::FETCH_NUM))
{
$values[] = $row[0];
$labels[] = $row[1];
}

3) 
print (make_popup_menu ("state", $values, $labels, ""));
print (make_scrolling_list ("state", $values, $labels, "", 6, FALSE));
