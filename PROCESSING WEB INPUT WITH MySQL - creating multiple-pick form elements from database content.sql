/*

!!PROCESSING WEB INPUT WITH MySQL - CREATING MULTIPLE-PICK FORM ELEMENTS FROM DATABASE CONTENT!!

> A form must present a field that offers several options and enables the user to select any
number of them

> Use a multiple-pick list element, such as a set of checkboxes or a scrolling list

*/

/*
> Multiple-pick form elements enable you to present multiple choices, any number of
which can be selected, or possibly even none of them

EXAMPLE:
+) cow_order table
*/
+)
mysql> SELECT COLUMN_TYPE, COLUMN_DEFAULT FROM INFORMATION_SCHEMA.COLUMNS
	-> WHERE TABLE_SCHEMA='cookbook' AND TABLE_NAME='cow_order'
	-> AND COLUMN_NAME='accessories';
	
/*
1) Checkboxes

2) Scrolling lists
*/
1)
<input type="checkbox" name="accessories" value="cow bell"
checked="checked" />cow bell
<input type="checkbox" name="accessories" value="horns"
checked="checked" />horns
<input type="checkbox" name="accessories" value="nose ring" />nose ring
<input type="checkbox" name="accessories" value="tail ribbon" />tail ribbon

2
<select name="accessories" size="3" multiple="multiple">
<option value="cow bell" selected="selected">cow bell</option>
<option value="horns" selected="selected">horns</option>
<option value="nose ring">nose ring</option>
<option value="tail ribbon">tail ribbon</option>
</select>


/*
1) make_checkbox_group() - in Ruby - covert it to PHP

2) To fetch the cow accessory information and present it using checkboxes

3) To display a scrolling list instead, invoke make_scrolling_list()


4) In PHP, fetch the accessory information

5) Then present checkboxes or a scrolling list
*/
1)
def make_checkbox_group(name, values, labels, default, vertical)
# make sure default is an array (converts a scalar to an array)
default = [ default ].flatten
str = ""
for i in 0...values.length do
# select the item if it corresponds to one of the default values
checked = (default.include?(values[i]) ? " checked=\"checked\"" : "")
str << sprintf(
"<input type=\"checkbox\" name=\"%s\" value=\"%s\"%s />%s",
CGI.escapeHTML(name.to_s),
CGI.escapeHTML(values[i].to_s),
checked,
CGI.escapeHTML(labels[i].to_s))
str << "<br />" if vertical # display items vertically
end
return str
end

2)
acc_info = get_enumorset_info(dbh, "cookbook", "cow_order", "accessories")
if acc_info["default"].nil?
acc_def = []
else
acc_def = acc_info["default"].split(",")
end
form << make_checkbox_group("accessories",
acc_info["values"],
acc_info["values"],
acc_def,
true) # display items vertically

3)
form << make_scrolling_list("accessories",
acc_info["values"],
acc_info["values"],
acc_def,
3, # display 3 items at a time
true) # create multiple-pick list


4)
$acc_info = get_enumorset_info ($dbh, "cookbook", "cow_order", "accessories");
$acc_def = explode (",", $acc_info["default"]);

5)
print (make_checkbox_group ("accessories[]",
$acc_info["values"],
$acc_info["values"],
$acc_def,
TRUE)); # display items vertically
print (make_scrolling_list ("accessories[]",
$acc_info["values"],
$acc_info["values"],
$acc_def,
3, # display 3 items at a time
TRUE)); # create multiple-pick list
