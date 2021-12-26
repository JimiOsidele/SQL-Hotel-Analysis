  /*


	Project:

			Develop a Database to analyze and visualize Hotel Booking Data.

	Task:
			Build a data story or dashboard using Power BI to present to stakeholders for business decisions

			1. Is our hotel revenue growing by year? 
			2. Should we increase our parking lot size?
			3. What trends can we see in the data?

	Pipelines:
				
	Step 1: Build a database and import data.
	Step 2:	Develop SQL Queries.
	Step 3: Connect database to Power BI.
	Step 4:	Visualizations and Summarizations.
	Step 5: Publish Dashboard to service.

	*/

	--- Let's see all tables at once

	Select * From dbo.Hotel2018
	Select * From dbo.Hotel2019
	Select * From dbo.Hotel2020


	--- Let's unify these tables by using UNION

	Select * From dbo.Hotel2018
	UNION 
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020

	--- We will create a TEMP TABLE/ SUB Queries using the Select statements from above


	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select * FROM Hotels


	--- Qusetion 1: Is our Hotel revenue growing by year?
	--- We will create a DERIVED COLUMN to display revenue
	--- We will add two columns stays_in_weekends_nights + stay_in_week_nights

	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select stays_in_weekend_nights + stays_in_week_nights
	FROM Hotels


	--- Let's ALIAS the column name as Revenue

	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select stays_in_weekend_nights + stays_in_week_nights AS Revenue
	FROM Hotels


	--- Let's multiply this by


	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select (stays_in_weekend_nights + stays_in_week_nights) *adr AS Revenue
	FROM Hotels

	--- Let's see if Revenue is growing by Year using the Arrival Date Year


	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select arrival_date_year,
	(stays_in_weekend_nights + stays_in_week_nights) *adr AS Revenue
	FROM Hotels



	--- Let's GROUP BY and SUM 

	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select arrival_date_year,

	ROUND(SUM((stays_in_weekend_nights + stays_in_week_nights) *adr),2) AS Revenue
	FROM Hotels
	GROUP BY arrival_date_year

	
	--- Let's break it down by Hotel types


	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select arrival_date_year, hotel,

	ROUND(SUM((stays_in_weekend_nights + stays_in_week_nights) *adr),2) AS Revenue
	FROM Hotels
	GROUP BY arrival_date_year, hotel
	ORDER BY arrival_date_year

	
	--- Let's JOIN this TEMP with rest of other tables


	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select * FROM Hotels 

	--- ROUND(SUM((stays_in_weekend_nights + stays_in_week_nights) *adr),2) AS Revenue

	JOIN
	dbo.market_segment
	ON

	Hotels.market_segment = market_segment.market_segment


	--- Let's JOIN this to Meal Cost Table


	
	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select * FROM Hotels 

	--- ROUND(SUM((stays_in_weekend_nights + stays_in_week_nights) *adr),2) AS Revenue

	LEFT JOIN
	dbo.market_segment
	ON

	Hotels.market_segment = market_segment.market_segment

	LEFT JOIN
	dbo.meal_cost

	ON
	meal_cost.meal = Hotels.meal


	--- Let's take this query into Power BI


	WITH Hotels AS

	(
	Select * From dbo.Hotel2018
	UNION
	Select * From dbo.Hotel2019
	UNION
	Select * From dbo.Hotel2020
	)

	Select * FROM Hotels 

	LEFT JOIN
	dbo.market_segment
	ON

	Hotels.market_segment = market_segment.market_segment

	LEFT JOIN
	dbo.meal_cost

	ON
	meal_cost.meal = Hotels.meal



--- QUERY TO GET DATEOFBIRTH IN SQL

  DATEDIFF(yy, dob, GETDATE()) + (CASE WHEN DATEPART(MONTH, GETDATE()) - DATEPART(MONTH, dob) < 0 THEN -1 ELSE 0 END )  Age





