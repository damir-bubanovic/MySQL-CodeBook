/*

!!BASIC - CLIENT PROGRAM - WHAT TO DO IF MySQL CANNOT BE FOUND!!

> When you invoke mysql from the command line, 
your command interpreter can’t find it.

> Add the directory where mysql is installed to your PATH setting. 
Then you can run mysql from any directory easily


EXAMPLE:
> If your shell or command interpreter can’t find mysql when you invoke it, 
you’ll see some sort of error message
*/

C:\> mysql
Bad command or invalid filename

/*
> One way to tell your command interpreter where to find mysql is to 
type its full pathname each time you run it
*/

C:\> "C:\Program Files\MySQL\MySQL Server 5.6\bin\mysql"

/*
> solution is to modify your PATH search-path environment variable, which
specifies directories where the command interpreter looks for commands. 
	>> Add to the PATH value the directory where mysql is installed. 
	>> Then you can invoke mysql from any location by entering only its name, 
	which eliminates pathname typing

> A significant additional benefit of being able to easily run mysql from anywhere is that
you need not put your datafiles in the directory where mysql is located. 
> You’re free to organize your files in a way that makes sense to you, not a way imposed by 
some artificial necessity. 
	>> npr. you can create a directory under your home directory for each database you have 
	and put the work files associated with a given database in the appropriate directory

*/