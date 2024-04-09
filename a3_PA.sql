-- a3_PA.sql
-- Winter 2024 Assignment 3
-- Revision History:
-- Pretty Antony, Section 2, 2024.03.25: Created
-- Pretty Antony, Section 2, 2024.03.26: Updated

Print 'W24 PROG8081 Section 2';
Print 'Assignment 3';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

USE SIS;

-- 1
Print '*** Question 1 ***';
Print '';

SELECT	[Person].[number], 
		[Person].[birthdate]
		FROM [dbo].[Person]
		WHERE [Person].[birthdate] =(
									SELECT MAX([Person].[birthdate])
									FROM [dbo].[Person]
									);

-- 2
Print '*** Question 2 ***';
Print '';

SELECT [Person].[number] AS [Student Number],
       LEFT([Person].[lastName], 20) AS [Last Name],
       LEFT([Person].[firstName], 20) AS [First Name],
       [Person].[provinceCode] AS Province,
       [Person].[countryCode] AS Country
	   FROM [dbo].[Person]
	   WHERE [Person].[countryCode] IN ('USA', 'CAN')
	   AND [Person].[provinceCode] <> 'ON'
	   AND [Person].[number]  IN	(
									SELECT [Student].[number]
									FROM [dbo].[Student]
									WHERE [Student].[localCountryCode] IN ('USA', 'CAN')
									)
		ORDER BY LastName ASC, FirstName ASC;

-- 3
Print '*** Question 3 ***';
Print '';

SELECT	[Course].[number] AS [Course Number],
		[Course].[hours] AS [Hours],
		[Course].[credits] AS [Credits],
		[Course].[name] AS [Program Name]
		FROM [dbo].[Course]
		WHERE [Course].[number] IN (
									SELECT [ProgramCourse].[courseNumber]
									FROM [dbo].[ProgramCourse]
									WHERE [ProgramCourse].[semester] = 1 
									AND [ProgramCourse].[programCode] = (
																		SELECT [Program].[code]
																		FROM [dbo].[Program]
																		WHERE [Program].[acronym] = 'ITSS'
																		)
									)
		ORDER BY [Course Number] ASC;

-- 4
Print '*** Question 4 ***';
Print '';

SELECT	[Person].[number] AS [Student Number],
		[Person].[firstName] AS [First Name],
		[Person].[lastName] AS [Last Name]
		FROM [dbo].[Person]
		WHERE [Person].[number] IN	(
									SELECT [Student].[number]
									FROM [dbo].[Student]
									WHERE [Student].[isInternational] = 1 
									AND [Student].[number] IN	(
																SELECT [StudentProgram].[studentNumber]
																FROM [dbo].[StudentProgram]
																WHERE [StudentProgram].[programStatusCode] = 'A' 
																AND [StudentProgram].[programCode] =	(
																										SELECT [Program].[code]
																										FROM [dbo].[Program]
																										WHERE [Program].[credentialCode] =	(
																																			SELECT [Credential].[code]
																																			FROM [dbo].[Credential]
																																			WHERE [Credential].[name] = 'Ontario College Graduate Certificate'
																																			)
																										)
																)
									)
		ORDER BY [Student Number];

-- 5
Print '*** Question 5 ***';
Print '';

DELETE FROM [dbo].[Person]
WHERE [Person].[firstName] = 'Mary' AND [Person].[lastName] = 'Taneja';

DELETE FROM [dbo].[Course]
WHERE [Course].[number] IN ('BUS9070', 'LIBS9010');

-- 6
Print '*** Question 6 ***';
Print '';

INSERT INTO [dbo].[Person]
           ([number]
           ,[lastName]
           ,[firstName]
           ,[street]
           ,[city]
           ,[countryCode]
           ,[postalCode]
           ,[mainPhone]
           ,[alternatePhone]
           ,[collegeEmail]
           ,[personalEmail]
           ,[birthdate])
     VALUES
           ('7424478'
           ,'TANEJA'
           ,'MARY'
           ,'FLAT NO. 206 TRIVENI APARTMENTS PITAM PURA'
           ,'NEW DELHI'
           ,'IND'
           ,'110034'
           ,'0141-6610242'
           ,'94324060195'
           ,'mtaneja@conestogac.on.ca'
           ,'mtaneja@bsnl.co.in?'
           ,'October 7 1989');

SELECT * 
		FROM [dbo].[Person]
		WHERE [Person].[number] = '7424478';

-- 7
Print '*** Question 7 ***';
Print '';

INSERT INTO [dbo].[Student]
           ([number]
           ,[isInternational]
           ,[academicStatusCode]
           ,[financialStatusCode]
           ,[sequentialNumber]
           ,[balance]
           ,[localStreet]
           ,[localCity]
           ,[localProvinceCode]
           ,[localCountryCode]
           ,[localPostalCode]
           ,[localPhone])
     VALUES
           ('7424478'
           ,1
           ,'N'
           ,'N'
           ,0
           ,1130.00
           ,'445 GIBSON ST N'
           ,'Kitchener'
           ,'ON'
           ,'CAN'
           ,'N2M 4T4'
           ,'(226) 147-2985');

SELECT [Student].[number]
      ,[Student].[isInternational]
      ,[Student].[academicStatusCode]
      ,[Student].[financialStatusCode]
      ,[Student].[sequentialNumber]
      ,[Student].[balance]
      ,[Student].[localStreet]
      ,[Student].[localCity]
      ,[Student].[localPostalCode]
  FROM [dbo].[Student]
  WHERE [Student].[number] = '7424478';

-- 8
Print '*** Question 8 ***';
Print '';

INSERT INTO [dbo].[StudentProgram]
           ([studentNumber]
           ,[programCode]
           ,[semester]
           ,[programStatusCode])
     VALUES
           ('7424478'
           ,(
			SELECT [Program].[code]
			FROM [dbo].[Program]
			WHERE [Program].[acronym] = 'CAD'
			)
           ,1
           ,'A');

SELECT [StudentProgram].[studentNumber]
      ,[StudentProgram].[programCode]
      ,[StudentProgram].[semester]
      ,[StudentProgram].[programStatusCode]
  FROM [dbo].[StudentProgram]
  WHERE [StudentProgram].[studentNumber] = '7424478';

-- 9
Print '*** Question 9 ***';
Print '';

INSERT INTO [dbo].[CourseStudent]
           ([CourseOfferingId]
           ,[studentNumber]
           ,[finalMark])
     VALUES
           ((
		   SELECT [CourseOffering].[id]
		   FROM [dbo].[CourseOffering]
		   WHERE [CourseOffering].[courseNumber] = 'INFO8000' 
		   AND [CourseOffering].[sessionCode] = 'F20')
           ,'7424478'
           ,0);

SELECT [CourseStudent].[CourseOfferingId]
      ,[CourseStudent].[studentNumber]
      ,[CourseStudent].[finalMark]
  FROM [dbo].[CourseStudent]
  WHERE [CourseStudent].studentNumber = '7424478';

-- 10
Print '*** Question 10 ***';
Print '';

INSERT INTO [dbo].[Course]
           ([number]
           ,[hours]
           ,[credits]
           ,[name]
           ,[frenchName])
     VALUES
           ('LIBS9010'
           ,45
           ,3
           ,'Critical Thinking Skills'
           ,'Pensée Critique');

SELECT *
  FROM [dbo].[Course]
  WHERE [Course].[number] = 'LIBS9010';

-- 11
Print '*** Question 11 ***';
Print '';

INSERT INTO [dbo].[Course]
     VALUES
           ('BUS9070'
           ,45
           ,3
           ,'Introduction To Human Relations'
           ,'Introduction aux relations humaines');

SELECT *
  FROM [dbo].[Course]
  WHERE [Course].[number] = 'BUS9070';

-- 12
Print '*** Question 12 ***';
Print '';

UPDATE	[dbo].[IncidentalFee] 
		SET [IncidentalFee].[amountPerSemester] = 100.00 
		WHERE [IncidentalFee].[id] =	(
										SELECT	[IncidentalFee].[id]
										FROM [dbo].[IncidentalFee]
										WHERE [IncidentalFee].[item] = 'Technology Enhancement Fee'
										);

BEGIN TRANSACTION;

UPDATE	[dbo].[IncidentalFee] 
		SET [IncidentalFee].[amountPerSemester] = 120.00 
		WHERE [IncidentalFee].[id] =	(
										SELECT	[IncidentalFee].[id]
										FROM [dbo].[IncidentalFee]
										WHERE [IncidentalFee].[item] = 'Technology Enhancement Fee'
										);

ROLLBACK;

SELECT	*
		FROM [dbo].[IncidentalFee]
		WHERE [IncidentalFee].[item] = 'Technology Enhancement Fee';

-- 13
Print '*** Question 13 ***';
Print '';

BEGIN TRANSACTION;

UPDATE	[dbo].[IncidentalFee] 
		SET [IncidentalFee].[amountPerSemester] = 190.00 
		WHERE [IncidentalFee].[item] = 'Technology Enhancement Fee';

COMMIT;

SELECT	*
		FROM [dbo].[IncidentalFee]
		WHERE [IncidentalFee].[item] = 'Technology Enhancement Fee';