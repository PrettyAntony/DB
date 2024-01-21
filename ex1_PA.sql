-- ex1_PA.sql
-- Winter 2024 Exercise 1
-- Revision History:
-- Pretty Antony, Section 2, 2024.01.19: Created
-- Pretty Antony, Section 2, 2024.01.19: Updated

Print 'W24 PROG8081 Section 2';
Print 'Exercise 1';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

USE AP;

-- 1
Print '*** Question 1 ***';
Print '';

SELECT * 
FROM Terms;

-- 2
Print '*** Question 2 ***';
Print '';
SELECT DISTINCT VendorState 
FROM Vendors
ORDER BY VendorState DESC;

-- 3
Print '*** Question 3 ***';
Print '';
SELECT *
FROM Vendors
WHERE VendorState = 'TX';

-- 4
Print '*** Question 4 ***';
Print '';
SELECT *
FROM Invoices
WHERE VendorID = 83;

-- 5
Print '*** Question 5 ***';
Print '';
SELECT [InvoiceID]
      ,[VendorID]
      ,[InvoiceTotal]
	  ,[CreditTotal]
      ,[PaymentTotal]
  FROM [dbo].[Invoices]
  WHERE [InvoiceID] = 17;

-- 6
Print '*** Question 6 ***';
Print '';
SELECT [VendorID]
      ,[VendorName]
      ,[DefaultTermsID]    
	, [VendorCity] + ', ' + [VendorState] + ', ' + [VendorZipCode]
FROM [dbo].[Vendors]
WHERE [VendorID] = 123;

-- 7
Print '*** Question 7 ***';
Print '';
SELECT [VendorID]
	  ,[TermsID]
	  ,[InvoiceID]
      ,[InvoiceTotal]
      ,[CreditTotal]
	  ,[PaymentTotal]
      ,[InvoiceTotal] - [PaymentTotal] - [CreditTotal] AS BalanceDue
  FROM [dbo].[Invoices]
  WHERE [VendorID] = 123 AND ([InvoiceTotal] - [PaymentTotal] - [CreditTotal]) > 0;

-- 8
Print '*** Question 8 ***';
Print '';
SELECT *
  FROM [dbo].[InvoiceLineItems]
  WHERE [InvoiceID] IN (94,99,100,101);

-- 9
Print '*** Question 9 ***';
Print '';
SELECT [VendorState]
      ,[VendorContactFName] as FirstName
	  ,LEN([VendorContactFName]) as LengthOfName
	  ,LOWER([VendorContactFName]) as LowerCase
	  ,UPPER([VendorContactFName]) as UpperCase
	  ,LEFT([VendorContactFName],3) as FirstThreeLetters
	  ,RIGHT([VendorContactFName],3) as LastThreeLetters
	  ,TRIM([VendorContactFName]) as TrimmedName
  FROM [dbo].[Vendors]
  WHERE [VendorState] = 'FL' OR [VendorState] = 'TX';

-- 10
Print '*** Question 10 ***';
Print '';
SELECT [InvoiceNumber]
	  ,FORMAT ( [InvoiceDate], 'yyyy.MM.dd') as InvoiceDate
	  ,'$' + CONVERT(CHAR(12), CAST([InvoiceTotal] AS MONEY),1) as  InvoiceTotal
  FROM [dbo].[Invoices]
WHERE MONTH([InvoiceDate]) = 1 AND 
      DAY([InvoiceDate]) = 8 AND 
      YEAR([InvoiceDate]) = 2020;