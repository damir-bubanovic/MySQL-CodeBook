/*

!!STORED ROUTINES, TRIGGERS & SCHEDULED EVENTS - USING STORED FUNCTIONS TO ENCAPSULATE CALCULATIONS!!

> A particular calculation to produce a value must be performed frequently by different
applications, but you don’t want to write the expression for it each time it’s needed. 
> Or a calculation is difficult to perform inline within an expression because it requires 
conditional or looping logic

> Use a stored function to hide the ugly details and make the calculation easy to perform

*/

/*
> Stored functions enable you to simplify your applications
> Stored functions also enable you to use more complex algorithmic constructs than are available 
when you write a calculation inline within an expression

EXAMPLE:
> Different states in the US charge different rates for sales tax
1) Define the rate-lookup function, sales_tax_rate()

2) Try the function to check whether the tax rate is returned correctly

3) If you take sales from a location not listed in the table, the function cannot determine
the rate for it. In this case, the function assumes a tax rate of 0 percent
*/
1)
CREATE FUNCTION sales_tax_rate(state_code CHAR(2))
RETURNS DECIMAL(3,2) READS SQL DATA
BEGIN
	DECLARE rate DECIMAL(3,2);
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET rate = 0;
	SELECT tax_rate INTO rate FROM sales_tax_rate WHERE state = state_code;
	RETURN rate;
END;

2)
mysql> SELECT sales_tax_rate('VT'), sales_tax_rate('NY');

3)
mysql> SELECT sales_tax_rate('ZZ');


/*
1) To compute sales tax for a purchase, multiply the purchase price by the tax rate. 
	>> npr. for Vermont and New York, tax on a $150 purchase is
	
2) Or write another function that computes the tax for you
3) And use it like this
*/
1)
mysql> SELECT 150*sales_tax_rate('VT'), 150*sales_tax_rate('NY');

2)
CREATE FUNCTION sales_tax(state_code CHAR(2), sales_amount DECIMAL(10,2))
RETURNS DECIMAL(10,2) READS SQL DATA
RETURN sales_amount * sales_tax_rate(state_code);
3)
mysql> SELECT sales_tax('VT',150), sales_tax('NY',150);
