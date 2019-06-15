/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - SERVING IMAGES OR OTHER BINARY DATA!!

> You can store images or other binary data values in your database, using the early described
techniques. But how do you get them back out?

> You need nothing more than a SELECT statement. Of course, what you do with the
information after you retrieve it might be a little more involved

*/

/*
> To display an image in a web page, include an <img> tag in the page that tells the client’s
web browser where to get the image

EXAMPLE:
1) Statement that retrieves an image

> It’s more common to use the information for display in a web page. 
> Or you might send it to the client for downloading

2) You have script to convert to PHP
*/
1)
SELECT * FROM image WHERE id = 1;