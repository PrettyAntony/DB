-- ex3_PA.sql
-- Winter 2024 Exercise 3
-- Revision History:
-- Pretty Antony, Section 2, 2024.03.16: Created
-- Pretty Antony, Section 2, 2024.03.17: Updated

Print 'W24 PROG8081 Section 2';
Print 'Exercise 3';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

USE AP;

-- 1
Print '*** Question 1 ***';
Print '';

SELECT i.[InvoiceNumber], v.[VendorName]
	FROM	[dbo].[Vendors] AS v,
	[dbo].[Invoices] AS i 
	WHERE v.[VendorID] = i.[VendorID] AND v.[VendorName] = 'Compuserve';

-- 2
Print '*** Question 2 ***';
Print '';

SELECT i.[InvoiceNumber], 
		v.[VendorID], 
		v.[VendorName], 
		i.[InvoiceDueDate], 
		i.[InvoiceTotal] - i.[PaymentTotal] AS [Balance Due]
	FROM	[dbo].[Invoices] AS i INNER JOIN [dbo].[Vendors] AS v 
	ON i.[VendorID] = v.[VendorID] 
	WHERE i.[InvoiceTotal] - i.[PaymentTotal] > 500
	ORDER BY [Balance Due] ASC;

-- 3
Print '*** Question 3 ***';
Print '';

SELECT [Vendors].[VendorID], 
		[Vendors].[VendorName], 
		[Invoices].[InvoiceNumber], 
		[Invoices].[InvoiceTotal]
		FROM	Vendors  LEFT OUTER JOIN Invoices
		ON  Vendors.VendorID = Invoices.VendorID 
		WHERE [Vendors].[VendorName] LIKE 'in%'
		ORDER BY [Vendors].[VendorName] DESC;

-- 4
Print '*** Question 4 ***';
Print '';

SELECT 'After 12/31/2018' AS [Selection Date],
		MIN([Invoices].[InvoiceTotal]) AS [Lowest Invoice Total],
		MAX([Invoices].[InvoiceTotal]) AS [Highest Invoice Total]
		FROM [dbo].[Invoices]
		WHERE [Invoices].[InvoiceDate] > '2018-12-31';

-- 5
Print '*** Question 5 ***';
Print '';

SELECT	[Vendors].[VendorState] AS [Vendor State],
		[Vendors].[VendorCity] AS [Vendor City], 
		COUNT([Invoices].[InvoiceTotal]) AS [Invoice Qty],
		'$' + CONVERT(CHAR(10), CAST(AVG([Invoices].[InvoiceTotal]) AS money),1) AS [Avg Amount]
		FROM [dbo].[Invoices] INNER JOIN [dbo].[Vendors] ON [Invoices].[VendorID] = [Vendors].[VendorID]
		GROUP BY [Vendors].[VendorState], [Vendors].[VendorCity]
		ORDER BY [Vendors].[VendorState], [Vendors].[VendorCity];

-- 6
Print '*** Question 6 ***';
Print '';

SELECT [Invoices].[InvoiceDate],
		COUNT([Invoices].[InvoiceTotal]) AS [Invoice Qty],
		SUM([Invoices].[InvoiceTotal]) AS [Invoice Sum]
		FROM [dbo].[Invoices]
		WHERE MONTH([Invoices].[InvoiceDate]) = 12 AND YEAR([Invoices].[InvoiceDate]) = 2019
		GROUP BY [Invoices].[InvoiceDate]
		HAVING COUNT([Invoices].[InvoiceTotal]) > 2 AND SUM([Invoices].[InvoiceTotal]) > 1000
		ORDER BY [Invoices].[InvoiceDate] DESC;

-- 7
Print '*** Question 7 ***';
Print '';

SELECT	[Invoices].[InvoiceNumber],
		[Invoices].[InvoiceDate],
		[Invoices].[InvoiceTotal]
		FROM [dbo].[Invoices]
		WHERE [Invoices].[VendorID] =	(
										SELECT [Vendors].[VendorID]
										FROM [dbo].[Vendors]
										WHERE [Vendors].[VendorState] = 'TX'
										)
		ORDER BY [Invoices].[InvoiceDate] DESC;

-- 8
Print '*** Question 8 ***';
Print '';

SELECT i.[VendorID],i.[InvoiceNumber],i.[InvoiceTotal]
	FROM [dbo].[Invoices] AS i
	WHERE i.[InvoiceTotal] > 1000 
	AND i.[InvoiceTotal] > (
							SELECT AVG([Invoices].[InvoiceTotal])
							FROM [dbo].[Invoices]
							WHERE [Invoices].[VendorID] = i.[VendorID]
							)
	ORDER BY i.[VendorID] ASC, i.[InvoiceTotal] DESC;

-- 9
Print '*** Question 9 ***';
Print '';

SELECT v.[VendorName],
		(
        SELECT MAX([Invoices].[InvoiceDate]) 
        FROM [dbo].[Invoices] 
        WHERE [Invoices].[VendorID] = v.[VendorID]
		) AS "Latest Invoice Date"
		FROM [dbo].[Vendors] AS v
		WHERE v.[VendorName] LIKE 'C%'
		GROUP BY v.[VendorName], v.[VendorID]
		ORDER BY "Latest Invoice Date" ASC;

