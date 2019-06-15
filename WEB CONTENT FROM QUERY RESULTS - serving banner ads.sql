/*

!!GENERATING WEB CONTENT FROM QUERY RESULTS - SERVING BANNER ADS!!

> You want to display banner ads by choosing images on the fly from a set of images

> Use a script that selects a random row from an image table and sends the image to the
client

*/

/*
> A simple way to do this is by means of a script that picks an image at random each time 
it is invoked

> You have to supress caching. 
	>> Because if you don’t, the browser will send a request for banner.py only the first 
	time it sees it in a link. 
		>>> On subsequent requests for the script, the browser will reuse the image, 
		which defeats the intent of having each such link resolve to a randomly chosen 
		image
*/