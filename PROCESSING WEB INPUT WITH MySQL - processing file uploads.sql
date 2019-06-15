/*

!!PROCESSING WEB INPUT WITH MySQL - PROCESSING FILE UPLOADS!!

> You want to permit files to be uploaded to your web server and stored in your database

> Present the user with a web form that includes a file field. When the user submits the
form, extract the file and store it

*/

/*
1) To create a form that enables files to be uploaded, the opening <form> tag should specify
the post method and must also include an enctype (encoding type) attribute with a
value of multipart/form-data

2) To include a file upload field in the form, use an <input> element of type file. For
example, this element presents a 60-character file field named upload_file
*/
1)
<form method="post" enctype="multipart/form-data" action="script_name">

2)
<input type="file" name="upload_file" size="60" />


/*
PHP
1) To write an upload form in PHP, include a file field. If you like, also include a hidden
field preceding the file field that has a name of MAX_FILE_SIZE and a value of the largest
file size you’re willing to accept
	> But more is in PHP cookbook
	
2) Information about files are available in the following variables

3) To simplify access to file upload information, use a utility routine that does the work
*/
1)
<form method="post" enctype="multipart/form-data"
action="<?php print ($_SERVER["PHP_SELF"]); ?>">
<input type="hidden" name="MAX_FILE_SIZE" value="4000000" />
Image name:<br />
<input type="text" name="image_name" size="60" />
<br />
Image file:<br />
<input type="file" name="upload_file" size="60" />
<br /><br />
<input type="submit" name="choice" value="Submit" />
</form>

2)
$_FILES["upload_file"]["name"]
$_FILES["upload_file"]["tmp_name"]
$_FILES["upload_file"]["size"]
$_FILES["upload_file"]["type"]

3)
function get_upload_info ($name) {
	# Check the $_FILES array tmp_name member to make sure there is a
	# file. (The entry might be present even if no file was uploaded.)
	$val = NULL;
	
	if (isset ($_FILES[$name]) && $_FILES[$name]["tmp_name"] != "" && $_FILES[$name]["tmp_name"] != "none") {
		$val = $_FILES[$name];
	}
	return ($val);
}



