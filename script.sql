USE [master]
GO
/****** Object:  Database [swp391]    Script Date: 3/13/2025 1:41:25 PM ******/
CREATE DATABASE [swp391]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'swp391', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\swp391.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'swp391_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\swp391_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [swp391] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [swp391].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [swp391] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [swp391] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [swp391] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [swp391] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [swp391] SET ARITHABORT OFF 
GO
ALTER DATABASE [swp391] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [swp391] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [swp391] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [swp391] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [swp391] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [swp391] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [swp391] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [swp391] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [swp391] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [swp391] SET  ENABLE_BROKER 
GO
ALTER DATABASE [swp391] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [swp391] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [swp391] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [swp391] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [swp391] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [swp391] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [swp391] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [swp391] SET RECOVERY FULL 
GO
ALTER DATABASE [swp391] SET  MULTI_USER 
GO
ALTER DATABASE [swp391] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [swp391] SET DB_CHAINING OFF 
GO
ALTER DATABASE [swp391] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [swp391] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [swp391] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [swp391] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'swp391', N'ON'
GO
ALTER DATABASE [swp391] SET QUERY_STORE = ON
GO
ALTER DATABASE [swp391] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [swp391]
GO
/****** Object:  Table [dbo].[Account]    Script Date: 3/13/2025 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Account](
	[AccountID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](255) NOT NULL,
	[PhoneNumber] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
	[YearOfBirth] [int] NULL,
	[Gender] [nvarchar](10) NULL,
	[Avatar] [int] NULL,
	[LoyaltyPoint] [int] NULL,
	[MembershipLevel] [nvarchar](50) NULL,
	[Status] [bit] NOT NULL,
	[Role] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AccountID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cinema]    Script Date: 3/13/2025 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cinema](
	[CinemaID] [int] IDENTITY(1,1) NOT NULL,
	[CinemaName] [nvarchar](255) NOT NULL,
	[Address] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CinemaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CinemaRoom]    Script Date: 3/13/2025 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CinemaRoom](
	[RoomID] [int] IDENTITY(1,1) NOT NULL,
	[CinemaID] [int] NOT NULL,
	[RoomName] [nvarchar](255) NOT NULL,
	[RoomType] [nvarchar](50) NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Combo]    Script Date: 3/13/2025 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Combo](
	[ComboID] [int] IDENTITY(1,1) NOT NULL,
	[ComboItem] [nvarchar](255) NOT NULL,
	[Description] [text] NULL,
	[Price] [float] NOT NULL,
	[Quantity] [int] NULL,
	[Status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ComboID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Image]    Script Date: 3/13/2025 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Image](
	[ImageID] [int] IDENTITY(1,1) NOT NULL,
	[ImagePath] [varchar](max) NOT NULL,
	[ImageType] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ImageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 3/13/2025 1:41:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movie](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieName] [nvarchar](255) NOT NULL,
	[Duration] [int] NOT NULL,
	[Genre] [nvarchar](100) NOT NULL,
	[Director] [nvarchar](255) NOT NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[Description] [text] NULL,
	[Rate] [nvarchar](25) NOT NULL,
	[MoviePoster] [int] NULL,
	[TrailerURL] [nvarchar](max) NULL,
	[BasePrice] [float] NOT NULL,
	[Status] [nvarchar](25) NOT NULL,
	[Country] [nvarchar](225) NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingFactor]    Script Date: 3/13/2025 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PricingFactor](
	[FactorID] [int] IDENTITY(1,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
	[Category] [nvarchar](50) NOT NULL,
	[Multiplier] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[FactorID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Promotion]    Script Date: 3/13/2025 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Promotion](
	[PromotionID] [int] IDENTITY(1,1) NOT NULL,
	[PromoCode] [nvarchar](50) NOT NULL,
	[DiscountPercent] [int] NOT NULL,
	[StartDate] [date] NOT NULL,
	[EndTime] [date] NOT NULL,
	[Status] [bit] NOT NULL,
	[Description] [text] NULL,
	[RemainRedemption] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PromotionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 3/13/2025 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seat](
	[SeatID] [int] IDENTITY(1,1) NOT NULL,
	[SeatRow] [nvarchar](10) NOT NULL,
	[SeatNumber] [int] NOT NULL,
	[SeatType] [nvarchar](50) NOT NULL,
	[RoomID] [int] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Showtime]    Script Date: 3/13/2025 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Showtime](
	[ShowtimeID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[CinemaID] [int] NOT NULL,
	[RoomID] [int] NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	CONSTRAINT [PK_Showtime] PRIMARY KEY CLUSTERED ([ShowtimeID] ASC),
	CONSTRAINT [FK_Showtime_Cinema] FOREIGN KEY ([CinemaID]) REFERENCES [Cinema]([CinemaID]) ON DELETE CASCADE,
	CONSTRAINT [FK_Showtime_CinemaRoom] FOREIGN KEY ([RoomID]) REFERENCES [CinemaRoom]([RoomID]) ON DELETE CASCADE
)

	
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 3/13/2025 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[SeatID] [int] NOT NULL,
	[ShowTimeID] [int] NOT NULL,
	[Status] [bit] NOT NULL DEFAULT 0,
	[ComboID] [int] NULL,

PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/13/2025 1:41:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Amount] [float] NULL,
	[TicketID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[PromotionID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (1, N'John Doe', N'john.doe@example.com', N'password123', N'0123456789', N'123 Street A', 1995, N'Male', 2, 0, N'None', 1, N'Customer')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (2, N'Jane Smith', N'jane.smith@example.com', N'pass456', N'0987654321', N'456 Street B', 1998, N'Female', 3, 5, N'Silver', 1, N'Customer')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (3, N'Admin User', N'admin@example.com', N'adminpass', N'0112233445', N'Admin Office', 1990, N'Other', 19, 8, N'Silver', 1, N'Admin')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (4, N'Emigly Brown', N'emily.b@example.com', N'hello789', N'0223344556', N'789 Street C', 2000, N'Female', 4, 4, N'Silver', 1, N'Customer')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (5, N'James Wilson', N'james.w@example.com', N'jammy123', N'0334455667', N'159 Street D', 1985, N'Male', 5, 0, N'None', 1, N'Manager')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (6, N'Dương Gia Bảo', N'dgbao1804@gmail.com', N'13170B@o', N'0987654732', N'adw', 2004, N'Male', NULL, 0, N'None', 1, N'Manager')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (7, N'Hax Fixer', N'haxfixer@gmail.com', N'B@o11711', N'0789278461', N'1234', 2006, N'Male', NULL, 0, N'None', 0, N'Manager')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (8, N'CUto', N'abc@gmail.com', N'B@o11711', N'0729664798', N'dă', 2005, N'Female', NULL, 0, N'None', 1, N'Manager')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Cinema] ON 

INSERT [dbo].[Cinema] ([CinemaID], [CinemaName], [Address]) VALUES (1, N'Grand Cinema', N'456 Elm St')
INSERT [dbo].[Cinema] ([CinemaID], [CinemaName], [Address]) VALUES (2, N'Mega Cineplex', N'789 Pine St')
INSERT [dbo].[Cinema] ([CinemaID], [CinemaName], [Address]) VALUES (3, N'Starlight Cinema', N'101 Maple Ave')
INSERT [dbo].[Cinema] ([CinemaID], [CinemaName], [Address]) VALUES (4, N'Galaxy Theater', N'202 Oak St')
INSERT [dbo].[Cinema] ([CinemaID], [CinemaName], [Address]) VALUES (5, N'Regal Cinemas', N'303 Birch St')
SET IDENTITY_INSERT [dbo].[Cinema] OFF
GO
SET IDENTITY_INSERT [dbo].[CinemaRoom] ON 

INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (1, 1, N'Room 1', N'Standard', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (2, 2, N'VIP Lounge', N'VIP', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (3, 3, N'IMAX Hall', N'IMAX', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (4, 4, N'Room B', N'Standard', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (5, 5, N'Luxury Suite', N'VIP', 1)
SET IDENTITY_INSERT [dbo].[CinemaRoom] OFF
GO
SET IDENTITY_INSERT [dbo].[Combo] ON 

INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (1, N'Popcorn + Soda', N'Inclued 1 Popcorn and Soda', 10.5, 2, 1)
INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (2, N'Nachos + Drink', N'', 12, 3, 1)
INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (3, N'Large Combo', N'', 15.75, 123, 1)
INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (4, N'Candy + Water', N'', 8, 421, 1)
INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (5, N'Family Pack', N'', 20, 28, 0)
INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (7, N'adw', N'adads', 2000, 4, 1)
SET IDENTITY_INSERT [dbo].[Combo] OFF
GO
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (1, N'image1.jpg', N'Poster')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (2, N'image2.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (3, N'image3.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (4, N'image4.jpg', N'Poster')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (5, N'image5.jpg', N'Banner')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (6, N'images/895fe78e-230b-4506-b3a8-26284149dd2f.png', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (7, N'images/bf6a5ea5-b1ad-444e-a006-7c1614f2a756.png', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (8, N'images/7a7cc0c4-44db-49bf-9650-dc29a3fa5742.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (9, N'images/660cacb5-a45e-4de0-983f-acf4b4c3793e.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (10, N'Avatar/a86038e7-c1d5-46ae-8294-b87a24408700.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (11, N'Avatar/84ad2349-938b-4dfb-a596-ab557b3bdaa5.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (12, N'Avatar/a52c93fb-9dfc-48cc-a5d7-92170ad85c39.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (13, N'Avatar/ad14deff-b0e5-4c73-aca4-39c02adae28c.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (14, N'Avatar/5d283e2f-32fc-4cf9-8824-c662cc01b154.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (15, N'Avatar/6d351436-58bc-412c-b255-fe80d3e5ee50.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (16, N'avatar/1635ffea-47b0-469f-b37e-6e6b087df997.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (17, N'avatar/6bd1e899-2604-479d-a289-91a1458e8068.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (18, N'avatar/9e4a3fa5-ee1a-46f1-bebe-9ce5712ead08.jpg', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (19, N'images/0073e5ed-51eb-4086-a6c2-b631fa1649d6.jpg', N'Avatar')
SET IDENTITY_INSERT [dbo].[Image] OFF
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (1, N'The Space Odyssey', 120, N'Sci-Fi', N'Jane Doe', CAST(N'2024-01-15T00:00:00.000' AS DateTime), N'A journey through the cosmos.', N'PG-13', 1, N'https://example.com/trailer1.mp4', 50000, N'NowShowing', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (2, N'Love in the City', 90, N'Romance', N'John Smith', CAST(N'2024-06-20T00:00:00.000' AS DateTime), N'A romantic tale in urban life.', N'PG', 2, N'https://example.com/trailer2.mp4', 45000, N'NowShowing', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (3, N'Action Heroes', 150, N'Action', N'Mike Johnson', CAST(N'2025-02-01T00:00:00.000' AS DateTime), N'High-octane action thriller.', N'R', 3, N'https://example.com/trailer3.mp4', 60000, N'UpcomingMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (4, N'Mystery Island', 130, N'Adventure', N'Emily Carter', CAST(N'2025-03-10T00:00:00.000' AS DateTime), N'An island full of secrets.', N'PG-13', 4, N'https://example.com/trailer4.mp4', 55000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (5, N'Comedy Night', 110, N'Comedy', N'Tom Wright', CAST(N'2025-04-01T00:00:00.000' AS DateTime), N'Hilarious performances from top comedians.', N'PG', 5, N'https://example.com/trailer5.mp4', 40000, N'UpcomingMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (6, N'Inception', 148, N'Sci-Fi', N'Christopher Nolan', CAST(N'2010-07-16T00:00:00.000' AS DateTime), N'A mind-bending thriller about dreams within dreams.', N'PG-13', 1, N'https://youtube.com/trailer1', 50000, N'NowShowing', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (7, N'Parasite', 132, N'Thriller', N'Bong Joon-ho', CAST(N'2019-05-30T00:00:00.000' AS DateTime), N'A poor family infiltrates a wealthy household.', N'R', 2, N'https://youtube.com/trailer2', 45000, N'ShownMovie', N'South Korea')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (8, N'Interstellar', 169, N'Sci-Fi', N'Christopher Nolan', CAST(N'2014-11-07T00:00:00.000' AS DateTime), N'A journey through space and time to save humanity.', N'PG-13', 3, N'https://youtube.com/trailer3', 60000, N'NowShowing', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (9, N'The Godfather', 175, N'Crime', N'Francis Ford Coppola', CAST(N'1972-03-24T00:00:00.000' AS DateTime), N'The rise of the Corleone crime family.', N'R', 4, N'https://youtube.com/trailer4', 55000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (10, N'Titanic', 195, N'Romance', N'James Cameron', CAST(N'1997-12-19T00:00:00.000' AS DateTime), N'A love story set on the ill-fated Titanic.', N'PG-13', 5, N'https://youtube.com/trailer5', 50000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (11, N'The Dark Knight', 152, N'Action', N'Christopher Nolan', CAST(N'2008-07-18T00:00:00.000' AS DateTime), N'Batman faces off against the Joker.', N'PG-13', 1, N'https://youtube.com/trailer6', 60000, N'NowShowing', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (12, N'Avatar', 162, N'Sci-Fi', N'James Cameron', CAST(N'2009-12-18T00:00:00.000' AS DateTime), N'A marine on an alien planet becomes one of them.', N'PG-13', 2, N'https://youtube.com/trailer7', 55000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (13, N'Joker', 122, N'Drama', N'Todd Phillips', CAST(N'2019-10-04T00:00:00.000' AS DateTime), N'The origin story of the infamous villain.', N'R', 3, N'https://youtube.com/trailer8', 45000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (14, N'Forrest Gump', 142, N'Drama', N'Robert Zemeckis', CAST(N'1994-07-06T00:00:00.000' AS DateTime), N'The story of a simple man with a big heart.', N'PG-13', 4, N'https://youtube.com/trailer9', 50000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (15, N'Spirited Away', 125, N'Animation', N'Hayao Miyazaki', CAST(N'2001-07-20T00:00:00.000' AS DateTime), N'A girl enters a world of spirits and magic.', N'PG', 5, N'https://youtube.com/trailer10', 40000, N'ShownMovie', N'Japan')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (16, N'Train to Busan', 118, N'Horror', N'Yeon Sang-ho', CAST(N'2016-07-20T00:00:00.000' AS DateTime), N'A father and daughter struggle to survive a zombie outbreak.', N'R', 1, N'https://youtube.com/trailer21', 45000, N'ShownMovie', N'South Korea')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (17, N'Your Name', 107, N'Animation', N'Makoto Shinkai', CAST(N'2016-08-26T00:00:00.000' AS DateTime), N'Two teenagers swap bodies in a magical connection.', N'PG', 2, N'https://youtube.com/trailer25', 40000, N'ShownMovie', N'Japan')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (18, N'The Matrix', 136, N'Sci-Fi', N'Lana Wachowski, Lilly Wachowski', CAST(N'1999-03-31T00:00:00.000' AS DateTime), N'A hacker discovers the true nature of reality.', N'R', 3, N'https://youtube.com/trailer12', 55000, N'ShownMovie', N'USA')
INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status], [Country]) VALUES (19, N'Oldboy', 120, N'Thriller', N'Park Chan-wook', CAST(N'2003-11-21T00:00:00.000' AS DateTime), N'A man seeks revenge after being imprisoned for 15 years.', N'R', 4, N'https://youtube.com/trailer22', 45000, N'ShownMovie', N'South Korea')
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
SET IDENTITY_INSERT [dbo].[PricingFactor] ON 

INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (1, N'Room', N'Standard', 1)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (2, N'Room', N'VIP', 1.5)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (3, N'Room', N'IMAX', 2)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (4, N'Seat', N'Standard', 1)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (5, N'Seat', N'VIP', 1.2)
SET IDENTITY_INSERT [dbo].[PricingFactor] OFF
GO
SET IDENTITY_INSERT [dbo].[Promotion] ON 

INSERT [dbo].[Promotion] ([PromotionID], [PromoCode], [DiscountPercent], [StartDate], [EndTime], [Status], [Description], [RemainRedemption]) VALUES (1, N'WELCOME10', 10, CAST(N'2025-01-01' AS Date), CAST(N'2025-12-31' AS Date), 1, N'10% off for new customers.', 100)
INSERT [dbo].[Promotion] ([PromotionID], [PromoCode], [DiscountPercent], [StartDate], [EndTime], [Status], [Description], [RemainRedemption]) VALUES (2, N'SUMMER25', 25, CAST(N'2025-06-01' AS Date), CAST(N'2025-08-31' AS Date), 1, N'Summer sale discount.', 200)
INSERT [dbo].[Promotion] ([PromotionID], [PromoCode], [DiscountPercent], [StartDate], [EndTime], [Status], [Description], [RemainRedemption]) VALUES (3, N'VIP50', 50, CAST(N'2025-02-01' AS Date), CAST(N'2025-03-31' AS Date), 0, N'Exclusive VIP offer.', 50)
INSERT [dbo].[Promotion] ([PromotionID], [PromoCode], [DiscountPercent], [StartDate], [EndTime], [Status], [Description], [RemainRedemption]) VALUES (4, N'NEWYEAR30', 30, CAST(N'2025-01-01' AS Date), CAST(N'2025-02-15' AS Date), 1, N'New Year special.', 4)
INSERT [dbo].[Promotion] ([PromotionID], [PromoCode], [DiscountPercent], [StartDate], [EndTime], [Status], [Description], [RemainRedemption]) VALUES (5, N'FAMILY15', 15, CAST(N'2025-04-01' AS Date), CAST(N'2025-06-01' AS Date), 1, N'Family special discount.', 500)
SET IDENTITY_INSERT [dbo].[Promotion] OFF
GO
SET IDENTITY_INSERT [dbo].[Seat] ON 

INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (1, N'A', 1, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (2, N'A', 2, N'Standard', 1, N'Reserved')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (3, N'B', 1, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (4, N'C', 3, N'Standard', 3, N'Sold')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (5, N'D', 4, N'Standard', 4, N'Reserved')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (6, N'D', 2, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (7, N'D', 2, N'VIP', 2, N'Available')
SET IDENTITY_INSERT [dbo].[Seat] OFF
GO
SET IDENTITY_INSERT [dbo].[Showtime] ON 

INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID],CinemaID,RoomID, [StartTime], [EndTime]) VALUES (1, 1,1,1, CAST(N'2025-03-01T14:00:00.000' AS DateTime), CAST(N'2025-03-01T16:30:00.000' AS DateTime))
INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID],CinemaID,RoomID, [StartTime], [EndTime]) VALUES (2, 2,2,2, CAST(N'2025-03-02T17:00:00.000' AS DateTime), CAST(N'2025-03-02T19:30:00.000' AS DateTime))
INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID],CinemaID,RoomID, [StartTime], [EndTime]) VALUES (3, 3,1,1, CAST(N'2025-03-03T20:00:00.000' AS DateTime), CAST(N'2025-03-03T22:20:00.000' AS DateTime))
INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID],CinemaID,RoomID, [StartTime], [EndTime]) VALUES (4, 4,3,3, CAST(N'2025-03-04T15:00:00.000' AS DateTime), CAST(N'2025-03-04T17:45:00.000' AS DateTime))
INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID],CinemaID,RoomID, [StartTime], [EndTime]) VALUES (5, 5,2,2, CAST(N'2025-03-05T18:00:00.000' AS DateTime), CAST(N'2025-03-05T20:55:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Showtime] OFF
GO
SET IDENTITY_INSERT [dbo].[Ticket] ON 

INSERT [dbo].[Ticket] ([TicketID], [SeatID], [ShowTimeID], [Status],  [ComboID]) VALUES (1, 1, 1, 0, 1)
INSERT [dbo].[Ticket] ([TicketID], [SeatID], [ShowTimeID], [Status],  [ComboID]) VALUES (2, 2, 2, 0,  NULL)
INSERT [dbo].[Ticket] ([TicketID], [SeatID], [ShowTimeID], [Status],  [ComboID]) VALUES (3, 3, 3, 0,  2)
INSERT [dbo].[Ticket] ([TicketID], [SeatID], [ShowTimeID], [Status],  [ComboID]) VALUES (4, 4, 4, 0,  3)
INSERT [dbo].[Ticket] ([TicketID], [SeatID], [ShowTimeID], [Status],  [ComboID]) VALUES (5, 5, 5, 0,  4)
SET IDENTITY_INSERT [dbo].[Ticket] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([TransactionID], [Quantity], [Amount], [TicketID], [AccountID], [PromotionID]) VALUES (1, 1, 50000, 1, 2, NULL)
INSERT [dbo].[Transaction] ([TransactionID], [Quantity], [Amount], [TicketID], [AccountID], [PromotionID]) VALUES (2, 2, 194400, 3, 2, 1)
INSERT [dbo].[Transaction] ([TransactionID], [Quantity], [Amount], [TicketID], [AccountID], [PromotionID]) VALUES (3, 1, 82500, 4, 3, 2)
INSERT [dbo].[Transaction] ([TransactionID], [Quantity], [Amount], [TicketID], [AccountID], [PromotionID]) VALUES (4, 1, 48000, 5, 4, NULL)
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__85FB4E38EF924611]    Script Date: 3/13/2025 1:41:26 PM ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__A9D10534B19AC3F7]    Script Date: 3/13/2025 1:41:26 PM ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Promotio__32DBED35CEF43B17]    Script Date: 3/13/2025 1:41:26 PM ******/
ALTER TABLE [dbo].[Promotion] ADD UNIQUE NONCLUSTERED 
(
	[PromoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [LoyaltyPoint]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ('None') FOR [MembershipLevel]
GO
ALTER TABLE [dbo].[Combo] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Combo] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((0)) FOR [RemainRedemption]
GO

ALTER TABLE [dbo].[Transaction] ADD  DEFAULT ((0)) FOR [Amount]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([Avatar])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[CinemaRoom]  WITH CHECK ADD FOREIGN KEY([CinemaID])
REFERENCES [dbo].[Cinema] ([CinemaID])
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD FOREIGN KEY([MoviePoster])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[CinemaRoom] ([RoomID])
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movie] ([MovieID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([ComboID])
REFERENCES [dbo].[Combo] ([ComboID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seat] ([SeatID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([ShowTimeID])
REFERENCES [dbo].[Showtime] ([ShowtimeID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([PromotionID])
REFERENCES [dbo].[Promotion] ([PromotionID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([TicketID])
REFERENCES [dbo].[Ticket] ([TicketID])
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD CHECK  (([MembershipLevel]='Platitnum' OR [MembershipLevel]='Gold' OR [MembershipLevel]='Silver' OR [MembershipLevel]='None'))
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD CHECK  (([Role]='Customer' OR [Role]='Manager' OR [Role]='Admin'))
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD CHECK  (([YearOfBirth]>=(1900) AND [YearOfBirth]<=(datepart(year,getdate())-(10))))
GO
ALTER TABLE [dbo].[CinemaRoom]  WITH CHECK ADD CHECK  (([RoomType]='IMAX' OR [RoomType]='VIP' OR [RoomType]='Standard'))
GO
ALTER TABLE [dbo].[Combo]  WITH CHECK ADD CHECK  (([Price]>(0)))
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD CHECK  (([BasePrice]>(0)))
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD CHECK  (([Duration]>(0)))
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD CHECK  (([Rate]='R' OR [Rate]='PG' OR [Rate]='PG-13'))
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD CHECK  (([Status]='ShownMovie' OR [Status]='UpcomingMovie' OR [Status]='NowShowing'))
GO
ALTER TABLE [dbo].[PricingFactor]  WITH CHECK ADD CHECK  (([Multiplier]>(0)))
GO
ALTER TABLE [dbo].[PricingFactor]  WITH CHECK ADD CHECK  (([Type]='Seat' OR [Type]='Room'))
GO
ALTER TABLE [dbo].[Promotion]  WITH CHECK ADD CHECK  (([DiscountPercent]>=(0) AND [DiscountPercent]<=(100)))
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD CHECK  (([SeatNumber]>(0)))
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD CHECK  (([SeatType]='VIP' OR [SeatType]='Standard'))
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD CHECK  (([Status]='Processing' OR [Status]='Booked' OR [Status]='Available'))
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD CHECK  (([Amount]>=(0)))
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD CHECK  (([Quantity]>(0)))
GO
USE [master]
GO
ALTER DATABASE [swp391] SET  READ_WRITE 
GO
