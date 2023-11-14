--Project Team 20 (SQL Queries for Database Implementation)

-- Create Loyalty Program table
CREATE TABLE LoyaltyProgram (
    id INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customer(id)
);


-- Create Customer table
CREATE TABLE Customer (
    id INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Street VARCHAR(50),
    ZipCode VARCHAR(20),
    Gender VARCHAR(50)
);

ALTER TABLE Customer
ADD Username VARCHAR(20);

ALTER TABLE Customer
ADD Password VARCHAR(200);

-- Create Order table
CREATE TABLE CustomerOrder(
    id INT PRIMARY KEY IDENTITY(1,1),
    CustomerID INT,
    StoreId INT,
    OrderStatus VARCHAR(20),
    OrderType VARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customer(id),
    FOREIGN KEY (StoreId) REFERENCES Store(id)
);

-- Create Store table
CREATE TABLE Store (
    id INT PRIMARY KEY IDENTITY(1,1),
    StoreStreet VARCHAR(50),
    StoreZipCode VARCHAR(20)
);

ALTER TABLE Store ALTER Column StoreZipcode INT NOT NULL;

-- Create Order Rating table
CREATE TABLE OrderRating (
    id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    Rating DECIMAL(2,1),
    WillRefer VARCHAR(50),
    FOREIGN KEY (OrderId) REFERENCES CustomerOrder(id)
);

-- Create Order Details table
CREATE TABLE OrderDetails (
    id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    ProductId INT,
    Quantity INT,
    TotalPrice DECIMAL(8,2),
    OrderDate DATETIME,
    FOREIGN KEY (OrderId) REFERENCES CustomerOrder(id),
    FOREIGN KEY (ProductId) REFERENCES Product(id)
);

-- Create Product table
CREATE TABLE Product (
    id INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    SubCategory VARCHAR(50),
    Brand VARCHAR(50),
    Quantity INT,
    Price DECIMAL(8,2)
);

-- Create Payment table
CREATE TABLE Payment (
    id INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT,
    PayAmount DECIMAL(8,2),
    PayMethod VARCHAR(20),
    PayStatus VARCHAR(50)
    FOREIGN KEY (OrderId) REFERENCES CustomerOrder(id)
);

-- Create Product In Store table
CREATE TABLE ProductInStore (
    id INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT,
    StoreId INT,
    Quantity INT,
    Price DECIMAL(8,2),
    DiscountedPrice DECIMAL(5,2),
    FOREIGN KEY (StoreId) REFERENCES Store(id),
    FOREIGN KEY (ProductId) REFERENCES Product(id)
);

-- Create Store Order table
CREATE TABLE StoreOrder (
    id INT PRIMARY KEY IDENTITY(1,1),
    StoreId INT,
    InventoryId INT,
    ProductId INT,
    SQuantity INT,
    date DATETIME,
    TotalPrice DECIMAL(8,2)
    FOREIGN KEY (StoreId) REFERENCES Store(id),
    FOREIGN KEY (InventoryId) REFERENCES Inventory(id),
    FOREIGN KEY (ProductId) REFERENCES Product(id)
);

-- Create Customer Product Rating table
CREATE TABLE CustomerProductRating (   
    id INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT,
    ReviewID INT,
    FOREIGN KEY (CustomerId) REFERENCES Customer(id),
    FOREIGN KEY (ReviewID) REFERENCES ProductRating(id)
);

-- Create Product Rating table
CREATE TABLE ProductRating (
    id INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT,
    Rating DECIMAL(2,1),
    FOREIGN KEY (ProductId) REFERENCES Product(id)
);

-- Create Product In Inventory table
CREATE TABLE ProductInInventory (
    id INT PRIMARY KEY IDENTITY(1,1),
    InventoryId INT,
    ProductId INT,
    FOREIGN KEY (InventoryId) REFERENCES Inventory(id),
    FOREIGN KEY (ProductId) REFERENCES Product(id)
);

-- Create Inventory table
CREATE TABLE Inventory (
    id INT PRIMARY KEY IDENTITY(1,1),
    InventoryStreet VARCHAR(50),
    InventoryZip VARCHAR(20)
);

ALTER TABLE Inventory ALTER Column InventoryZip INT NOT NULL;


-- To select each table to view

SELECT * FROM LoyaltyProgram;
SELECT * FROM Customer;
SELECT * FROM CustomerOrder;
SELECT * FROM Store;
SELECT * FROM OrderRating;
SELECT * FROM OrderDetails;
SELECT * FROM Product;
SELECT * FROM Payment;
SELECT * FROM ProductInStore;
SELECT * FROM StoreOrder;
SELECT * FROM CustomerProductRating;
SELECT * FROM ProductRating;
SELECT * FROM ProductInInventory;
SELECT * FROM Inventory;

-- Insert data in Product Table

INSERT INTO Product (ProductName, Category, SubCategory, Brand, Quantity, Price) 
VALUES 
('Aspirin 81mg', 'Healthcare', 'Pain Relievers', 'Bayer', 2, 3.99),
('Ibuprofen Tablets', 'Healthcare', 'Pain Relievers', 'Advil', 5, 2.49),
('Acetaminophen Extra Strength', 'Healthcare', 'Pain Relievers', 'Tylenol', 5, 6.99),
('Loratadine Allergy Relief', 'Healthcare', 'Allergy Medication', 'Claritin', 5, 4.99),
('Amoxicillin Antibiotic', 'Healthcare', 'Antibiotics', 'Generic', 5, 3.99),
('Albuterol Asthma Inhaler', 'Healthcare', 'Asthma Treatment', 'Ventolin', 5, 6.99),
('Simvastatin Cholesterol Med', 'Healthcare', 'Cholesterol Meds', 'Zocor', 5, 0.99),
('Metformin Diabetes Medication', 'Healthcare', 'Diabetes Treatment', 'Glucophage', 5, 1.49),
('Omeprazole Acid Reducer', 'Healthcare', 'Digestive Health', 'Prilosec', 5, 2.99),
('Cetirizine Allergy Relief', 'Healthcare', 'Allergy Medication', 'Zyrtec', 5, 3.49),
('Insulin Aspart', 'Healthcare', 'Diabetes Treatment', 'NovoLog', 5, 2.99),
('Triamcinolone Cream', 'Healthcare', 'Skin Treatment', 'Kenalog', 5, 4.99),
('Hydrochlorothiazide Blood Pressure', 'Healthcare', 'Blood Pressure', 'HydroDiuril', 5, 2.99),
('Salbutamol Inhaler', 'Healthcare', 'Asthma Treatment', 'ProAir', 5, 3.49),
('Fluticasone Nasal Spray', 'Healthcare', 'Allergy Medication', 'Flonase', 5, 8.99),
('Oxymetazoline Nasal Spray', 'Healthcare', 'Nasal Care', 'Afrin', 5, 4.99),
('Atorvastatin Cholesterol Med', 'Healthcare', 'Cholesterol Meds', 'Lipitor', 5, 1.49),
('Cephalexin Antibiotic', 'Healthcare', 'Antibiotics', 'Keflex', 5, 4.99),
('Furosemide Diuretic', 'Healthcare', 'Diuretics', 'Lasix', 5, 3.49),
('Multivitamin Tablets', 'Healthcare', 'Vitamins', 'Centrum', 5, 1.99);

--Column Data Encryption for the Password Field in Customer Table

UPDATE Customer
SET Password = ENCRYPTBYPASSPHRASE('Dmdd@123', Password);

-- Drop the original Password column
ALTER TABLE Customer ADD EncryptPass varchar(20);

-- Rename the EncryptedPassword column to Password
EXEC sp_rename 'Customer.Password', 'Password', 'COLUMN';


INSERT INTO Customer (FirstName, LastName, Street, ZipCode, Gender, Username, Password)
VALUES
    ('Aarav', 'Sharma', '123 Main St', '400001', 'Male', 'aaravsharma', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password123')),
    ('Diya', 'Patel', '456 Oak St', '400002', 'Female', 'diyapatel', ENCRYPTBYPASSPHRASE('Dmdd@123', 'qwerty123')),
    ('Kabir', 'Singh', '789 Maple St', '400003', 'Male', 'kabirsingh', ENCRYPTBYPASSPHRASE('Dmdd@123', 'hello123')),
    ('Neha', 'Gupta', '345 Pine St', '400004', 'Female', 'nehagupta', ENCRYPTBYPASSPHRASE('Dmdd@123', 'letmein123')),
    ('Aryan', 'Kumar', '678 Elm St', '400005', 'Male', 'aryankumar', ENCRYPTBYPASSPHRASE('Dmdd@123', 'pass1234')),
    ('Kavya', 'Shah', '890 Walnut St', '400006', 'Female', 'kavyashah', ENCRYPTBYPASSPHRASE('Dmdd@123', 'abc123')),
    ('Rahul', 'Joshi', '234 Cedar St', '400007', 'Male', 'rahuljoshi', ENCRYPTBYPASSPHRASE('Dmdd@123', 'qwertyui')),
    ('Priya', 'Chopra', '567 Pine St', '400008', 'Female', 'priyachopra', ENCRYPTBYPASSPHRASE('Dmdd@123', '123456')),
    ('Riya', 'Mehta', '123 Oak St', '400009', 'Female', 'riyamehta', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password')),
    ('Aditya', 'Trivedi', '456 Maple St', '400010', 'Male', 'adityatrivedi', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password1')),
    ('Anaya', 'Patil', '789 Elm St', '400011', 'Female', 'anayapatil', ENCRYPTBYPASSPHRASE('Dmdd@123', 'test123')),
    ('Kunal', 'Sharma', '345 Walnut St', '400012', 'Male', 'kunalsharma', ENCRYPTBYPASSPHRASE('Dmdd@123', 'testtest')),
    ('Isha', 'Shukla', '678 Cedar St', '400013', 'Female', 'ishashukla', ENCRYPTBYPASSPHRASE('Dmdd@123', 'testing123')),
    ('Rishi', 'Jain', '890 Pine St', '400014', 'Male', 'rishijain', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password1234')),
    ('Sakshi', 'Rao', '234 Oak St', '400015', 'Female', 'sakshirao', ENCRYPTBYPASSPHRASE('Dmdd@123', '12345678')),
    ('Vikram', 'Iyer', '567 Maple St', '400016', 'Male', 'vikramiyer', ENCRYPTBYPASSPHRASE('Dmdd@123', 'passw0rd')),
    ('Sneha', 'Srinivasan', '123 Elm St', '400017', 'Female', 'sneha', ENCRYPTBYPASSPHRASE('Dmdd@123', 'pass123')),
    ('Aditi', 'Sharma', 'Kalkaji', '110019', 'Female', 'aditis', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password')),
    ('Anjali', 'Singh', 'Vikaspuri', '110018', 'Female', 'anjalisingh', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password')),
    ('Arjun', 'Kumar', 'Pitampura', '110034', 'Male', 'arjunk', ENCRYPTBYPASSPHRASE('Dmdd@123', 'password'));

-- Insert data in Store Table

INSERT INTO Store (StoreStreet, StoreZipCode)
VALUES
('Boylston St', '02116'),
('Newbury St', '02116'),
('Charles St', '02114'),
('Hanover St', '02113'),
('Atlantic Ave', '02110'),
('Congress St', '02210'),
('Beacon St', '02108'),
('Tremont St', '02111'),
('Harrison Ave', '02118'),
('Comm Ave', '02215'),
('Boylston St', '02215'),
('Brookline Ave', '02215'),
('Brighton Ave', '02134'),
('Park St', '02108'),
('Dartmouth St', '02116'),
('Commonwealth Ave', '02116'),
('Massachusetts Ave', '02115'),
('Charles River Esplanade', '02108'),
('Cambridge St', '02114'),
('Washington St', '02108');

-- Insert data in ProductInStore Table

INSERT INTO ProductInStore (ProductId, StoreId, Quantity, Price, DiscountedPrice)
VALUES 
    (1, 1, 10, 20.00, 18.00),
    (1, 2, 20, 20.00, 16.00),
    (2, 1, 5, 15.50, 12.40),
    (2, 3, 15, 15.50, 14.00),
    (3, 2, 8, 10.99, 9.00),
    (3, 4, 12, 10.99, 9.99),
    (4, 1, 4, 5.00, 4.00),
    (4, 3, 6, 5.00, 4.50),
    (5, 2, 10, 8.75, 7.50),
    (5, 4, 20, 8.75, 7.25),
    (6, 1, 15, 12.99, 10.99),
    (6, 3, 25, 12.99, 11.99),
    (7, 2, 30, 18.50, 15.00),
    (7, 4, 40, 18.50, 16.00),
    (8, 1, 3, 25.00, 20.00),
    (8, 3, 7, 25.00, 22.50),
    (9, 2, 12, 30.00, 25.00),
    (9, 4, 18, 30.00, 28.00),
    (10, 1, 5, 40.00, 35.00),
    (10, 2, 8, 40.00, 36.00);

-- Insert data in CustomerProductRating Table

INSERT INTO CustomerProductRating (CustomerId, ReviewID)
VALUES (1, 3), 
       (2, 1), 
       (3, 2), 
       (4, 6), 
       (5, 7),
       (6, 9), 
       (7, 11), 
       (8, 12), 
       (9, 16), 
       (10, 18),
       (11, 20), 
       (12, 23), 
       (13, 25), 
       (14, 28), 
       (15, 30),
       (16, 32), 
       (17, 35), 
       (18, 36), 
       (19, 38), 
       (20, 40);

-- Insert data in Inventory Table

INSERT INTO Inventory (InventoryStreet, InventoryZip)
VALUES 
('10 Main St', '02108'),
('55 Elm St', '02109'),
('123 High St', '02110'),
('234 Maple Ave', '02111'),
('99 Water St', '02112'),
('777 Beacon St', '02113'),
('333 Boylston St', '02114'),
('22 Newbury St', '02115'),
('456 Commonwealth Ave', '02116'),
('987 Tremont St', '02117'),
('111 Huntington Ave', '02118'),
('444 Marlborough St', '02119'),
('888 Columbus Ave', '02120'),
('222 Harvard St', '02121'),
('555 Massachusetts Ave', '02122'),
('999 Cambridge St', '02123'),
('333 Washington St', '02124'),
('444 Causeway St', '02125'),
('777 Dorchester Ave', '02126'),
('123 Roxbury St', '02127');

-- Insert data in LoyaltyProgram Table

INSERT INTO LoyaltyProgram (CustomerID) VALUES (1);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (2);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (3);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (4);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (5);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (6);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (7);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (8);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (9);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (10);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (11);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (12);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (13);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (14);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (15);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (16);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (17);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (18);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (19);
INSERT INTO LoyaltyProgram (CustomerID) VALUES (20);


-- Insert data in ProductInInventory Table

INSERT INTO ProductInInventory (InventoryId, ProductId)
VALUES (1, 1), (1, 3), (1, 5), (2, 2), (2, 4),
       (2, 6), (3, 1), (3, 4), (3, 7), (4, 2),
       (4, 5), (4, 8), (5, 3), (5, 6), (5, 9),
       (6, 4), (6, 7), (6, 10), (7, 5), (7, 8);

-- Insert data in ProductRating Table

INSERT INTO ProductRating (ProductId, Rating)
VALUES 
    (1, 4.5),
    (2, 3.2),
    (3, 4.8),
    (4, 2.7),
    (5, 3.9),
    (6, 4.2),
    (7, 3.6),
    (8, 4.9),
    (9, 2.1),
    (10, 4.0),
    (11, 3.7),
    (12, 4.5),
    (13, 2.8),
    (14, 4.2),
    (15, 4.3),
    (16, 3.5),
    (17, 4.6),
    (18, 3.9),
    (19, 2.9),
    (20, 4.1);


--Triggers Created

CREATE TRIGGER NewOrderTrigger
ON CustomerOrder
AFTER INSERT
AS
BEGIN
  SET NOCOUNT ON;

  DECLARE @OrderID INT;
  SET @OrderID = (SELECT id FROM inserted);

  -- Insert random product details into OrderDetails table
  INSERT INTO OrderDetails (OrderId, ProductId, Quantity, TotalPrice, OrderDate)
  SELECT @OrderID, id, FLOOR(RAND()(10-1)+1), Price * FLOOR(RAND()(10-1)+1), GETDATE()
  FROM Product 
  ORDER BY NEWID() 
  OFFSET 0 ROWS 
  FETCH NEXT 5 ROWS ONLY;

  -- Update TotalPrice in Payment table
  INSERT INTO Payment (OrderId, PayAmount, PayMethod, PayStatus)
  SELECT @OrderID, SUM(TotalPrice), 'Credit Card', 'Done'
  FROM OrderDetails
  WHERE OrderId = @OrderID;

  -- Update Quantity in ProductInStore table
  IF NOT EXISTS (
    SELECT *
    FROM OrderDetails OD
    WHERE OD.OrderId = @OrderID
    AND NOT EXISTS (
      SELECT *
      FROM ProductInStore PIS
      WHERE PIS.ProductId = OD.ProductId
      AND PIS.Quantity >= OD.Quantity
    )
  )
  BEGIN
    PRINT 'Error: One or more products are not available in the store.';
    ROLLBACK TRANSACTION;
    RETURN;
  END;

  UPDATE PIS
  SET Quantity = PIS.Quantity - OD.Quantity
  FROM ProductInStore PIS
  JOIN OrderDetails OD ON PIS.ProductId = OD.ProductId
  WHERE OD.OrderId = @OrderID
  AND PIS.Quantity >= OD.Quantity;

  -- Check for products with negative quantity
  IF EXISTS (
    SELECT *
    FROM ProductInStore
    WHERE Quantity < 0
  )
  BEGIN
    PRINT 'Error: Quantity of one or more products has gone below zero.';
    ROLLBACK TRANSACTION;
    RETURN;
  END;

END;

CREATE TRIGGER CalculateTotalPriceTrigger
ON StoreOrder
FOR INSERT
AS
BEGIN
  SET NOCOUNT ON;

  -- Update TotalPrice column in inserted rows
  UPDATE SO
  SET TotalPrice = P.Price * SO.Quantity
  FROM StoreOrder SO
  JOIN Product P ON SO.ProductId = P.id
  JOIN inserted I ON SO.id = I.id;
END;

CREATE TRIGGER StoreOrderTrigger
ON StoreOrder
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @ApprovedStatus VARCHAR(20) = 'Approved';
    DECLARE @RejectedStatus VARCHAR(20) = 'Rejected';
    
    IF UPDATE(OrderStatus) AND EXISTS (
        SELECT *
        FROM inserted i
        INNER JOIN deleted d ON i.id = d.id
        WHERE i.OrderStatus = @ApprovedStatus AND d.OrderStatus != @ApprovedStatus
    )
    BEGIN
        DECLARE @OrderID INT = (SELECT id FROM inserted);
        DECLARE @ProductID INT = (SELECT ProductId FROM inserted);
        DECLARE @Quantity INT = (SELECT Quantity FROM inserted);
        
        -- Check if the product is available in inventory
        IF NOT EXISTS (
            SELECT *
            FROM Product as p
            JOIN
            ProductInInventory as PI
            ON p.id = PI.productId
            WHERE PI.InventoryId = (SELECT InventoryId FROM inserted)
            AND ProductId = @ProductID
            AND Quantity >= @Quantity
        )
        BEGIN
            PRINT 'Error: The product is not available in inventory.';
            ROLLBACK TRANSACTION;
            RETURN;
        END;
        
        -- Update the quantity in the ProductInStore table
        UPDATE ProductInStore
        SET Quantity = Quantity + @Quantity
        WHERE ProductId = @ProductID;
         
        -- Update the quantity in the Product table
        UPDATE Product
        SET Quantity = Quantity - @Quantity
        WHERE id = @ProductID;
    END
    ELSE IF UPDATE(OrderStatus) AND EXISTS (
        SELECT *
        FROM inserted i
        INNER JOIN deleted d ON i.id = d.id
        WHERE i.OrderStatus = @RejectedStatus AND d.OrderStatus != @RejectedStatus
    )
    BEGIN
        PRINT 'Order has been rejected. No action needed.';
    END
END;

-- 2 Views created

-- View of of CustomerOrderDetails

CREATE VIEW CustomerOrderDetails AS
SELECT
    CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
    c.Street AS CustomerStreet,
    c.ZipCode AS CustomerZipCode,
    s.StoreStreet AS StoreStreet,
    s.StoreZipCode AS StoreZipCode,
    co.OrderStatus,
    co.OrderType,
    od.OrderDate,
    p.ProductName,
    od.Quantity,
    od.TotalPrice
FROM
    Customer c
    JOIN CustomerOrder co ON c.id = co.CustomerID
    JOIN Store s ON co.StoreId = s.id
    JOIN OrderDetails od ON co.id = od.OrderId
    JOIN Product p ON od.ProductId = p.id;

---- View of ProductSalesByStore

CREATE VIEW ProductSalesByStore AS
SELECT Store.StoreStreet, Product.ProductName, SUM(OrderDetails.Quantity) AS TotalQuantity, SUM(OrderDetails.TotalPrice) AS TotalPrice
FROM Store
JOIN ProductInStore ON Store.id = ProductInStore.StoreId
JOIN Product ON ProductInStore.ProductId = Product.id
JOIN OrderDetails ON Product.id = OrderDetails.ProductId
JOIN CustomerOrder ON OrderDetails.OrderId = CustomerOrder.id
WHERE CustomerOrder.OrderStatus = 'Complete'
GROUP BY Store.id, Store.StoreStreet, Product.ProductName;



Select * FROM CustomerOrderDetails;
Select * FROM ProductSalesByStore;


--Computed columns based on function

--Function to Calculate Discounted Price

CREATE FUNCTION CalculateDiscountedPrice (@Price DECIMAL(8,2), @DiscountPercentage INT)
RETURNS DECIMAL(5,2)
AS
BEGIN
  DECLARE @DiscountedPrice DECIMAL(5,2)
  SET @DiscountedPrice = @Price - (@Price * @DiscountPercentage / 100)
  RETURN @DiscountedPrice
END;

--Table-level CHECK Constraints based on a function

CREATE FUNCTION fn_CheckQuantityInStore (@Quantity INT)
RETURNS BIT
AS
BEGIN
    DECLARE @Result BIT = 1;
    IF @Quantity < 0
        SET @Result = 0;
    RETURN @Result;
END;

ALTER TABLE ProductInStore
ADD CONSTRAINT CK_ProductInStore_Quantity CHECK (dbo.fn_CheckQuantityInStore(Quantity) = 1);

Select * from ProductInStore
