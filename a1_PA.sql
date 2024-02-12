-- a1_PA.sql
-- Winter 2024 Assignment 1
-- Revision History:
-- Pretty Antony, Section 2, 2024.01.27: Created
-- Pretty Antony, Section 2, 2024.01.28: Updated

Print 'W24 PROG8081 Section 2';
Print 'Assignment 1';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

USE SIS;

-- 1
Print '*** Question 1 ***';
Print '';

SELECT *
  FROM [dbo].[AcademicStatus]

-- 2
Print '*** Question 2 ***';
Print '';

SELECT [number]
      ,[academicStatusCode]
  FROM [dbo].[Student]
  WHERE [academicStatusCode] = 'D'
  ORDER BY [number] DESC;

-- 3
Print '*** Question 3 ***';
Print '';

SELECT [number]
      ,[academicStatusCode]
  FROM [dbo].[Student]
  WHERE [academicStatusCode] <> 'N'
  ORDER BY [number] ASC;

-- 4
Print '*** Question 4 ***';
Print '';

SELECT DISTINCT [provinceCode]
  FROM [dbo].[Person]
  ORDER BY [provinceCode] DESC;

-- 5
Print '*** Question 5 ***';
Print '';

SELECT DISTINCT [provinceCode]
  FROM [dbo].[Person]
  WHERE [provinceCode] IS NOT NULL;

-- 6
Print '*** Question 6 ***';
Print '';

SELECT [number]
      ,[lastName]
      ,[firstName]
      ,[city]
      ,[countryCode]
  FROM [dbo].[Person]
  WHERE [provinceCode]  IS NULL;

-- 7
Print '*** Question 7 ***';
Print '';

SELECT [number]
      ,[lastName]
      ,[firstName]
      ,[city]
      ,[countryCode]
  FROM [dbo].[Person]
  WHERE firstName  LIKE 'AND_';

-- 8
Print '*** Question 8 ***';
Print '';

SELECT *
  FROM [dbo].[Program]
  WHERE [name] LIKE 'Computer%'

-- 9
Print '*** Question 9 ***';
Print '';

SELECT [code]
      ,[acronym]
      ,[name]
  FROM [dbo].[Program]
  WHERE [name] LIKE '%coop%'

-- 10
Print '*** Question 10 ***';
Print '';

SELECT *
  FROM [dbo].[CourseStudent]
  WHERE [finalMark] BETWEEN 1 AND 54;

-- 11
Print '*** Question 11 ***';
Print '';

SELECT [number]
      ,[capacity]
      ,[memory]
  FROM [dbo].[Room]
  WHERE [capacity] >= 40 AND [isLab] = 1 AND [memory] = '4GB' AND [campusCode] = 'D';

-- 12
Print '*** Question 12 ***';
Print '';

SELECT *
  FROM [dbo].[Employee]
  WHERE [schoolCode] = 'TAP' AND [campusCode] IN ('D','G','W');

-- 13
Print '*** Question 13 ***';
Print '';

SELECT [lastName]
	  ,LOWER(LEFT(firstName,1) + LEFT(lastName,7)) as UserID
  FROM [dbo].[Person]
  WHERE LEFT([lastName],1) = 'J'
  ORDER BY UserID DESC;

-- 14
Print '*** Question 14 ***';
Print '';

--Option 1
--Since 2 entries have DOB in January, it is showing 7 rows affected.
SELECT [number]
	  ,FORMAT ( [birthdate], 'MMMM dd, yyyy') as dob
	  ,DATEDIFF(YEAR,[birthdate],GETDATE()) as age
  FROM [dbo].[Person]
  WHERE (DATEDIFF(YEAR,[birthdate],GETDATE())) > 60;

--Option 2
--For fetching only 5 rows, 'TOP 5' query is used on 'age' which is sorted by 'descenting' order.

  SELECT TOP 5 [number]
	  ,FORMAT ( [birthdate], 'MMMM dd, yyyy') as dob
	  ,DATEDIFF(YEAR,[birthdate],GETDATE()) as age
  FROM [dbo].[Person]
  WHERE (DATEDIFF(YEAR,[birthdate],GETDATE())) > 60
  ORDER BY age DESC;

-- 15
Print '*** Question 15 ***';
Print '';

SELECT [number] as CourseCode
      ,[name] as CourseName
  FROM [dbo].[Course]
  WHERE CHARINDEX('Game', [name]) > 0;

-- 16
Print '*** Question 16 ***';
Print '';

SELECT [item] as IncidentalFeeItem
		,'$' + CONVERT(CHAR(12), CAST([amountPerSemester] AS MONEY),1) as  CurrentFee
		,'$' + CONVERT(CHAR(12), CAST(([amountPerSemester]+([amountPerSemester]*0.1)) AS MONEY),1) as  IncreasedFee
  FROM [dbo].[IncidentalFee]
  ORDER BY CurrentFee ASC;