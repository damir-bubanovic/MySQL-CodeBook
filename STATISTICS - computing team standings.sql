/*

!!STATISTICS - COMPUTING TEAM STANDINGS!!

> You want to compute team standings from their win-loss records, including the gamesbehind
(GB) values

> Determine which team is in first place, then join that result to the original rows

*/

/*
> The first example uses a table containing a single set of team records to illustrate the
logic of the calculations. 
> The second example uses a table containing several sets of records

EXAMPLE:
1) Consider the following table, standings1, which contains a single set of baseball team
records representing the final standings for the Northern League in the year 1902

> The rows are sorted by the win-loss differential, which is how to place teams in order
from first place to last place. But displays of team standings typically include each team’s
winning percentage and a figure indicating how many games behind the leader all the
other teams are

2) Calculating the percentage - ratio of wins to total games played

3) This expression involves division by zero when a team has not played any games yet.
For simplicity, I’ll assume a nonzero number of games. To handle this condition, you’d
use a more general expression
*/
1)
mysql> SELECT team, wins, losses FROM standings1
	-> ORDER BY wins-losses DESC;
	
2)
wins / (wins + losses)

3)
IF(wins=0,0,wins/(wins+losses))

/*
> Determining the games-behind value
	> It’s based on the relationship of the win-loss records for two teams, calculated as 
	the average of two values:
		• How many more wins the first-place team has than the second-place team
		• How many fewer losses the first-place team has than the second-place team
*/