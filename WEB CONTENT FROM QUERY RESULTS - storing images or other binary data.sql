/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - STORING IMAGES OR OTHER BINARY DATA!!

> You want to store images in MySQL

> That’s not difficult, provided that you take the proper precautions for encoding 
image data

*/

/*
> Websites are not limited to displaying text. They also serve various forms of binary data
such as images, music files, PDF documents, and so forth
> Images are a common kind of binary data, and because image storage is a natural application 
for a database
	> ALERT <
		Don't do it!
*/

/*
> Deciding where to store images involves trade-offs. There are advantages and disadvantages
regardless of whether you store images in the database or in the filesystem:
	• Storing images in a database table bloats the table. 
		>> you’re more likely to approach any limits your operating system places on table size. 
		> if you store images in the filesystem, directory lookups may become slow.
	• Using a database centralizes storage for images that are used across multiple web
	servers on different hosts. 
	• Images stored in the filesystem constitute, in essence, a foreign key. 
		> Storing images in the database is simpler because adding, updating, or
		removing an image requires only a single-row operation.
	• It can be faster to serve images over the Web from the filesystem than from the
	database because the web server itself opens the file, reads it, and writes it to the
	client. 
	• Images stored in the filesystem can be referred to directly in web pages by means
	of <img> tag links that point to the image files. 
		> Images stored in MySQL must be served by a script that retrieves an image and sends 
		it to the client. 
*/

/*
STORING IMAGES WITH LOAD_FILE()
> The LOAD_FILE() function takes an argument indicating a file to be read and stored in
the database. 
	+) npr. to load an image stored in /tmp/myimage.png into a table, do this
	
> To load images with LOAD_FILE(), these requirements must be satisfied:
	• The image file must be located on the MySQL server host.
	• The file must be readable by the server.
	• You must have the FILE privilege.
*/
+)
INSERT INTO mytbl (image_data) VALUES(LOAD_FILE('/tmp/myimage.png'));


/*
STORING IMAGES USING A SCRIPT
> script should either read the contents of an image file and create a row that contains the 
image data, or create a row that indicates where in the filesystem the image file is located.

EXAMPLE:
1) The store_image.pl script uses an image table that includes columns for the image ID,
name, and MIME type, and a column in which to store the image data

> It is possible to use the name column to store full pathnames to images in the database,
but if you put them all under the same directory, you can store names that are relative
to that directory, and name values will take less space

2) You hava script to turn tu PHP
	> The script is fairly straightforward. It implements the following procedure:
		1. Check that the proper number of arguments was given and initialize some variables
		from them.
		2. Make sure the image directory exists. If it does not, the script cannot continue.
		3. Open and read the contents of the image file.
		4. Store the image as a file in the image directory.
		5. Store a row containing identifying information and the image data in the image
		table.
*/
1)
CREATE TABLE image
(
id INT UNSIGNED NOT NULL AUTO_INCREMENT, # image ID number
name VARCHAR(30) NOT NULL, # image name
type VARCHAR(20) NOT NULL, # image MIME type
data LONGBLOB NOT NULL, # image data
PRIMARY KEY (id), # id and name are unique
UNIQUE (name)
);


/*
> Image-handling has a reputation for being a lot more troublesome than it really is. If
you properly handle image data in a statement by using placeholders or by encoding it,
you’ll have no problems. If you don’t, you’ll get errors.
*/
