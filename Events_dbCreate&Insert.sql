USE [master]
GO
/****** Object:  Database [Events]    Script Date: 25-Jul-24 18:53:52 ******/
CREATE DATABASE [Events]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Events', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Events.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Events_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Events_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Events] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Events].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Events] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Events] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Events] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Events] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Events] SET ARITHABORT OFF 
GO
ALTER DATABASE [Events] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Events] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Events] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Events] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Events] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Events] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Events] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Events] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Events] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Events] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Events] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Events] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Events] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Events] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Events] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Events] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Events] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Events] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Events] SET  MULTI_USER 
GO
ALTER DATABASE [Events] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Events] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Events] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Events] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Events] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Events] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Events] SET QUERY_STORE = ON
GO
ALTER DATABASE [Events] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Events]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 25-Jul-24 18:53:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Events](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[MaxRegistrations] [int] NOT NULL,
	[Location] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_Events] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventUser]    Script Date: 25-Jul-24 18:53:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventUser](
	[EventRef] [int] NOT NULL,
	[UserRef] [int] NOT NULL,
	[Creation] [datetime] NOT NULL,
 CONSTRAINT [PK_EventUser] PRIMARY KEY CLUSTERED 
(
	[EventRef] ASC,
	[UserRef] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 25-Jul-24 18:53:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[DateOfBirth] [date] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Events] ON 

INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (1, N'Music Concert - Coldplay', CAST(N'2024-08-01T19:00:00.000' AS DateTime), CAST(N'2024-08-01T23:00:00.000' AS DateTime), 5000, N'London')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (2, N'France vs Israel - Football', CAST(N'2024-08-05T21:00:00.000' AS DateTime), CAST(N'2024-08-05T23:00:00.000' AS DateTime), 10000, N'Paris')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (3, N'Tech Conference 2024', CAST(N'2024-08-10T09:00:00.000' AS DateTime), CAST(N'2024-08-10T17:00:00.000' AS DateTime), 2000, N'Dubai')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (4, N'Summer Party 2024', CAST(N'2024-08-15T20:00:00.000' AS DateTime), CAST(N'2024-08-16T01:00:00.000' AS DateTime), 1000, N'Tel-Aviv')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (5, N'Greek Food Festival', CAST(N'2024-08-20T11:00:00.000' AS DateTime), CAST(N'2024-08-20T23:00:00.000' AS DateTime), 1500, N'Athens')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (6, N'Charity Gala', CAST(N'2024-08-25T18:00:00.000' AS DateTime), CAST(N'2024-08-25T23:00:00.000' AS DateTime), 800, N'New-York')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (7, N'Comedy Show Night', CAST(N'2024-08-30T19:00:00.000' AS DateTime), CAST(N'2024-08-30T22:00:00.000' AS DateTime), 700, N'Los-Angeles')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (8, N'Outdoor Yoga Retreat', CAST(N'2024-09-05T08:00:00.000' AS DateTime), CAST(N'2024-09-05T12:00:00.000' AS DateTime), 200, N'Tokyo')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (9, N'Art Exhibition - Modern Art', CAST(N'2024-09-10T10:00:00.000' AS DateTime), CAST(N'2024-09-10T18:00:00.000' AS DateTime), 500, N'Berlin')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (10, N'Book Fair 2024', CAST(N'2024-09-15T09:00:00.000' AS DateTime), CAST(N'2024-09-15T18:00:00.000' AS DateTime), 1000, N'New-York')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (11, N'Tech Startup Pitch Day', CAST(N'2024-09-20T13:00:00.000' AS DateTime), CAST(N'2024-09-20T17:00:00.000' AS DateTime), 300, N'Ruppin-Academic-Center')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (12, N'Food & Wine Tasting', CAST(N'2024-09-25T17:00:00.000' AS DateTime), CAST(N'2024-09-25T22:00:00.000' AS DateTime), 600, N'California')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (13, N'Film Festival 2024', CAST(N'2024-10-10T10:00:00.000' AS DateTime), CAST(N'2024-10-10T22:00:00.000' AS DateTime), 800, N'Netanya')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (14, N'Music Festival - Jazz Edition', CAST(N'2024-10-15T12:00:00.000' AS DateTime), CAST(N'2024-10-15T23:00:00.000' AS DateTime), 3000, N'Vienna')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (15, N'Sports Expo', CAST(N'2024-10-20T09:00:00.000' AS DateTime), CAST(N'2024-10-20T17:00:00.000' AS DateTime), 1200, N'Jerusalem')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (16, N'Dance Competition', CAST(N'2024-10-25T18:00:00.000' AS DateTime), CAST(N'2024-10-25T22:00:00.000' AS DateTime), 500, N'Barcelona')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (17, N'New Year’s Eve Gala', CAST(N'2024-12-31T20:00:00.000' AS DateTime), CAST(N'2025-01-01T01:00:00.000' AS DateTime), 600, N'Hong-Kong')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (18, N'Winter Wonderland Market', CAST(N'2024-12-05T10:00:00.000' AS DateTime), CAST(N'2024-12-05T20:00:00.000' AS DateTime), 1000, N'Paris')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (24, N'NEW EVENT FROM SWAGGER', CAST(N'2024-08-06T16:30:00.000' AS DateTime), CAST(N'2024-08-08T20:30:00.000' AS DateTime), 1000, N'Phuket')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (34, N'EVENT TO DELETE BY POSTMAN', CAST(N'2020-09-10T20:15:00.000' AS DateTime), CAST(N'2020-09-10T22:30:00.000' AS DateTime), 250000, N'Bogota')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (35, N'EVENT TO DELETE BY CLIENT', CAST(N'2024-09-20T20:30:00.000' AS DateTime), CAST(N'2024-09-22T10:30:00.000' AS DateTime), 20, N'Nairobi')
SET IDENTITY_INSERT [dbo].[Events] OFF
GO
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (1, 1, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (1, 2, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (2, 3, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (2, 4, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (2, 29, CAST(N'2024-07-25T12:49:21.953' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (3, 5, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (3, 6, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (4, 7, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (4, 8, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (5, 9, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (5, 10, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (6, 11, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (6, 12, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (7, 13, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (7, 14, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (8, 15, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (8, 16, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (9, 17, CAST(N'2024-07-23T12:01:38.463' AS DateTime))
INSERT [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES (24, 22, CAST(N'2024-07-23T18:38:27.103' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (1, N'Avi Cohen', CAST(N'1985-01-15' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (2, N'Omer Adam', CAST(N'1993-10-22' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (3, N'Oren Sapira', CAST(N'1992-07-30' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (4, N'Eden Ben-David', CAST(N'1988-05-10' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (5, N'Noa Levy', CAST(N'1995-11-12' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (6, N'Daniel Peretz', CAST(N'1980-06-25' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (7, N'Itay Levy', CAST(N'1988-01-25' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (8, N'Yoni Maimon', CAST(N'1987-02-08' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (9, N'Osher Cohen', CAST(N'1998-12-15' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (10, N'Nadav Guedj', CAST(N'1998-11-02' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (11, N'Rotem Sela', CAST(N'1983-08-16' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (12, N'Aviv Alush', CAST(N'1982-06-12' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (13, N'Hila Avrahami', CAST(N'1992-05-15' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (14, N'Moshe Levi', CAST(N'1984-11-20' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (15, N'Roni Amir', CAST(N'1991-03-27' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (16, N'Gilad Frank', CAST(N'1986-07-18' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (17, N'Rivka Klein', CAST(N'1993-01-09' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (19, N'Dina Shalom', CAST(N'1990-12-22' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (20, N'Ariel Yaakov', CAST(N'1994-06-30' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (21, N'Hanan Ben-Ari', CAST(N'1987-10-11' AS Date))
INSERT [dbo].[Users] ([ID], [Name], [DateOfBirth]) VALUES (22, N'Lamine Yamal', CAST(N'2008-05-23' AS Date))
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
ALTER TABLE [dbo].[EventUser] ADD  CONSTRAINT [DF_EventUser_Creation]  DEFAULT (getdate()) FOR [Creation]
GO
ALTER TABLE [dbo].[EventUser]  WITH CHECK ADD  CONSTRAINT [FK_EventUser_Events] FOREIGN KEY([EventRef])
REFERENCES [dbo].[Events] ([ID])
GO
ALTER TABLE [dbo].[EventUser] CHECK CONSTRAINT [FK_EventUser_Events]
GO
ALTER TABLE [dbo].[EventUser]  WITH CHECK ADD  CONSTRAINT [FK_EventUser_Users] FOREIGN KEY([UserRef])
REFERENCES [dbo].[Users] ([ID])
GO
ALTER TABLE [dbo].[EventUser] CHECK CONSTRAINT [FK_EventUser_Users]
GO
USE [master]
GO
ALTER DATABASE [Events] SET  READ_WRITE 
GO
