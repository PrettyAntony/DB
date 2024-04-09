-- a4_PA.sql
-- Winter 2024 Assignment 4
-- Revision History:
-- Pretty Antony, Section 2, 2024.04.07: Created
-- Pretty Antony, Section 2, 2024.04.07: Updated

Print 'W24 PROG8081 Section 2';
Print 'Assignment 4';
Print '';
Print 'Pretty Antony';
Print '';
Print GETDATE();
Print '';

-- 1
Print '*** Question 1 ***';
Print '';

DROP DATABASE IF EXISTS SWC_PA;

CREATE DATABASE SWC_PA;

USE SWC_PA;

-- 2
Print '*** Question 2 ***';
Print '';

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1)
	);

CREATE TABLE PartTypes (
    PartTypeID INT IDENTITY(1,1)
);

CREATE TABLE Parts (
    PartID INT IDENTITY(1,1) 
);

CREATE TABLE Purchasers (
    PurchaserID INT IDENTITY(1,1) 
);

CREATE TABLE Purchases (
    PurchaseID INT IDENTITY(1,1) 
);

CREATE TABLE DesktopBundles (
    BundleID INT IDENTITY(1,1) 
);

CREATE TABLE BundleParts (
    BundlePartID INT IDENTITY(1,1) 
);

-- 3
Print '*** Question 3 ***';
Print '';

ALTER TABLE Suppliers
ADD SupplierName VARCHAR(255);

ALTER TABLE PartTypes
ADD PartTypeName VARCHAR(255);

ALTER TABLE Parts
ADD PartNumber VARCHAR(255),
    SupplierID INT,
    PartTypeID INT,
    PartDescription VARCHAR(255),
    UnitPrice DECIMAL(10,2);

ALTER TABLE Purchasers
ADD FirstName VARCHAR(255),
    LastName VARCHAR(255),
    Email VARCHAR(255),
    StreetNumber VARCHAR(50),
    StreetName VARCHAR(255),
    City VARCHAR(255),
    Province VARCHAR(255),
    Country VARCHAR(255),
    PostalCode VARCHAR(20),
    MainPhone VARCHAR(20),
	OtherPhone VARCHAR(20);

ALTER TABLE Purchases
ADD PartID INT,
    PurchaserID INT,
    PurchaseDate DATE,
    Quantity INT;

ALTER TABLE DesktopBundles
ADD BundleName VARCHAR(255),
    Brand VARCHAR(50),
    BundleType VARCHAR(50);

ALTER TABLE BundleParts
ADD BundleID INT,
    PartID INT;

-- 4
Print '*** Question 4 ***';
Print '';

ALTER TABLE Suppliers
ADD CONSTRAINT PK_Suppliers PRIMARY KEY (SupplierID);

ALTER TABLE PartTypes
ADD CONSTRAINT PK_PartTypes PRIMARY KEY (PartTypeID);

ALTER TABLE Parts
ADD CONSTRAINT PK_Parts PRIMARY KEY (PartID);

ALTER TABLE Purchasers
ADD CONSTRAINT PK_Purchasers PRIMARY KEY (PurchaserID);

ALTER TABLE Purchases
ADD CONSTRAINT PK_Purchases PRIMARY KEY (PurchaseID);

ALTER TABLE DesktopBundles
ADD CONSTRAINT PK_DesktopBundles PRIMARY KEY (BundleID);

ALTER TABLE BundleParts
ADD CONSTRAINT PK_BundleParts PRIMARY KEY (BundlePartID);

-- 5
Print '*** Question 5 ***';
Print '';

ALTER TABLE Parts
ADD CONSTRAINT FK_Parts_SupplierID FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID);

ALTER TABLE Parts
ADD CONSTRAINT FK_Parts_PartTypeID FOREIGN KEY (PartTypeID) REFERENCES PartTypes(PartTypeID);

ALTER TABLE Purchases
ADD CONSTRAINT FK_Purchases_PartID FOREIGN KEY (PartID) REFERENCES Parts(PartID);

ALTER TABLE Purchases
ADD CONSTRAINT FK_Purchases_PurchaserID FOREIGN KEY (PurchaserID) REFERENCES Purchasers(PurchaserID);

ALTER TABLE BundleParts
ADD CONSTRAINT FK_BundleParts_BundleID FOREIGN KEY (BundleID) REFERENCES DesktopBundles(BundleID);

ALTER TABLE BundleParts
ADD CONSTRAINT FK_BundleParts_PartID FOREIGN KEY (PartID) REFERENCES Parts(PartID);

-- 6
Print '*** Question 6 ***';
Print '';

ALTER TABLE Purchasers
ADD CONSTRAINT CK_Purchaser_FirstName_Length CHECK (LEN(FirstName) >= 3);

ALTER TABLE Parts
ADD CONSTRAINT CK_Part_Description_Length CHECK (LEN(PartDescription) >= 3),
    CONSTRAINT CK_Part_UnitPrice_NonNegative CHECK (UnitPrice >= 0);

ALTER TABLE Purchases
ADD CONSTRAINT CK_Purchases_Quantity_Positive CHECK (Quantity > 0);

SELECT 
    t.name AS TableName,
    CASE 
        WHEN pk.name IS NOT NULL THEN 'PK: ' + pk.name
        WHEN fk.name IS NOT NULL THEN 'FK: ' + fk.name
        WHEN ck.name IS NOT NULL THEN 'CK: ' + ck.name
        ELSE ''
    END AS ConstraintName
FROM 
    sys.tables t
LEFT JOIN 
    sys.key_constraints pk ON t.object_id = pk.parent_object_id AND pk.type = 'PK'
LEFT JOIN 
    sys.foreign_keys fk ON t.object_id = fk.parent_object_id
LEFT JOIN 
    sys.check_constraints ck ON t.object_id = ck.parent_object_id;

-- 7
Print '*** Question 7 ***';
Print '';

ALTER TABLE Purchasers
ADD CONSTRAINT DF_Purchaser_Country DEFAULT 'Canada' FOR Country;

SELECT 
    name AS DefaultConstraintName,
    definition AS DefaultConstraintDefinition
FROM 
    sys.default_constraints
WHERE 
    parent_object_id = OBJECT_ID('Purchasers');

-- 8
Print '*** Question 8 ***';
Print '';

INSERT INTO Suppliers
VALUES
    ('Dell'),
    ('HP'),
    ('Samsung'),
    ('Lenovo'),
    ('Max');

INSERT INTO PartTypes
VALUES
    ('Desktop'),
    ('Monitor'),
    ('Tablet'),
    ('Keyboard'),
    ('Mouse'),
    ('Camera');

INSERT INTO Parts (PartNumber, SupplierID, PartTypeID, PartDescription, UnitPrice)
VALUES
    ('DL1010', 1, 1, 'Dell Optiplex 1010', 40.00),
    ('DL5040', 1, 1, 'Dell Optiplex 5040', 150.00),
    ('DLM190', 1, 2, 'Dell 19-inch Monitor', 35.00),
    ('HP400', 2, 1, 'HP Desktop Tower', 60.00),
    ('HP800', 2, 1, 'HP EliteDesk 800G1', 200.00),
    ('HPM270', 2, 2, 'HP 27-inch Monitor', 120.00),
    ('SM330', 3, 3, 'Samsung Galaxy Tab 7” Android Tablet', 110.00),
    ('LEN101', 4, 4, 'Lenovo 101-Key Computer Keyboard', 7.00),
    ('LEN102', 4, 5, 'Lenovo Mouse', 5.00),
    ('DLM240', 1, 2, 'Dell 24-inch Monitor', 80.00),
    ('HPM220', 2, 2, 'HP 22-inch Monitor', 45.00),
    ('MAX901', 5, 6, 'Max Web Camera', 20.00),
    ('HP501', 2, 4, 'HP 101-Key Computer Keyboard', 9.00),
    ('HP502', 2, 5, 'HP Mouse', 6.00);

INSERT INTO Purchasers (FirstName)
VALUES
    ('Joey'),
    ('May'),
    ('Troy'),
    ('Vinh');

INSERT INTO Purchases (PartID, PurchaserID, PurchaseDate, Quantity)
VALUES
    (1, 1, '2022-10-31', 25),
    (2, 1, '2022-10-31', 50),
    (3, 1, '2022-10-31', 25),
    (4, 2, '2022-11-10', 15),
    (5, 2, '2022-11-20', 20),
    (6, 2, '2022-11-20', 20),
    (7, 3, '2022-11-30', 10),
    (8, 4, '2022-12-05', 50),
    (9, 4, '2022-12-05', 50),
    (10, 4, '2022-12-05', 80),
    (11, 1, '2022-12-10', 30),
    (9, 4, '2022-12-15', 100),
    (12, 2, '2022-12-15', 40),
    (13, 3, '2022-12-20', 100),
    (14, 3, '2022-12-20', 100);

INSERT INTO DesktopBundles ( BundleName, Brand, BundleType)
VALUES
    ('Dell Eco', 'Dell', 'Economy'),
    ('Dell Biz', 'Dell', 'Business'),
    ('HP Eco', 'HP', 'Economy'),
    ('HP Biz', 'HP', 'Business');

INSERT INTO BundleParts (BundleID, PartID)
VALUES
     (1, 1), 
	 (2, 2),
	 (1, 3),
	 (3, 4), 
	 (4, 5),
	 (4, 6),
	 (1, 8),
	 (2, 8), 
	 (1, 9),   
	 (2, 9), 
	 (2, 10),
	 (3, 11),
	 (4, 12),
	 (3, 13), 
     (4, 13),
	 (3, 14),   
	 (4, 14);

-- 9
Print '*** Question 9 ***';
Print '';

CREATE INDEX IX_Purchaser_Phone ON Purchasers(MainPhone);

CREATE UNIQUE INDEX IX_Purchaser_Email ON Purchasers(Email) WHERE Email IS NOT NULL;

--Test
INSERT INTO Purchasers (FirstName, Email)
VALUES ('John', 'joey@example.com');

-- 10
Print '*** Question 10 ***';
Print '';

CREATE VIEW PurchaseDetailsView AS
SELECT p.PartNumber,
       s.SupplierName,
       pt.PartTypeName,
       p.PartDescription,
       pu.FirstName,
       pu.Email,
       pu.Country,
       pur.PurchaseDate,
       p.UnitPrice,
       pur.Quantity,
       p.UnitPrice * pur.Quantity AS [Extended Amount]
FROM Purchases pur
JOIN Parts p ON pur.PartID = p.PartID
JOIN Suppliers s ON p.SupplierID = s.SupplierID
JOIN PartTypes pt ON p.PartTypeID = pt.PartTypeID
JOIN Purchasers pu ON pur.PurchaserID = pu.PurchaserID;

SELECT *
FROM PurchaseDetailsView
ORDER BY FirstName, PurchaseDate, PartNumber;

-- 11
Print '*** Question 11 ***';
Print '';

CREATE VIEW DesktopBundleCostView AS
SELECT db.BundleName,
       SUM(p.UnitPrice * pur.Quantity) AS TotalCost
FROM BundleParts bp
JOIN Parts p ON bp.PartID = p.PartID
JOIN Purchases pur ON p.PartID = pur.PartID
JOIN DesktopBundles db ON bp.BundleID = db.BundleID
GROUP BY db.BundleName;

SELECT *
FROM DesktopBundleCostView
ORDER BY BundleName;

SELECT name AS ViewName
FROM sys.views;

-- 12
Print '*** Question 12 ***';
Print '';

--Database Diagram created
-- Refer A4_DBDiagram_PA.docx