
-- Create Database
CREATE DATABASE swp391;
GO
USE swp391;
GO

-- Image Table
CREATE TABLE Image (
    ImageID INT PRIMARY KEY IDENTITY(1,1),
    ImagePath VARCHAR(MAX) NOT NULL,
    ImageType NVARCHAR(50)  NOT NULL 
);
go
-- Account Table
CREATE TABLE Account (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    Email NVARCHAR(255) UNIQUE NOT NULL,
    Password NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(50) UNIQUE NOT NULL,
    Address NVARCHAR(255) NOT NULL,
    YearOfBirth INT CHECK (YearOfBirth >= 1900 AND YearOfBirth <= YEAR(GETDATE()) - 10),
    Gender NVARCHAR(10),
    Avatar INT FOREIGN KEY REFERENCES Image(ImageID),
    LoyaltyPoint INT DEFAULT 0,
    MembershipLevel NVARCHAR(50) CHECK (MembershipLevel IN ('None','Silver', 'Gold', 'Platitnum')) DEFAULT 'None',
    Status BIT NOT NULL,
    Role NVARCHAR(50) CHECK (Role IN ('Admin', 'Manager', 'Customer')) NOT NULL
);
go
-- Cinema Table
CREATE TABLE Cinema (
    CinemaID INT PRIMARY KEY IDENTITY(1,1),
    CinemaName NVARCHAR(255) NOT NULL,
    Address NVARCHAR(255) NOT NULL
);
go
-- CinemaRoom Table
CREATE TABLE CinemaRoom (
    RoomID INT PRIMARY KEY IDENTITY(1,1),
    CinemaID INT FOREIGN KEY REFERENCES Cinema(CinemaID) NOT NULL,
    RoomName NVARCHAR(255) NOT NULL,
    RoomType NVARCHAR(50) CHECK (RoomType IN ('Standard', 'VIP', 'IMAX')) NOT NULL,
    Status BIT NOT NULL
);
go
-- Movie Table
CREATE TABLE Movie (
    MovieID INT PRIMARY KEY IDENTITY(1,1),
    MovieName NVARCHAR(255) NOT NULL,
    Duration INT NOT NULL CHECK (Duration > 0),
    Genre NVARCHAR(100) NOT NULL,
    Director NVARCHAR(255) NOT NULL,
    ReleaseDate DATETIME NOT NULL,
    Description TEXT,
    Rate INT CHECK (Rate BETWEEN 0 AND 10),
    MoviePoster INT FOREIGN KEY REFERENCES Image(ImageID),
    TrailerURL NVARCHAR(MAX),
    BasePrice FLOAT NOT NULL CHECK (BasePrice > 0), -- Base ticket price for the movie
	Status nvarchar(25) NOT NULL Check (Status in ('NowShowing','UpcomingMovie','ShownMovie'))
);
go
-- Showtime Table
CREATE TABLE Showtime (
    ShowtimeID INT PRIMARY KEY IDENTITY(1,1),
    MovieID INT FOREIGN KEY REFERENCES Movie(MovieID) NOT NULL,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL
);
go
-- PricingFactor Table (to adjust ticket price)
CREATE TABLE PricingFactor (
    FactorID INT PRIMARY KEY IDENTITY(1,1),
    Type NVARCHAR(50) CHECK (Type IN ('Room', 'Seat')) NOT NULL,
    Category NVARCHAR(50) NOT NULL,
    Multiplier FLOAT NOT NULL CHECK (Multiplier > 0)
);
go
-- Seat Table
CREATE TABLE Seat (
    SeatID INT PRIMARY KEY IDENTITY(1,1),
    SeatRow NVARCHAR(10) NOT NULL,
    SeatNumber INT NOT NULL CHECK (SeatNumber > 0),
    SeatType NVARCHAR(50) CHECK (SeatType IN ('Standard', 'VIP')) NOT NULL,
    RoomID INT FOREIGN KEY REFERENCES CinemaRoom(RoomID) NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Available', 'Sold', 'Reserved')) NOT NULL
);
go
-- Combo Table
CREATE TABLE Combo (
    ComboID INT PRIMARY KEY IDENTITY(1,1),
    ComboItem NVARCHAR(255) NOT NULL,
	Description Text,
    Price FLOAT NOT NULL CHECK (Price > 0),
	Quantity int Default 0,
	Status bit default 1

);
go
-- Promotion Table
CREATE TABLE Promotion (
    PromotionID INT PRIMARY KEY IDENTITY(1,1),
    PromoCode NVARCHAR(50) UNIQUE NOT NULL,
    DiscountPercent INT NOT NULL CHECK (DiscountPercent BETWEEN 0 AND 100),
    StartDate DATE NOT NULL,
    EndTime DATE NOT NULL,
    Status BIT NOT NULL,
    Description TEXT,
	RemainRedemption INT NOT NULL DEFAULT 0
);
go
-- Ticket Table (Calculating the ticket price based on multipliers)
CREATE TABLE Ticket (
    TicketID INT PRIMARY KEY IDENTITY(1,1),
    SeatID INT FOREIGN KEY REFERENCES Seat(SeatID) NOT NULL,
    ShowTimeID INT FOREIGN KEY REFERENCES Showtime(ShowtimeID) NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Booked', 'Cancelled')) NOT NULL,
    PurchaseDate DATETIME NOT NULL,
    ComboID INT FOREIGN KEY REFERENCES Combo(ComboID),
    TicketPrice FLOAT DEFAULT 0
);
go
-- Transaction Table
CREATE TABLE [Transaction] (
    TransactionID INT PRIMARY KEY IDENTITY(1,1),
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Amount FLOAT  CHECK (Amount >= 0) DEFAULT 0,
    TicketID INT FOREIGN KEY REFERENCES Ticket(TicketID) NOT NULL,
    AccountID INT FOREIGN KEY REFERENCES Account(AccountID) NOT NULL,
    PromotionID INT FOREIGN KEY REFERENCES Promotion(PromotionID)
);

go
CREATE TRIGGER trg_UpdateTicketPrice
ON Ticket
AFTER INSERT
AS
BEGIN
    UPDATE T
    SET TicketPrice = M.BasePrice * PR.Multiplier * PS.Multiplier
    FROM Ticket T
    JOIN inserted I ON T.TicketID = I.TicketID
    JOIN Seat S ON I.SeatID = S.SeatID
    JOIN Showtime ST ON I.ShowTimeID = ST.ShowtimeID
    JOIN Movie M ON ST.MovieID = M.MovieID
    JOIN CinemaRoom CR ON S.RoomID = CR.RoomID
    JOIN PricingFactor PR ON PR.Type = 'Room' AND PR.Category = CR.RoomType
    JOIN PricingFactor PS ON PS.Type = 'Seat' AND PS.Category = S.SeatType;
END;

GO
CREATE TRIGGER trg_UpdateTransactionAmount
ON [Transaction]
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE T
    SET Amount = I.Quantity * TI.TicketPrice * (1 - COALESCE(P.DiscountPercent, 0) / 100.0)
    FROM [Transaction] T
    JOIN inserted I ON T.TransactionID = I.TransactionID
    JOIN Ticket TI ON I.TicketID = TI.TicketID
    LEFT JOIN Promotion P ON I.PromotionID = P.PromotionID;
END;



go
CREATE TRIGGER trg_UpdateLoyaltyAndMembership
ON [Transaction]
AFTER INSERT, UPDATE
AS
BEGIN
    -- Cập nhật điểm LoyaltyPoint
    UPDATE A
    SET A.LoyaltyPoint = A.LoyaltyPoint + CAST(I.Amount / 10000 AS INT)
    FROM Account A
    JOIN inserted I ON A.AccountID = I.AccountID;

    -- Cập nhật cấp độ thành viên dựa trên LoyaltyPoint mới
    UPDATE A
    SET A.MemberShipLevel =
        CASE 
            WHEN A.LoyaltyPoint <= 0 THEN 'None'
            WHEN A.LoyaltyPoint BETWEEN 1 AND 50 THEN 'Silver'
            WHEN A.LoyaltyPoint BETWEEN 51 AND 200 THEN 'Gold'
            WHEN A.LoyaltyPoint >= 201 THEN 'Platinum'
        END
    FROM Account A
    JOIN inserted I ON A.AccountID = I.AccountID;
END;


go
CREATE TRIGGER trg_UpdatePromotionStatus
ON Promotion
AFTER UPDATE
AS
BEGIN
    -- Update Status to 0 (inactive) when RemainRedemption reaches 0
    UPDATE Promotion
    SET Status = 0
    WHERE PromotionID IN (SELECT PromotionID FROM inserted WHERE RemainRedemption = 0);
END;
go

CREATE TRIGGER trg_UpdateComboStatus
ON Combo
AFTER UPDATE
AS
BEGIN
    -- Update Status to 0 (inactive) when Quantity reaches 0
    UPDATE Combo
    SET Status = 0
    WHERE ComboID IN (SELECT ComboID FROM inserted WHERE Quantity = 0);
END;

go
-- Insert Default Pricing Factors
INSERT INTO PricingFactor (Type, Category, Multiplier) VALUES
('Room', 'Standard', 1.0),
('Room', 'VIP', 1.5),
('Room', 'IMAX', 2.0),
('Seat', 'Standard', 1.0),
('Seat', 'VIP', 1.2);
go
-- Example Movie Base Prices


-- Insert data into Image
INSERT INTO Image (ImagePath, ImageType) VALUES
('image1.jpg', N'Poster'),
('image2.jpg', N'Avatar'),
('image3.jpg', N'Avatar'),
('image4.jpg', N'Poster'),
('image5.jpg', N'Banner');
go
-- Insert data into Account
INSERT INTO Account (Name, Email, Password, PhoneNumber, Address, YearOfBirth, Gender, Avatar, Status, Role, LoyaltyPoint, MembershipLevel) VALUES
(N'John Doe', N'john.doe@example.com', N'password123', N'0123456789', N'123 Street A', 1995, N'Male', 2, 1, N'Customer', 0, N'None'),
(N'Jane Smith', N'jane.smith@example.com', N'pass456', N'0987654321', N'456 Street B', 1998, N'Female', 3, 1, N'Customer', 0, N'None'),
(N'Admin User', N'admin@example.com', N'adminpass', N'0112233445', N'Admin Office', 1990, N'Other', 1, 1, N'Admin', 0, N'None'),
(N'Emigly Brown', N'emily.b@example.com', N'hello789', N'0223344556', N'789 Street C', 2000, N'Female', 4, 1, N'Customer', 0, N'None'),
(N'James Wilson', N'james.w@example.com', N'jammy123', N'0334455667', N'159 Street D', 1985, N'Male', 5, 1, N'Manager', 0, N'None');

go
-- Insert data into Cinema
INSERT INTO Cinema (CinemaName, Address) VALUES
(N'Grand Cinema', N'456 Elm St'),
(N'Mega Cineplex', N'789 Pine St'),
(N'Starlight Cinema', N'101 Maple Ave'),
(N'Galaxy Theater', N'202 Oak St'),
(N'Regal Cinemas', N'303 Birch St');
go
-- Insert data into CinemaRoom
INSERT INTO CinemaRoom (CinemaID, RoomName, RoomType, Status) VALUES
(1, N'Room 1', N'Standard', 1),
(2, N'VIP Lounge', N'VIP', 1),
(3, N'IMAX Hall', N'IMAX', 1),
(4, N'Room B', N'Standard', 1),
(5, N'Luxury Suite', N'VIP', 1);
go
-- Insert data into Movie (có thêm BasePrice)
INSERT INTO Movie (MovieName, Duration, Genre, Director, ReleaseDate, Description, Rate, MoviePoster, TrailerURL, BasePrice,Status) VALUES
(N'The Space Odyssey', 120, N'Sci-Fi', N'Jane Doe', '2024-01-15', N'A journey through the cosmos.', 8, 1, N'https://example.com/trailer1.mp4', 50000,'NowShowing'),
(N'Love in the City', 90, N'Romance', N'John Smith', '2024-06-20', N'A romantic tale in urban life.', 7, 2, NULL, 45000,'NowShowing'),
(N'Action Heroes', 150, N'Action', N'Mike Johnson', '2025-02-01', N'High-octane action thriller.', 9, 3, NULL, 60000,'UpcomingMovie'),
(N'Mystery Island', 130, N'Adventure', N'Emily Carter', '2025-03-10', N'An island full of secrets.', 8, 4, NULL, 55000,'ShownMovie'),
(N'Comedy Night', 110, N'Comedy', N'Tom Wright', '2025-04-01', N'Hilarious performances from top comedians.', 6, 5, NULL, 40000,'UpcomingMovie');
go

-- Insert data into Showtime
INSERT INTO Showtime (MovieID, StartTime, EndTime) VALUES
(1, '2025-03-01 14:00:00', '2025-03-01 16:30:00'),
(2, '2025-03-02 17:00:00', '2025-03-02 19:30:00'),
(3, '2025-03-03 20:00:00', '2025-03-03 22:20:00'),
(4, '2025-03-04 15:00:00', '2025-03-04 17:45:00'),
(5, '2025-03-05 18:00:00', '2025-03-05 20:55:00');
go
-- Insert data into Seat
INSERT INTO Seat (SeatRow, SeatNumber, SeatType, RoomID, Status) VALUES
(N'A', 1, N'Standard', 1, N'Available'),
(N'A', 2, N'Standard', 1, N'Reserved'),
(N'B', 1, N'VIP', 2, N'Available'),
(N'C', 3, N'Standard', 3, N'Sold'),
(N'D', 4, N'VIP', 4, N'Available');

go
-- Insert data into Combo
INSERT INTO Combo (ComboItem,Description, Price,Quantity,Status) VALUES
(N'Popcorn + Soda','Inclued 1 Popcorn and Soda', 10.50,2,1),
(N'Nachos + Drink','', 12.00,3,1),
(N'Large Combo','', 15.75,123,1),
(N'Candy + Water','', 8.00,421,1),
(N'Family Pack','', 20.00,28,0);
go
-- Insert data into Promotion
INSERT INTO Promotion (PromoCode, DiscountPercent, StartDate, EndTime, Status, Description, RemainRedemption) VALUES
(N'WELCOME10', 10, '2025-01-01', '2025-12-31', 1, N'10% off for new customers.', 100),
(N'SUMMER25', 25, '2025-06-01', '2025-08-31', 1, N'Summer sale discount.', 200),
(N'VIP50', 50, '2025-02-01', '2025-03-31', 0, N'Exclusive VIP offer.', 50),
(N'NEWYEAR30', 30, '2025-01-01', '2025-02-15', 1, N'New Year special.', 4),
(N'FAMILY15', 15, '2025-04-01', '2025-06-01', 1, N'Family special discount.', 500);
go
-- Insert data into Ticket
INSERT INTO Ticket (SeatID, ShowTimeID, Status, PurchaseDate, ComboID) VALUES
(1, 1, N'Booked', '2025-02-20 12:00:00', 1),
(2, 2, N'Cancelled', '2025-02-21 14:30:00', NULL),
(3, 3, N'Booked', '2025-02-22 16:00:00', 2),
(4, 4, N'Booked', '2025-02-23 18:45:00', 3),
(5, 5, N'Booked', '2025-02-24 20:15:00', 4);
go
-- Insert data into Transaction
INSERT INTO [Transaction] (Quantity, TicketID, AccountID, PromotionID) VALUES
(1, 1, 2, NULL),
(2, 3, 2, 1),
(1, 4, 3, 2),
(1, 5, 4, NULL)


	

