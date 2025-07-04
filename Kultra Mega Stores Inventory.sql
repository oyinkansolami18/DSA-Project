
--Kultra Mega Stores Inventory

 --product category with highest sales
 select TOP 1
		[Product Category], 
		SUM(sales) as total_sales
from ['KMS_Sql_Case_Study(1)$']
Group By 
		[Product Category]
Order By
		total_sales DESC

--TOP 3 REGIONS BY SALES
select TOP 3
		Region, 
		SUM(sales) as total_sales
from ['KMS_Sql_Case_Study(1)$']
Group By 
		Region
Order By
		total_sales DESC



--BOTTOM 3 REGIONS BY SALES
select TOP 3
		Region, 
		SUM(sales) as total_sales
from ['KMS_Sql_Case_Study(1)$']
Group By 
		Region
Order By
		total_sales 

-- total sales of appliances in Ontario
select 
		Region,
		[Product Sub-Category],
		SUM(sales) as total_sales

from ['KMS_Sql_Case_Study(1)$']

WHERE 
	[Product Sub-Category]= 'Appliances' 
	AND Region = 'Ontario'

GROUP BY 
		Region,
		[Product Sub-Category]




--KMS on what to do to increase the revenue from the bottom 10 customers
SELECT TOP 10
			[Customer Name],
			SUM(sales) as total_sales	
FROM ['KMS_Sql_Case_Study(1)$']
Group By 
		[Customer Name]
Order By
		total_sales 

-- HIGHEST SHIPPING COST
SELECT TOP 1
			[Ship Mode],
			SUM([Shipping Cost]) AS Total_shipcost
FROM ['KMS_Sql_Case_Study(1)$']
Group By 
		[Ship Mode]
Order By
	Total_shipcost DESC

-- MOST VALUABLE CUSTOMERS
SELECT TOP 10
			[Customer Name],
		[Product Sub-Category],
			SUM(sales) as total_sales	
FROM ['KMS_Sql_Case_Study(1)$']
Group By 
		[Customer Name],
		[Product Sub-Category]

Order By
		total_sales DESC

-- HIGHEST SMALL BUSINESS CUSTOMER

SELECT TOP 1
			[Customer Name],
		[Customer Segment],
			SUM(sales) as total_sales	
FROM ['KMS_Sql_Case_Study(1)$']

WHERE [Customer Segment] = 'SMALL BUSINESS'
Group By 
		[Customer Name],
		 [Customer Segment] 
Order By
		total_sales DESC

--  Corporate Customer placed the most number of orders in 2009 – 2012
SELECT 
	[Customer Segment],
	COUNT([Order ID]) As Total_Orders,
	DATEPART(YEAR, [Order Date]) As Order_Year

FROM 
	['KMS_Sql_Case_Study(1)$']

WHERE 
		DATEPART(YEAR, [Order Date]) BETWEEN 2009 AND 2012
Group By 
		DATEPART(YEAR, [Order Date]),[Customer Segment]
HAVING 
		
		[Customer Segment] = 'Corporate'
Order By
		DATEPART(YEAR, [Order Date]);

--consumer customer was the most profitable one
SELECT TOP 1
			[Customer Name],
		[Customer Segment],
			SUM(sales) as total_sales	
FROM ['KMS_Sql_Case_Study(1)$']

WHERE [Customer Segment] = 'CONSUMER'
Group By 
		[Customer Name],
		 [Customer Segment] 
Order By
		total_sales DESC

-----customer returned items, and what segment do they belong to?
SELECT 
		[Customer Name],
		[Customer Segment],
		COUNT([Order ID]) AS ReturnCount,
		SUM(Profit) As TotalLoss 
FROM ['KMS_Sql_Case_Study(1)$']

WHERE Profit <0

Group By
	[Customer Name],[Customer Segment]

Order By 
	ReturnCount DESC;

-------Q11
SELECT 
	[Order Priority],
	[Ship Mode],
	COUNT([Order ID]) AS NumOrders,
	Avg([Shipping Cost]) As AvgShippingCost

FROM ['KMS_Sql_Case_Study(1)$']

Group By 
	[Order Priority],[Ship Mode]

Order By
	[Order Priority],[Ship Mode]

Findings:
	1.	High Priority Orders (Critical, High):
	•	Should be shipped using Express Air (fastest), even if expensive.
	•	However, most expensive shipping cost is via Delivery Truck (~$45–47), which is actually the slowest, and is being used for Critical and High orders.
	•	Express Air cost is only ~$8.7, yet it’s underused where it should be prioritized.
	2.	Low Priority Orders (Low, Medium, Not Specified):
	•	Should ideally be shipped via Delivery Truck to minimize cost.
	•	But most are shipped using Express Air and Regular Air, even though speed isn’t required.
	•	For example:
	•	Low Priority + Express Air = $8.17
	•	Not Specified + Express Air = $8.17
	•	These could have been handled more economically.


❌ Conclusion: Shipping cost allocation is not appropriate.
	•	The slowest method (Delivery Truck) is being used for Critical and High orders, despite its high cost, which defeats the urgency logic.
	•	Meanwhile, Express Air is used more for Low/Not Specified priority orders — where speed is not required, leading to unnecessary spending.
	•	This suggests inefficient logistics planning: neither speed nor cost optimization is aligned with order priority.


✅ Recommendation:
	•	Re-align shipping methods:
	•	Use Express Air only for Critical & High priority.
	•	Use Delivery Truck or Regular Air for Low/Medium/Not Specified to control cost.
	
