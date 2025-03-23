USE [master]
GO
/****** Object:  Database [swp391]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Account]    Script Date: 3/21/2025 3:27:10 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PhoneNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cinema]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[CinemaRoom]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Combo]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Image]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Movie]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Order]    Script Date: 3/21/2025 3:27:10 PM ******/
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
	[Status] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OrderCombo]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[PricingFactor]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Promotion]    Script Date: 3/21/2025 3:27:10 PM ******/
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
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[PromoCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seat]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Showtime]    Script Date: 3/21/2025 3:27:10 PM ******/
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
/****** Object:  Table [dbo].[Ticket]    Script Date: 3/21/2025 3:27:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ticket](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[ShowtimeID] [int] NOT NULL,
	[SeatID] [int] NOT NULL,
	[Price] [float] NOT NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 3/21/2025 3:27:10 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NOT NULL,
	[AccountID] [int] NOT NULL,
	[TransactionDate] [datetime] NOT NULL,
	[PaymentMethod] [nvarchar](50) NOT NULL,
	[PaymentStatus] [nvarchar](50) NOT NULL,
	[Amount] [float] NOT NULL,
	[TransactionCode] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
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
ALTER TABLE [dbo].[Promotion] ADD  DEFAULT ((0)) FOR [RemainRedemption]
GO
ALTER TABLE [dbo].[Ticket] ADD  DEFAULT ((0)) FOR [Status]
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
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([AccountID])
REFERENCES [dbo].[Account] ([AccountID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([OrderID])
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
USE [master]
GO
ALTER DATABASE [swp391] SET  READ_WRITE 
GO
