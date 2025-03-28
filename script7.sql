USE [master]
GO
/****** Object:  Database [swp391]    Script Date: 3/25/2025 11:38:45 PM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Blog]    Script Date: 3/25/2025 11:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Blog](
	[BlogID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[ReleaseDate] [datetime] NOT NULL,
	[Description] [text] NULL,
	[BlogPoster] [int] NULL,
	[Status] [nvarchar](25) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BlogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cinema]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[CinemaRoom]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Combo]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Image]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Movie]    Script Date: 3/25/2025 11:38:46 PM ******/
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
PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Order]    Script Date: 3/25/2025 11:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[OrderDate] [datetime] NOT NULL,
	[TotalAmount] [float] NOT NULL,
	[SeatQuantity] [int] NOT NULL,
	[ComboQuantity] [int] NULL,
	[PromotionID] [int] NULL,
	[Status] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderCombo]    Script Date: 3/25/2025 11:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderCombo](
	[OrderComboID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ComboID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [float] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderComboID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PricingFactor]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Promotion]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Seat]    Script Date: 3/25/2025 11:38:46 PM ******/
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
/****** Object:  Table [dbo].[Showtime]    Script Date: 3/25/2025 11:38:46 PM ******/
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
 CONSTRAINT [PK_Showtime] PRIMARY KEY CLUSTERED 
(
	[ShowtimeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Ticket]    Script Date: 3/25/2025 11:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ShowtimeID] [int] NOT NULL,
	[SeatID] [int] NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Account] ON 

INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (1, N'Admin', N'admin@example.com', N'adminpass', N'0987654321', N'FAcademy', 2004, N'Male', 1, 0, N'None', 1, N'Admin')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (2, N'Bao', N'daicalaca24@gmail.com', N'$2a$10$Ue6kjrtkLXa6UOlwTr44buWXdiJ8FVdFjm/9rnMUir86YKKmwSwFy', N'0916702958', N'Thạch Thất', 2004, N'Male', 1, 0, N'None', 1, N'Admin')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (3, N'JJsk', N'abcd@gmail.com', N'$2a$10$prPZezlfFHcK0gdgOmIoJOzcCcaxPxPjDBEnnXf3/A7pbDsWavbUS', N'0729664798', N'dă', 2004, N'Male', 1, 0, N'None', 1, N'Customer')
INSERT [dbo].[Account] ([AccountID], [Name], [Email], [Password], [PhoneNumber], [Address], [YearOfBirth], [Gender], [Avatar], [LoyaltyPoint], [MembershipLevel], [Status], [Role]) VALUES (4, N'Dat Pham', N'pdatte1999@gmail.com', N'$2a$10$A0syOSgUAd.kH2eSCYrCXuejLurOTYrh5B71MAjV/I6VCT4KDRXAy', N'0987654311', N'no', 2004, N'Male', 1, 0, N'None', 1, N'Admin')
SET IDENTITY_INSERT [dbo].[Account] OFF
GO
SET IDENTITY_INSERT [dbo].[Blog] ON 

INSERT [dbo].[Blog] ([BlogID], [Title], [ReleaseDate], [Description], [BlogPoster], [Status]) VALUES (1, N'Sale OFFF', CAST(N'2010-08-06T00:00:00.000' AS DateTime), N'Inception is a 2010 science fiction action heist film written and directed by Christopher Nolan, who also produced it with Emma Thomas, his wife. The film stars Leonardo DiCaprio as a professional thief who steals information by infiltrating the subconscious of his targets. He is offered a chance to have his criminal history erased as payment for the implantation of another person''s idea into a target''s subconscious.', 3, N'1')
INSERT [dbo].[Blog] ([BlogID], [Title], [ReleaseDate], [Description], [BlogPoster], [Status]) VALUES (2, N'Ngày thành lập Đoàn Thanh niên Cộng sản Hồ Chí Minh', CAST(N'2025-03-26T00:00:00.000' AS DateTime), N'CHÀO M?NG NGÀY THÀNH L?P ÐOÀN - SALE TUNG B?NG 26%!

?? Nhân d?p k? ni?m Ngày thành l?p Ðoàn Thanh niên C?ng s?n H? Chí Minh (26/3), [Tên R?p Chi?u Phim] mang d?n uu dãi h?p d?n GI?M NGAY 26% cho t?t c? các su?t chi?u!

?? Th?i gian áp d?ng: T? [ngày b?t d?u] d?n [ngày k?t thúc]
?? Áp d?ng t?i: H? th?ng r?p [Tên R?p] trên toàn qu?c & khi d?t vé online t?i [Website c?a r?p]

?? UU ÐÃI SIÊU H?P D?N ? Gi?m ngay 26% giá vé cho t?t c? các su?t chi?u. ? Áp d?ng cho m?i khách hàng khi mua vé t?i qu?y ho?c d?t online. ? Không gi?i h?n s? lu?ng vé trên m?i giao d?ch.

?? Luu ý:

Chuong trình không áp d?ng d?ng th?i v?i các khuy?n mãi khác.

Không áp d?ng cho các gh? VIP, phòng chi?u d?c bi?t.

Vé dã mua không du?c hoàn/tr?.

?? Nhanh tay d?t vé ngay d? cùng b?n bè và ngu?i thân t?n hu?ng nh?ng b? phim bom t?n v?i giá c?c uu dãi!
?? Ð?t vé ngay t?i: [Website c?a r?p] ho?c ?ng d?ng [Tên App n?u có]

?? Hãy cùng nhau t?n hu?ng không khí sôi d?ng c?a Ngày thành l?p Ðoàn v?i nh?ng thu?c phim tuy?t v?i! ??', 5, N'1')
SET IDENTITY_INSERT [dbo].[Blog] OFF
GO
SET IDENTITY_INSERT [dbo].[Cinema] ON 

INSERT [dbo].[Cinema] ([CinemaID], [CinemaName], [Address]) VALUES (1, N'Galaxy', N'Hanoi')
SET IDENTITY_INSERT [dbo].[Cinema] OFF
GO
SET IDENTITY_INSERT [dbo].[CinemaRoom] ON 

INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (1, 1, N'Sun', N'IMAX', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (2, 1, N'Earth', N'IMAX', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (3, 1, N'Moon', N'VIP', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (4, 1, N'Venus', N'Standard', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (5, 1, N'Mars', N'VIP', 1)
INSERT [dbo].[CinemaRoom] ([RoomID], [CinemaID], [RoomName], [RoomType], [Status]) VALUES (6, 1, N'Uranus', N'Standard', 1)
SET IDENTITY_INSERT [dbo].[CinemaRoom] OFF
GO
SET IDENTITY_INSERT [dbo].[Combo] ON 

INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (1, N'Mi tom + 3 trung', N'Ngon', 30000, 5, 1)
INSERT [dbo].[Combo] ([ComboID], [ComboItem], [Description], [Price], [Quantity], [Status]) VALUES (2, N'Cola + PopCorn', N'Hay', 50000, 3, 1)
SET IDENTITY_INSERT [dbo].[Combo] OFF
GO
SET IDENTITY_INSERT [dbo].[Image] ON 

INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (1, N'images/Avatar1.png', N'Avatar')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (2, N'938948d1-7bca-4b99-89ee-52c2d4cc7b3b.png', N'Poster')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (3, N'c021f483-c139-4d9b-8d36-0e6068ebcb5b.png', N'Poster')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (4, N'da58d944-51ac-4551-a985-c1ca6086e23a.png', N'Poster')
INSERT [dbo].[Image] ([ImageID], [ImagePath], [ImageType]) VALUES (5, N'19e5ac3f-eddd-430b-a4e1-3e714b2c7b5e.jpg', N'Blog')
SET IDENTITY_INSERT [dbo].[Image] OFF
GO
SET IDENTITY_INSERT [dbo].[Movie] ON 

INSERT [dbo].[Movie] ([MovieID], [MovieName], [Duration], [Genre], [Director], [ReleaseDate], [Description], [Rate], [MoviePoster], [TrailerURL], [BasePrice], [Status]) VALUES (1, N'Avatar', 162, N'Science fiction', N'James Cameron', CAST(N'2009-12-18T00:00:00.000' AS DateTime), N'sd', N'PG-13', 4, N'https://www.bing.com/videos/search?q=avatar+1+trailer&qpvt=avatar+1+trailer&FORM=VDRE', 35000, N'NowShowing')
SET IDENTITY_INSERT [dbo].[Movie] OFF
GO
SET IDENTITY_INSERT [dbo].[Order] ON 

INSERT [dbo].[Order] ([OrderID], [AccountID], [OrderDate], [TotalAmount], [SeatQuantity], [ComboQuantity], [PromotionID], [Status]) VALUES (1, 2, CAST(N'2025-03-25T17:31:41.813' AS DateTime), 290000, 3, 2, NULL, N'Completed')
INSERT [dbo].[Order] ([OrderID], [AccountID], [OrderDate], [TotalAmount], [SeatQuantity], [ComboQuantity], [PromotionID], [Status]) VALUES (2, 2, CAST(N'2025-03-25T17:34:02.487' AS DateTime), 440000, 4, 4, NULL, N'Processing')
SET IDENTITY_INSERT [dbo].[Order] OFF
GO
SET IDENTITY_INSERT [dbo].[OrderCombo] ON 

INSERT [dbo].[OrderCombo] ([OrderComboID], [OrderID], [ComboID], [Quantity], [Price]) VALUES (1, 1, 1, 1, 30000)
INSERT [dbo].[OrderCombo] ([OrderComboID], [OrderID], [ComboID], [Quantity], [Price]) VALUES (2, 1, 2, 1, 50000)
INSERT [dbo].[OrderCombo] ([OrderComboID], [OrderID], [ComboID], [Quantity], [Price]) VALUES (3, 2, 1, 2, 60000)
INSERT [dbo].[OrderCombo] ([OrderComboID], [OrderID], [ComboID], [Quantity], [Price]) VALUES (4, 2, 2, 2, 100000)
SET IDENTITY_INSERT [dbo].[OrderCombo] OFF
GO
SET IDENTITY_INSERT [dbo].[PricingFactor] ON 

INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (1, N'Room', N'Standard', 1)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (2, N'Room', N'VIP', 1.5)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (3, N'Room', N'IMAX', 2)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (4, N'Seat', N'Standard', 1)
INSERT [dbo].[PricingFactor] ([FactorID], [Type], [Category], [Multiplier]) VALUES (5, N'Seat', N'VIP', 1.2)
SET IDENTITY_INSERT [dbo].[PricingFactor] OFF
GO
SET IDENTITY_INSERT [dbo].[Seat] ON 

INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (2, N'A', 1, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (3, N'B', 1, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (4, N'C', 1, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (5, N'D', 1, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (6, N'E', 1, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (7, N'F', 1, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (8, N'G', 1, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (9, N'A', 2, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (10, N'B', 2, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (11, N'C', 2, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (12, N'D', 2, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (13, N'E', 2, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (14, N'F', 2, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (15, N'G', 2, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (16, N'A', 3, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (17, N'B', 3, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (18, N'C', 3, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (19, N'D', 3, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (20, N'E', 3, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (21, N'F', 3, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (22, N'G', 3, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (23, N'A', 4, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (24, N'B', 4, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (25, N'C', 4, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (26, N'D', 4, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (27, N'E', 4, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (28, N'F', 4, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (29, N'G', 4, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (30, N'A', 5, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (31, N'B', 5, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (32, N'C', 5, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (33, N'D', 5, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (34, N'E', 5, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (35, N'F', 5, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (36, N'G', 5, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (37, N'A', 6, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (38, N'B', 6, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (39, N'C', 6, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (40, N'D', 6, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (41, N'E', 6, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (42, N'F', 6, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (43, N'G', 6, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (44, N'A', 7, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (45, N'B', 7, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (46, N'C', 7, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (47, N'D', 7, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (48, N'E', 7, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (49, N'F', 7, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (50, N'G', 7, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (51, N'A', 8, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (52, N'B', 8, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (53, N'C', 8, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (54, N'D', 8, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (55, N'E', 8, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (56, N'F', 8, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (57, N'G', 8, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (58, N'A', 9, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (59, N'B', 9, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (60, N'C', 9, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (61, N'D', 9, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (62, N'E', 9, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (63, N'F', 9, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (64, N'G', 9, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (65, N'A', 10, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (66, N'B', 10, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (67, N'C', 10, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (68, N'D', 10, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (69, N'E', 10, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (70, N'F', 10, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (71, N'G', 10, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (72, N'A', 11, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (73, N'B', 11, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (74, N'C', 11, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (75, N'D', 11, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (76, N'E', 11, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (77, N'F', 11, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (78, N'G', 11, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (79, N'A', 12, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (80, N'B', 12, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (81, N'C', 12, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (82, N'D', 12, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (83, N'E', 12, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (84, N'F', 12, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (85, N'G', 12, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (86, N'A', 13, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (87, N'B', 13, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (88, N'C', 13, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (89, N'D', 13, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (90, N'E', 13, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (91, N'F', 13, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (92, N'G', 13, N'VIP', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (93, N'A', 14, N'Standard', 1, N'Processing')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (94, N'B', 14, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (95, N'C', 14, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (96, N'D', 14, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (97, N'E', 14, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (98, N'F', 14, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (99, N'G', 14, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (100, N'A', 15, N'Standard', 1, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (101, N'B', 15, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (102, N'C', 15, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (103, N'D', 15, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (104, N'E', 15, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (105, N'F', 15, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (106, N'G', 15, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (107, N'A', 16, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (108, N'B', 16, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (109, N'C', 16, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (110, N'D', 16, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (111, N'E', 16, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (112, N'F', 16, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (113, N'G', 16, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (114, N'A', 17, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (115, N'B', 17, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (116, N'C', 17, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (117, N'D', 17, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (118, N'E', 17, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (119, N'F', 17, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (120, N'G', 17, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (121, N'A', 18, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (122, N'B', 18, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (123, N'C', 18, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (124, N'D', 18, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (125, N'E', 18, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (126, N'F', 18, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (127, N'G', 18, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (128, N'A', 19, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (129, N'B', 19, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (130, N'C', 19, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (131, N'D', 19, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (132, N'E', 19, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (133, N'F', 19, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (134, N'G', 19, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (135, N'A', 20, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (136, N'B', 20, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (137, N'C', 20, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (138, N'D', 20, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (139, N'E', 20, N'Standard', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (140, N'F', 20, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (141, N'G', 20, N'VIP', 1, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (142, N'A', 1, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (143, N'B', 1, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (144, N'C', 1, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (145, N'D', 1, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (146, N'E', 1, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (147, N'F', 1, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (148, N'G', 1, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (149, N'A', 2, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (150, N'B', 2, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (151, N'C', 2, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (152, N'D', 2, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (153, N'E', 2, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (154, N'F', 2, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (155, N'G', 2, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (156, N'A', 3, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (157, N'B', 3, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (158, N'C', 3, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (159, N'D', 3, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (160, N'E', 3, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (161, N'F', 3, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (162, N'G', 3, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (163, N'A', 4, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (164, N'B', 4, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (165, N'C', 4, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (166, N'D', 4, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (167, N'E', 4, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (168, N'F', 4, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (169, N'G', 4, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (170, N'A', 5, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (171, N'B', 5, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (172, N'C', 5, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (173, N'D', 5, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (174, N'E', 5, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (175, N'F', 5, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (176, N'G', 5, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (177, N'A', 6, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (178, N'B', 6, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (179, N'C', 6, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (180, N'D', 6, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (181, N'E', 6, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (182, N'F', 6, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (183, N'G', 6, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (184, N'A', 7, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (185, N'B', 7, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (186, N'C', 7, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (187, N'D', 7, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (188, N'E', 7, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (189, N'F', 7, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (190, N'G', 7, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (191, N'A', 8, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (192, N'B', 8, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (193, N'C', 8, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (194, N'D', 8, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (195, N'E', 8, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (196, N'F', 8, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (197, N'G', 8, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (198, N'A', 9, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (199, N'B', 9, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (200, N'C', 9, N'Standard', 2, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (201, N'D', 9, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (202, N'E', 9, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (203, N'F', 9, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (204, N'G', 9, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (205, N'A', 10, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (206, N'B', 10, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (207, N'C', 10, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (208, N'D', 10, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (209, N'E', 10, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (210, N'F', 10, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (211, N'G', 10, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (212, N'A', 11, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (213, N'B', 11, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (214, N'C', 11, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (215, N'D', 11, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (216, N'E', 11, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (217, N'F', 11, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (218, N'G', 11, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (219, N'A', 12, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (220, N'B', 12, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (221, N'C', 12, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (222, N'D', 12, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (223, N'E', 12, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (224, N'F', 12, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (225, N'G', 12, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (226, N'A', 13, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (227, N'B', 13, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (228, N'C', 13, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (229, N'D', 13, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (230, N'E', 13, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (231, N'F', 13, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (232, N'G', 13, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (233, N'A', 14, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (234, N'B', 14, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (235, N'C', 14, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (236, N'D', 14, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (237, N'E', 14, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (238, N'F', 14, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (239, N'G', 14, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (240, N'A', 15, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (241, N'B', 15, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (242, N'C', 15, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (243, N'D', 15, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (244, N'E', 15, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (245, N'F', 15, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (246, N'G', 15, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (247, N'A', 16, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (248, N'B', 16, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (249, N'C', 16, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (250, N'D', 16, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (251, N'E', 16, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (252, N'F', 16, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (253, N'G', 16, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (254, N'A', 17, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (255, N'B', 17, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (256, N'C', 17, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (257, N'D', 17, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (258, N'E', 17, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (259, N'F', 17, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (260, N'G', 17, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (261, N'A', 18, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (262, N'B', 18, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (263, N'C', 18, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (264, N'D', 18, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (265, N'E', 18, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (266, N'F', 18, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (267, N'G', 18, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (268, N'A', 19, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (269, N'B', 19, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (270, N'C', 19, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (271, N'D', 19, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (272, N'E', 19, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (273, N'F', 19, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (274, N'G', 19, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (275, N'A', 20, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (276, N'B', 20, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (277, N'C', 20, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (278, N'D', 20, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (279, N'E', 20, N'Standard', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (280, N'F', 20, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (281, N'G', 20, N'VIP', 2, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (282, N'A', 1, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (283, N'B', 1, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (284, N'C', 1, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (285, N'D', 1, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (286, N'E', 1, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (287, N'F', 1, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (288, N'G', 1, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (289, N'A', 2, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (290, N'B', 2, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (291, N'C', 2, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (292, N'D', 2, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (293, N'E', 2, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (294, N'F', 2, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (295, N'G', 2, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (296, N'A', 3, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (297, N'B', 3, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (298, N'C', 3, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (299, N'D', 3, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (300, N'E', 3, N'Standard', 3, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (301, N'F', 3, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (302, N'G', 3, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (303, N'A', 4, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (304, N'B', 4, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (305, N'C', 4, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (306, N'D', 4, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (307, N'E', 4, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (308, N'F', 4, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (309, N'G', 4, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (310, N'A', 5, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (311, N'B', 5, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (312, N'C', 5, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (313, N'D', 5, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (314, N'E', 5, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (315, N'F', 5, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (316, N'G', 5, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (317, N'A', 6, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (318, N'B', 6, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (319, N'C', 6, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (320, N'D', 6, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (321, N'E', 6, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (322, N'F', 6, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (323, N'G', 6, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (324, N'A', 7, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (325, N'B', 7, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (326, N'C', 7, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (327, N'D', 7, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (328, N'E', 7, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (329, N'F', 7, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (330, N'G', 7, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (331, N'A', 8, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (332, N'B', 8, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (333, N'C', 8, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (334, N'D', 8, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (335, N'E', 8, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (336, N'F', 8, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (337, N'G', 8, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (338, N'A', 9, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (339, N'B', 9, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (340, N'C', 9, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (341, N'D', 9, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (342, N'E', 9, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (343, N'F', 9, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (344, N'G', 9, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (345, N'A', 10, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (346, N'B', 10, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (347, N'C', 10, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (348, N'D', 10, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (349, N'E', 10, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (350, N'F', 10, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (351, N'G', 10, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (352, N'A', 11, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (353, N'B', 11, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (354, N'C', 11, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (355, N'D', 11, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (356, N'E', 11, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (357, N'F', 11, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (358, N'G', 11, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (359, N'A', 12, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (360, N'B', 12, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (361, N'C', 12, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (362, N'D', 12, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (363, N'E', 12, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (364, N'F', 12, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (365, N'G', 12, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (366, N'A', 13, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (367, N'B', 13, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (368, N'C', 13, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (369, N'D', 13, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (370, N'E', 13, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (371, N'F', 13, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (372, N'G', 13, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (373, N'A', 14, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (374, N'B', 14, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (375, N'C', 14, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (376, N'D', 14, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (377, N'E', 14, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (378, N'F', 14, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (379, N'G', 14, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (380, N'A', 15, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (381, N'B', 15, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (382, N'C', 15, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (383, N'D', 15, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (384, N'E', 15, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (385, N'F', 15, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (386, N'G', 15, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (387, N'A', 16, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (388, N'B', 16, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (389, N'C', 16, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (390, N'D', 16, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (391, N'E', 16, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (392, N'F', 16, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (393, N'G', 16, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (394, N'A', 17, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (395, N'B', 17, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (396, N'C', 17, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (397, N'D', 17, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (398, N'E', 17, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (399, N'F', 17, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (400, N'G', 17, N'VIP', 3, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (401, N'A', 18, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (402, N'B', 18, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (403, N'C', 18, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (404, N'D', 18, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (405, N'E', 18, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (406, N'F', 18, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (407, N'G', 18, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (408, N'A', 19, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (409, N'B', 19, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (410, N'C', 19, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (411, N'D', 19, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (412, N'E', 19, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (413, N'F', 19, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (414, N'G', 19, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (415, N'A', 20, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (416, N'B', 20, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (417, N'C', 20, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (418, N'D', 20, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (419, N'E', 20, N'Standard', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (420, N'F', 20, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (421, N'G', 20, N'VIP', 3, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (422, N'A', 1, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (423, N'B', 1, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (424, N'C', 1, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (425, N'D', 1, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (426, N'E', 1, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (427, N'F', 1, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (428, N'G', 1, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (429, N'A', 2, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (430, N'B', 2, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (431, N'C', 2, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (432, N'D', 2, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (433, N'E', 2, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (434, N'F', 2, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (435, N'G', 2, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (436, N'A', 3, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (437, N'B', 3, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (438, N'C', 3, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (439, N'D', 3, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (440, N'E', 3, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (441, N'F', 3, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (442, N'G', 3, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (443, N'A', 4, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (444, N'B', 4, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (445, N'C', 4, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (446, N'D', 4, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (447, N'E', 4, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (448, N'F', 4, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (449, N'G', 4, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (450, N'A', 5, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (451, N'B', 5, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (452, N'C', 5, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (453, N'D', 5, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (454, N'E', 5, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (455, N'F', 5, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (456, N'G', 5, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (457, N'A', 6, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (458, N'B', 6, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (459, N'C', 6, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (460, N'D', 6, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (461, N'E', 6, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (462, N'F', 6, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (463, N'G', 6, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (464, N'A', 7, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (465, N'B', 7, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (466, N'C', 7, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (467, N'D', 7, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (468, N'E', 7, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (469, N'F', 7, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (470, N'G', 7, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (471, N'A', 8, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (472, N'B', 8, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (473, N'C', 8, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (474, N'D', 8, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (475, N'E', 8, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (476, N'F', 8, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (477, N'G', 8, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (478, N'A', 9, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (479, N'B', 9, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (480, N'C', 9, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (481, N'D', 9, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (482, N'E', 9, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (483, N'F', 9, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (484, N'G', 9, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (485, N'A', 10, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (486, N'B', 10, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (487, N'C', 10, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (488, N'D', 10, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (489, N'E', 10, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (490, N'F', 10, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (491, N'G', 10, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (492, N'A', 11, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (493, N'B', 11, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (494, N'C', 11, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (495, N'D', 11, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (496, N'E', 11, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (497, N'F', 11, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (498, N'G', 11, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (499, N'A', 12, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (500, N'B', 12, N'Standard', 4, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (501, N'C', 12, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (502, N'D', 12, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (503, N'E', 12, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (504, N'F', 12, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (505, N'G', 12, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (506, N'A', 13, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (507, N'B', 13, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (508, N'C', 13, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (509, N'D', 13, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (510, N'E', 13, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (511, N'F', 13, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (512, N'G', 13, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (513, N'A', 14, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (514, N'B', 14, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (515, N'C', 14, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (516, N'D', 14, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (517, N'E', 14, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (518, N'F', 14, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (519, N'G', 14, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (520, N'A', 15, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (521, N'B', 15, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (522, N'C', 15, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (523, N'D', 15, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (524, N'E', 15, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (525, N'F', 15, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (526, N'G', 15, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (527, N'A', 16, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (528, N'B', 16, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (529, N'C', 16, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (530, N'D', 16, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (531, N'E', 16, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (532, N'F', 16, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (533, N'G', 16, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (534, N'A', 17, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (535, N'B', 17, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (536, N'C', 17, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (537, N'D', 17, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (538, N'E', 17, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (539, N'F', 17, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (540, N'G', 17, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (541, N'A', 18, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (542, N'B', 18, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (543, N'C', 18, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (544, N'D', 18, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (545, N'E', 18, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (546, N'F', 18, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (547, N'G', 18, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (548, N'A', 19, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (549, N'B', 19, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (550, N'C', 19, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (551, N'D', 19, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (552, N'E', 19, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (553, N'F', 19, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (554, N'G', 19, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (555, N'A', 20, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (556, N'B', 20, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (557, N'C', 20, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (558, N'D', 20, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (559, N'E', 20, N'Standard', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (560, N'F', 20, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (561, N'G', 20, N'VIP', 4, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (562, N'A', 1, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (563, N'B', 1, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (564, N'C', 1, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (565, N'D', 1, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (566, N'E', 1, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (567, N'F', 1, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (568, N'G', 1, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (569, N'A', 2, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (570, N'B', 2, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (571, N'C', 2, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (572, N'D', 2, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (573, N'E', 2, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (574, N'F', 2, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (575, N'G', 2, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (576, N'A', 3, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (577, N'B', 3, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (578, N'C', 3, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (579, N'D', 3, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (580, N'E', 3, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (581, N'F', 3, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (582, N'G', 3, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (583, N'A', 4, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (584, N'B', 4, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (585, N'C', 4, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (586, N'D', 4, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (587, N'E', 4, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (588, N'F', 4, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (589, N'G', 4, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (590, N'A', 5, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (591, N'B', 5, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (592, N'C', 5, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (593, N'D', 5, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (594, N'E', 5, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (595, N'F', 5, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (596, N'G', 5, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (597, N'A', 6, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (598, N'B', 6, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (599, N'C', 6, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (600, N'D', 6, N'Standard', 5, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (601, N'E', 6, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (602, N'F', 6, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (603, N'G', 6, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (604, N'A', 7, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (605, N'B', 7, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (606, N'C', 7, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (607, N'D', 7, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (608, N'E', 7, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (609, N'F', 7, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (610, N'G', 7, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (611, N'A', 8, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (612, N'B', 8, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (613, N'C', 8, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (614, N'D', 8, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (615, N'E', 8, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (616, N'F', 8, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (617, N'G', 8, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (618, N'A', 9, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (619, N'B', 9, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (620, N'C', 9, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (621, N'D', 9, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (622, N'E', 9, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (623, N'F', 9, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (624, N'G', 9, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (625, N'A', 10, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (626, N'B', 10, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (627, N'C', 10, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (628, N'D', 10, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (629, N'E', 10, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (630, N'F', 10, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (631, N'G', 10, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (632, N'A', 11, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (633, N'B', 11, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (634, N'C', 11, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (635, N'D', 11, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (636, N'E', 11, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (637, N'F', 11, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (638, N'G', 11, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (639, N'A', 12, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (640, N'B', 12, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (641, N'C', 12, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (642, N'D', 12, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (643, N'E', 12, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (644, N'F', 12, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (645, N'G', 12, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (646, N'A', 13, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (647, N'B', 13, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (648, N'C', 13, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (649, N'D', 13, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (650, N'E', 13, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (651, N'F', 13, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (652, N'G', 13, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (653, N'A', 14, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (654, N'B', 14, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (655, N'C', 14, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (656, N'D', 14, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (657, N'E', 14, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (658, N'F', 14, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (659, N'G', 14, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (660, N'A', 15, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (661, N'B', 15, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (662, N'C', 15, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (663, N'D', 15, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (664, N'E', 15, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (665, N'F', 15, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (666, N'G', 15, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (667, N'A', 16, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (668, N'B', 16, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (669, N'C', 16, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (670, N'D', 16, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (671, N'E', 16, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (672, N'F', 16, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (673, N'G', 16, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (674, N'A', 17, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (675, N'B', 17, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (676, N'C', 17, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (677, N'D', 17, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (678, N'E', 17, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (679, N'F', 17, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (680, N'G', 17, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (681, N'A', 18, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (682, N'B', 18, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (683, N'C', 18, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (684, N'D', 18, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (685, N'E', 18, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (686, N'F', 18, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (687, N'G', 18, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (688, N'A', 19, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (689, N'B', 19, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (690, N'C', 19, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (691, N'D', 19, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (692, N'E', 19, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (693, N'F', 19, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (694, N'G', 19, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (695, N'A', 20, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (696, N'B', 20, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (697, N'C', 20, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (698, N'D', 20, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (699, N'E', 20, N'Standard', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (700, N'F', 20, N'VIP', 5, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (701, N'G', 20, N'VIP', 5, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (702, N'A', 1, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (703, N'B', 1, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (704, N'C', 1, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (705, N'D', 1, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (706, N'E', 1, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (707, N'F', 1, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (708, N'G', 1, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (709, N'A', 2, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (710, N'B', 2, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (711, N'C', 2, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (712, N'D', 2, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (713, N'E', 2, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (714, N'F', 2, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (715, N'G', 2, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (716, N'A', 3, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (717, N'B', 3, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (718, N'C', 3, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (719, N'D', 3, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (720, N'E', 3, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (721, N'F', 3, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (722, N'G', 3, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (723, N'A', 4, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (724, N'B', 4, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (725, N'C', 4, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (726, N'D', 4, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (727, N'E', 4, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (728, N'F', 4, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (729, N'G', 4, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (730, N'A', 5, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (731, N'B', 5, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (732, N'C', 5, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (733, N'D', 5, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (734, N'E', 5, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (735, N'F', 5, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (736, N'G', 5, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (737, N'A', 6, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (738, N'B', 6, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (739, N'C', 6, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (740, N'D', 6, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (741, N'E', 6, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (742, N'F', 6, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (743, N'G', 6, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (744, N'A', 7, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (745, N'B', 7, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (746, N'C', 7, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (747, N'D', 7, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (748, N'E', 7, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (749, N'F', 7, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (750, N'G', 7, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (751, N'A', 8, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (752, N'B', 8, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (753, N'C', 8, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (754, N'D', 8, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (755, N'E', 8, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (756, N'F', 8, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (757, N'G', 8, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (758, N'A', 9, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (759, N'B', 9, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (760, N'C', 9, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (761, N'D', 9, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (762, N'E', 9, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (763, N'F', 9, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (764, N'G', 9, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (765, N'A', 10, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (766, N'B', 10, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (767, N'C', 10, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (768, N'D', 10, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (769, N'E', 10, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (770, N'F', 10, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (771, N'G', 10, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (772, N'A', 11, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (773, N'B', 11, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (774, N'C', 11, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (775, N'D', 11, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (776, N'E', 11, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (777, N'F', 11, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (778, N'G', 11, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (779, N'A', 12, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (780, N'B', 12, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (781, N'C', 12, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (782, N'D', 12, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (783, N'E', 12, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (784, N'F', 12, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (785, N'G', 12, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (786, N'A', 13, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (787, N'B', 13, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (788, N'C', 13, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (789, N'D', 13, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (790, N'E', 13, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (791, N'F', 13, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (792, N'G', 13, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (793, N'A', 14, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (794, N'B', 14, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (795, N'C', 14, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (796, N'D', 14, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (797, N'E', 14, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (798, N'F', 14, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (799, N'G', 14, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (800, N'A', 15, N'Standard', 6, N'Available')
GO
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (801, N'B', 15, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (802, N'C', 15, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (803, N'D', 15, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (804, N'E', 15, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (805, N'F', 15, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (806, N'G', 15, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (807, N'A', 16, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (808, N'B', 16, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (809, N'C', 16, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (810, N'D', 16, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (811, N'E', 16, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (812, N'F', 16, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (813, N'G', 16, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (814, N'A', 17, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (815, N'B', 17, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (816, N'C', 17, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (817, N'D', 17, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (818, N'E', 17, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (819, N'F', 17, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (820, N'G', 17, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (821, N'A', 18, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (822, N'B', 18, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (823, N'C', 18, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (824, N'D', 18, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (825, N'E', 18, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (826, N'F', 18, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (827, N'G', 18, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (828, N'A', 19, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (829, N'B', 19, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (830, N'C', 19, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (831, N'D', 19, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (832, N'E', 19, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (833, N'F', 19, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (834, N'G', 19, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (835, N'A', 20, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (836, N'B', 20, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (837, N'C', 20, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (838, N'D', 20, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (839, N'E', 20, N'Standard', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (840, N'F', 20, N'VIP', 6, N'Available')
INSERT [dbo].[Seat] ([SeatID], [SeatRow], [SeatNumber], [SeatType], [RoomID], [Status]) VALUES (841, N'G', 20, N'VIP', 6, N'Available')
SET IDENTITY_INSERT [dbo].[Seat] OFF
GO
SET IDENTITY_INSERT [dbo].[Showtime] ON 

INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID], [CinemaID], [RoomID], [StartTime], [EndTime]) VALUES (1, 1, 1, 1, CAST(N'2025-03-26T18:30:00.000' AS DateTime), CAST(N'2025-03-26T21:30:00.000' AS DateTime))
INSERT [dbo].[Showtime] ([ShowtimeID], [MovieID], [CinemaID], [RoomID], [StartTime], [EndTime]) VALUES (2, 1, 1, 1, CAST(N'2025-03-27T17:33:00.000' AS DateTime), CAST(N'2025-03-27T21:33:00.000' AS DateTime))
SET IDENTITY_INSERT [dbo].[Showtime] OFF
GO
SET IDENTITY_INSERT [dbo].[Ticket] ON 

INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (1, 1, 1, 2, 0)
INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (2, 1, 1, 9, 0)
INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (3, 1, 1, 16, 0)
INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (4, 2, 2, 2, 0)
INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (5, 2, 2, 9, 0)
INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (6, 2, 2, 16, 0)
INSERT [dbo].[Ticket] ([TicketID], [OrderID], [ShowtimeID], [SeatID], [Status]) VALUES (7, 2, 2, 23, 0)
SET IDENTITY_INSERT [dbo].[Ticket] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__85FB4E384F13A0B9]    Script Date: 3/25/2025 11:38:46 PM ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Account__A9D1053418B96254]    Script Date: 3/25/2025 11:38:46 PM ******/
ALTER TABLE [dbo].[Account] ADD UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__Promotio__32DBED35CE06A1D5]    Script Date: 3/25/2025 11:38:46 PM ******/
ALTER TABLE [dbo].[Promotion] ADD UNIQUE NONCLUSTERED 
(
	[PromoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((1)) FOR [Avatar]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ((0)) FOR [LoyaltyPoint]
GO
ALTER TABLE [dbo].[Account] ADD  DEFAULT ('None') FOR [MembershipLevel]
GO
ALTER TABLE [dbo].[Combo] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[Combo] ADD  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Order] ADD  DEFAULT ('Processing') FOR [Status]
GO
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((0)) FOR [RemainRedemption]
GO
ALTER TABLE [dbo].[Ticket] ADD  DEFAULT ((0)) FOR [Status]
GO
ALTER TABLE [dbo].[Account]  WITH CHECK ADD FOREIGN KEY([Avatar])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[Blog]  WITH CHECK ADD FOREIGN KEY([BlogPoster])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[CinemaRoom]  WITH CHECK ADD FOREIGN KEY([CinemaID])
REFERENCES [dbo].[Cinema] ([CinemaID])
GO
ALTER TABLE [dbo].[Movie]  WITH CHECK ADD FOREIGN KEY([MoviePoster])
REFERENCES [dbo].[Image] ([ImageID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Order]  WITH CHECK ADD FOREIGN KEY([PromotionID])
REFERENCES [dbo].[Promotion] ([PromotionID])
GO
ALTER TABLE [dbo].[OrderCombo]  WITH CHECK ADD FOREIGN KEY([ComboID])
REFERENCES [dbo].[Combo] ([ComboID])
GO
ALTER TABLE [dbo].[OrderCombo]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Seat]  WITH CHECK ADD FOREIGN KEY([RoomID])
REFERENCES [dbo].[CinemaRoom] ([RoomID])
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movie] ([MovieID])
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD  CONSTRAINT [FK_Showtime_Cinema] FOREIGN KEY([CinemaID])
REFERENCES [dbo].[Cinema] ([CinemaID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Showtime] CHECK CONSTRAINT [FK_Showtime_Cinema]
GO
ALTER TABLE [dbo].[Showtime]  WITH CHECK ADD  CONSTRAINT [FK_Showtime_CinemaRoom] FOREIGN KEY([RoomID])
REFERENCES [dbo].[CinemaRoom] ([RoomID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Showtime] CHECK CONSTRAINT [FK_Showtime_CinemaRoom]
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seat] ([SeatID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seat] ([SeatID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([ShowtimeID])
REFERENCES [dbo].[Showtime] ([ShowtimeID])
GO
ALTER TABLE [dbo].[Ticket]  WITH CHECK ADD FOREIGN KEY([ShowtimeID])
REFERENCES [dbo].[Showtime] ([ShowtimeID])
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
ALTER TABLE [dbo].[Order]  WITH CHECK ADD CHECK  (([Status]='Failed' OR [Status]='Completed' OR [Status]='Processing'))
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
/****** Object:  StoredProcedure [dbo].[UpdateOrderStatus]    Script Date: 3/25/2025 11:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateOrderStatus]
AS
BEGIN
    UPDATE [dbo].[Order]
    SET [Status] = 'Failed'
    WHERE [Status] = 'Processing' 
      AND DATEDIFF(MINUTE, [OrderDate], GETDATE()) > 10;
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSeatStatusForFailedOrders]    Script Date: 3/25/2025 11:38:46 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSeatStatusForFailedOrders]
AS
BEGIN
    -- Delete the Ticket records related to Failed orders
    DELETE FROM [dbo].[Ticket]
    WHERE [OrderID] IN (
        SELECT [OrderID]
        FROM [dbo].[Order]
        WHERE [Status] = 'Failed'
    );

    -- Update the Seat status from Processing to Available
    UPDATE [dbo].[Seat]
    SET [Status] = 'Available'
    WHERE [SeatID] IN (
        SELECT [SeatID]
        FROM [dbo].[Ticket]
        WHERE [OrderID] IN (
            SELECT [OrderID]
            FROM [dbo].[Order]
            WHERE [Status] = 'Failed'
        )
    );

	  DELETE FROM [dbo].[OrderCombo]
    WHERE [OrderID] IN (
        SELECT [OrderID]
        FROM [dbo].[Order]
        WHERE [Status] = 'Failed'
    );
END;
GO
USE [master]
GO
ALTER DATABASE [swp391] SET  READ_WRITE 
GO

-- Create trigger for updating loyalty points and membership level
CREATE TRIGGER [dbo].[UpdateLoyaltyPointsAndMembership]
ON [dbo].[Order]
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Only proceed if the order status has changed to 'Completed'
    IF EXISTS (
        SELECT 1 
        FROM inserted i 
        JOIN deleted d ON i.OrderID = d.OrderID 
        WHERE i.Status = 'Completed' AND d.Status != 'Completed'
    )
    BEGIN
        -- Update loyalty points and membership level
        UPDATE a
        SET 
            a.LoyaltyPoint = ISNULL(a.LoyaltyPoint, 0) + FLOOR(i.TotalAmount / 1000),
            a.MembershipLevel = 
                CASE 
                    WHEN ISNULL(a.LoyaltyPoint, 0) + FLOOR(i.TotalAmount / 1000) > 2000 THEN 'Platinum'
                    WHEN ISNULL(a.LoyaltyPoint, 0) + FLOOR(i.TotalAmount / 1000) > 500 THEN 'Gold'
                    WHEN ISNULL(a.LoyaltyPoint, 0) + FLOOR(i.TotalAmount / 1000) > 150 THEN 'Silver'
                    ELSE a.MembershipLevel
                END
        FROM Account a
        JOIN inserted i ON a.AccountID = i.AccountID
        WHERE i.Status = 'Completed';
    END
END
GO
