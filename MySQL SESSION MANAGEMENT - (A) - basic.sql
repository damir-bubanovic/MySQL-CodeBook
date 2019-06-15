/*

!!USING MySQL-BASED WEB SESSION MANAGEMENT - BASIC!!

> Sessions are useful for activities such as performing login operations and associating
a logged-in user with subsequent requests, and gathering input from a user in
stages

> This chapter shows how to make information persist across multiple requests, which
enables you to develop applications for which one request retains memory of previous
ones

> When a session begins, the application generates and sends the client a cookie containing 
the initial information to be stored. The client returns the cookie to the server with 
subsequent requests to identify itself and enable the application to recognize the requests 
as stages of the same client session

> This mechanism enables data to persist across requests while still affording the application 
the opportunity to update the information as necessary

> The alternative to client-side storage is to maintain session state on the server side.
Information about client activity is stored somewhere on the server, such as in a file, in
shared memory, or in a database. The only information maintained on the client side
is a unique identifier that the server generates and sends to the client when the session
begins. The client sends this value to the server with each subsequent request so the
server can associate the client with the appropriate session

> In PHP, the session manager is built in. Scripts can use it with no special preparation, but 
only as long as they want to use the default storage method (files). To use an alternative
method (such as storing sessions in MySQL), an application must register its own routines
with the session manager

> Sessions usually can accommodate various types of data, such as scalars, arrays, or objects

> For backing store implemented using MySQL, use one of the BLOB data types. Our session managers 
use the largest such type, LONGBLOB. When assessing storage needs, remember that stored data is 
serialized, which takes more space than raw data

*/