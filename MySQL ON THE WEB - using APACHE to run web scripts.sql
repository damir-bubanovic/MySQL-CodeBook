/*

!!MySQL ON THE WEB - USING APACHE TO RUN WEB SCRIPTS!!

> You want to run Perl, Ruby, PHP, or Python programs in a web environment

> Execute them using the Apache server

*/

/*
> If you have Apache configured with PHP support built in using the mod_php module, you can 
tell it that scripts having names ending with .php should be interpreted as PHP scripts. 
1) To do so, add this line to httpd.conf

> With PHP enabled, you can install a PHP script myscript.php under htdocs (the Apache
document root directory). 
2) The URL for invoking the script becomes

3) If you run Windows and you have PHP installed as C:\Php\php.exe, put the following lines 
in httpd.conf

4) If you install library files in /usr/local/lib/mcb, the following directives enable
Perl, Ruby, and Python scripts to find them
> For PHP, add /usr/local/lib/mcb to the value of include_path in your php.ini configuration
file
*/
1)
AddType application/x-httpd-php .php

2)
http://localhost/myscript.php

3)
ScriptAlias /php/ "C:/Php/"
AddType application/x-httpd-php .php
Action application/x-httpd-php /php/php.exe

4)
SetEnv PERL5LIB /usr/local/lib/mcb
SetEnv RUBYLIB /usr/local/lib/mcb
SetEnv PYTHONPATH /usr/local/lib/mcb


/*
+) Here’s a show_tables.php script that shifts back and forth between HTML mode and
PHP mode
*/
<?php
# show_tables.php: Display names of tables in cookbook database
require_once "Cookbook.php";
?>
<html>
<head><title>Tables in cookbook Database</title></head>
<body>
<p>Tables in cookbook database:</p>
<?php
# Connect to database, display table list, disconnect
$dbh = Cookbook::connect ();
$stmt = "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'cookbook' ORDER BY TABLE_NAME";
$sth = $dbh->query ($stmt);
while (list ($tbl_name) = $sth->fetch (PDO::FETCH_NUM))
print ($tbl_name . "<br />");
$dbh = NULL;
?>
</body>
</html>
