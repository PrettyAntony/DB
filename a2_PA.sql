-- a2_PA.sql
-- Winter 2024 Assignment 2
-- Revision History:
-- Pretty Antony, Section 2, 2024.02.09: Created
-- Pretty Antony, Section 2, 2024.02.11: Updated

Print 'W24 PROG8081 Section 2';
Print 'Assignment 2';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

USE SIS;

-- 1
Print '*** Question 1 ***';
Print '';

SELECT	p.[schoolCode]
		,p.[code]
		,pc.[courseNumber]
		,pc.[semester]
  FROM [dbo].[Program] AS p,
  [dbo].[ProgramCourse] AS pc
  WHERE p.[code] = '0066C' AND p.[code] = pc.[programCode]
  ORDER BY pc.[semester],pc.[courseNumber];

-- 2
Print '*** Question 2 ***';
Print '';

SELECT cpa.[courseNumber] AS [Course Code]
      ,cpa.[prerequisiteNumber] AS [Prereq]
	  ,c.[name] AS [Prereq Course Name]
  FROM [dbo].[Course] AS c
  ,[dbo].[CoursePrerequisiteAnd] AS cpa
  WHERE cpa.[prerequisiteNumber] = c.[number] AND cpa.[courseNumber] = 'COMP2280'
  ORDER BY [Prereq] DESC;

-- 3
Print '*** Question 3 ***';
Print '';
 
 SELECT DISTINCT p.[number]
      ,p.[firstName]
	  ,p.[lastName]
      ,p.[city]
  FROM [dbo].[Person] AS p LEFT OUTER JOIN [dbo].[Student] AS s
  ON p.[number] = s.[number]
  WHERE s.[number] IS NULL
  ORDER BY p.[lastName];

-- 4
Print '*** Question 4 ***';
Print '';

SELECT s.[uniqueId], s.[product]
	FROM	[dbo].[LabSoftware] AS ls INNER JOIN
	[dbo].[Room] AS r ON ls.[roomId] = r.[id] INNER JOIN
	[dbo].[Software] AS s ON ls.[softwareUniqueId] = s.[uniqueId]
	WHERE r.[number] = '2A205'
	ORDER BY s.[product];

-- 5
Print '*** Question 5 ***';
Print '';

SELECT e1.[number] AS [Employee]
	,e1.[reportsTo] AS [Supervisor]
	,e2.[reportsTo] AS [Supervisor Reports To]
	FROM [dbo].[Employee] AS e1 LEFT OUTER JOIN [dbo].[Employee] AS e2
	ON (e1.[reportsTo] = e2.[number])
	ORDER BY e1.[reportsTo];

-- 6
Print '*** Question 6 ***';
Print '';

SELECT co.[courseNumber] AS [Course]
		,CAST(MIN(cs.[finalMark]) AS DECIMAL(10, 0)) AS [Lowest Mark]
		,CAST(AVG(cs.[finalMark]) AS DECIMAL(10, 0)) AS [Average Mark]
		,CAST(MAX(cs.[finalMark]) AS DECIMAL(10, 0)) AS [Highest Mark]
		FROM	[dbo].[CourseOffering] AS co INNER JOIN [dbo].[CourseStudent] AS cs
		ON co.[id] = cs.[CourseOfferingId]
		WHERE co.[sessionCode] = 'W10'
		GROUP BY co.[courseNumber]; 

-- 7
Print '*** Question 7 ***';
Print '';

SELECT	p.[number] AS [Employee]
		,LEFT(p.[lastName], 3) + RIGHT(p.[number],3) AS [User ID]
		,count(p.[number]) as [# Courses Taught]
		FROM     [dbo].[Person] AS p INNER JOIN [dbo].[Employee] AS e 
		ON p.[number] = e.[number] INNER JOIN [dbo].[CourseOffering]  AS co 
		ON e.[number] = co.[employeeNumber]
		WHERE co.[sessionCode] LIKE '%08' OR co.[sessionCode] LIKE '%09' AND e.[schoolCode] = 'EIT'
		GROUP BY p.[number],p.[lastName]
		ORDER BY [User ID];

-- 8
Print '*** Question 8 ***';
Print '';

SELECT p.[acronym] as [Program]
      ,p.[name] as [Program Name]
	  ,FORMAT((sum(pf.[tuition])+sum(pf.[tuition]*pf.[coopFeeMultiplier])) , '$###,###.00') as [Total Fees]
	  FROM [dbo].[Program] AS p LEFT JOIN [dbo].[ProgramFee] AS pf
	  ON p.[code] = pf.[code]
	  WHERE p.[name] LIKE '%(coop)'
	  GROUP BY p.[code],p.[acronym],p.[name]
	  ORDER BY [Program Name];

-- 9
Print '*** Question 9 ***';
Print '';

 SELECT p.[number] AS [Student Number]
		,p.[lastName] AS [Last Name]
		,p.[firstName] AS [First Name]
		,SUM(py.[amount]) AS [Total Payment Amount]
		FROM     [dbo].[Person] as p LEFT JOIN [dbo].[Payment] AS py 
		ON p.[number] = py.[studentNumber] LEFT JOIN [dbo].[PaymentMethod] AS pm 
		ON py.[paymentMethodId] = pm.[id]
		WHERE pm.[id] IN (2,3) 
		GROUP BY p.[number],p.[lastName],p.[firstName]
		HAVING SUM(py.[amount]) >= 10000
		ORDER BY [Total Payment Amount] DESC;