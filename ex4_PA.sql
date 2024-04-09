-- ex4_PA.sql
-- Winter 2024 Exercise 4
-- Revision History:
-- Pretty Antony, Section 2, 2024.03.30: Created
-- Pretty Antony, Section 2, 2024.03.30: Updated

Print 'W24 PROG8081 Section 2';
Print 'Exercise 4';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

USE AP;

-- 1
Print '*** Question 1 ***';
Print '';

IF EXISTS	(
			SELECT name
			FROM sysobjects
			WHERE name = 'VendorCopyPA'
			)
			DROP TABLE [dbo].[VendorCopyPA];

SELECT *
		INTO [dbo].[VendorCopyPA]
		FROM [dbo].[Vendors];

SELECT	COUNT(*) AS [Number of rows in VendorCopyPA]
		FROM [dbo].[VendorCopyPA];

-- 2
Print '*** Question 2 ***';
Print '';

IF EXISTS	(
			SELECT name
			FROM sysobjects
			WHERE name = 'InvoiceBalancesPA'
			)
			DROP TABLE [dbo].[InvoiceBalancesPA];


SELECT *
	INTO [dbo].[InvoiceBalancesPA]
	FROM [dbo].[Invoices]
	WHERE [Invoices].[InvoiceTotal]-([Invoices].[PaymentTotal]+[Invoices].[CreditTotal]) <> 0;

SELECT	COUNT(*) AS [Number of rows in InvoiceBalancesPA]
		FROM [dbo].[InvoiceBalancesPA];

-- 3
Print '*** Question 3 ***';
Print '';

INSERT INTO [dbo].[InvoiceBalancesPA]
	VALUES (
			86, 
			'4591178',
			'2022-09-01', 
			9345.60, 
			0, 
			0,
			1, 
			'2022-10-01', 
			NULL
			);

SELECT *
FROM [dbo].[InvoiceBalancesPA]
WHERE [InvoiceBalancesPA].[VendorID] = 86;

-- 4
Print '*** Question 4 ***';
Print '';

INSERT INTO [dbo].[InvoiceBalancesPA] 
			([InvoiceBalancesPA].[VendorID],
			[InvoiceBalancesPA].[InvoiceNumber],
			[InvoiceBalancesPA].[InvoiceTotal],
			[InvoiceBalancesPA].[PaymentTotal],
			[InvoiceBalancesPA].[CreditTotal], 
			[InvoiceBalancesPA].[TermsID],
			[InvoiceBalancesPA].[InvoiceDate],
			[InvoiceBalancesPA].[InvoiceDueDate])
			VALUES (
			30,
			'COSTCO345',
			2800.00, 
			0, 
			0, 
			1, 
			GETDATE(), 
			DATEADD(day, 30, GETDATE()));


SELECT * 
		FROM [dbo].[InvoiceBalancesPA]
		WHERE [InvoiceBalancesPA].[VendorID] = 30;

-- 5
Print '*** Question 5 ***';
Print '';

UPDATE	[dbo].[InvoiceBalancesPA]
		SET [InvoiceBalancesPA].[CreditTotal] = 300.00
		WHERE [InvoiceBalancesPA].[InvoiceNumber] = 'COSTCO345';

SELECT * 
		FROM [dbo].[InvoiceBalancesPA] 
		WHERE [InvoiceBalancesPA].[InvoiceNumber] = 'COSTCO345';

-- 6
Print '*** Question 6 ***';
Print '';

UPDATE	[dbo].[InvoiceBalancesPA]
		SET [InvoiceBalancesPA].[CreditTotal] = [InvoiceBalancesPA].[CreditTotal] + 90
		WHERE [InvoiceBalancesPA].[InvoiceID] IN	(
													SELECT TOP 5 [InvoiceBalancesPA].[InvoiceID]
													FROM [dbo].[InvoiceBalancesPA]
													WHERE [InvoiceBalancesPA].[InvoiceTotal] - [InvoiceBalancesPA].[PaymentTotal] - [InvoiceBalancesPA].[CreditTotal] > 900
													);

SELECT	[InvoiceBalancesPA].[InvoiceID], 
		[InvoiceBalancesPA].[InvoiceNumber], 
		[InvoiceBalancesPA].[VendorID],
		[InvoiceBalancesPA].[InvoiceTotal], 
		[InvoiceBalancesPA].[CreditTotal]
FROM [dbo].[InvoiceBalancesPA];

-- 7
Print '*** Question 7 ***';
Print '';

DELETE FROM [dbo].[InvoiceBalancesPA]
			WHERE [InvoiceBalancesPA].[InvoiceNumber] = '4591178';

SELECT	* 
		FROM [dbo].[InvoiceBalancesPA];

-- 8
Print '*** Question 8 ***';
Print '';

SELECT	COUNT(*) AS [VendorCopyPA Before Delete]
		FROM [dbo].[VendorCopyPA];

DELETE FROM [dbo].[VendorCopyPA]
			WHERE [VendorCopyPA].[VendorID] NOT IN	(
													SELECT DISTINCT [InvoiceBalancesPA].[VendorID]
													FROM [dbo].[InvoiceBalancesPA]
													);

SELECT	COUNT(*) AS [VendorCopyPA After Delete]
		FROM [dbo].[VendorCopyPA];

-- 9
Print '*** Question 9 ***';
Print '';

DECLARE @VendorID INT = 123;
DECLARE @RowCount INT;

BEGIN TRANSACTION;

DELETE FROM [dbo].[InvoiceBalancesPA]
			WHERE [InvoiceBalancesPA].[VendorID] = @VendorID;

SET @RowCount = @@ROWCOUNT;

IF @RowCount > 1
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'More invoices than expected. Deletions rolled back.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Deletion successful.';
END

SELECT COUNT(*) AS [Number of FedEx invoices]
		FROM [dbo].[InvoiceBalancesPA]
		WHERE [InvoiceBalancesPA].[VendorID] = @VendorID;

-- 10
Print '*** Question 10 ***';
Print '';

SELECT COUNT(*) AS [Number of Invoices] 
		FROM [dbo].[Invoices];
SELECT COUNT(*) AS [Number of InvoiceLineItems] 
		FROM [dbo].[InvoiceLineItems];

DECLARE @InvoiceID int;
BEGIN TRY
    BEGIN TRAN;
    INSERT Invoices
      VALUES (34,'ZXA-080','2020-03-01',14092.59,0,0,3,'2020-03-31',NULL);
    SET @InvoiceID = @@IDENTITY;
    INSERT InvoiceLineItems VALUES (@InvoiceID,1,160,4447.23,'HW upgrade');
    INSERT InvoiceLineItems
      VALUES (@InvoiceID,2,167,9645.36,'OS upgrade');
    COMMIT TRAN;
END TRY
BEGIN CATCH
    ROLLBACK TRAN;
END CATCH;

SELECT COUNT(*) AS [Number of Invoices] 
		FROM [dbo].[Invoices];
SELECT COUNT(*) AS [Number of InvoiceLineItems] 
		FROM [dbo].[InvoiceLineItems];

