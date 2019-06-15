/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING TRIGGERS TO IMPLEMENT DYNAMIC DEFAULT COLUMN VALUES!!

> A table contains a column for which the initial value is not constant, but in most cases,
MySQL permits only constant default values

> Use a BEFORE INSERT trigger. 
	>> This enables you to initialize a column to the value of an arbitrary expression. 
	>> In other words, the trigger performs dynamic column initialization by calculating the default value

*/

/*
1) A cust_invoice table for storing sales information might look like this

2) To initialize the sales tax column for inserts into the cust_invoice table, use a 
BEFORE INSERT trigger that looks up the rate and stores it in the table

3) To test the implementation, insert a row and check whether the trigger correctly initializes
the sales tax rate for the invoice
*/
1)
CREATE TABLE cust_invoice
(
id INT NOT NULL AUTO_INCREMENT,
state CHAR(2), # customer state of residence
amount DECIMAL(10,2), # sale amount
tax_rate DECIMAL(3,2), # sales tax rate at time of purchase
... other columns ...
PRIMARY KEY (id)
);

2)
CREATE TRIGGER bi_cust_invoice BEFORE INSERT ON cust_invoice
FOR EACH ROW SET NEW.tax_rate = sales_tax_rate(NEW.state);

3)
mysql> INSERT INTO cust_invoice (state,amount) VALUES('NY',100);
mysql> SELECT * FROM cust_invoice WHERE id = LAST_INSERT_ID();