
USE [Events]
GO
/****** Object:  Table [dbo].[Events]    Script Date: 20/07/2024 14:56:10 ******/
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
/****** Object:  Table [dbo].[EventUser]    Script Date: 20/07/2024 14:56:10 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 20/07/2024 14:56:10 ******/
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
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (17, N'New Year�s Eve Gala', CAST(N'2024-12-31T20:00:00.000' AS DateTime), CAST(N'2025-01-01T01:00:00.000' AS DateTime), 600, N'Hong-Kong')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (18, N'Winter Wonderland Market', CAST(N'2024-12-05T10:00:00.000' AS DateTime), CAST(N'2024-12-05T20:00:00.000' AS DateTime), 1000, N'Paris')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (24, N'NEW EVENT FROM SWAGGER', CAST(N'2024-08-06T16:30:00.000' AS DateTime), CAST(N'2024-08-08T20:30:00.000' AS DateTime), 1000, N'Phuket')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (34, N'EVENT TO DELETE BY POSTMAN', CAST(N'2020-09-10T20:15:00.000' AS DateTime), CAST(N'2020-09-10T22:30:00.000' AS DateTime), 250000, N'Bogota')
INSERT [dbo].[Events] ([ID], [Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES (35, N'EVENT TO DELETE BY CLIENT', CAST(N'2024-09-20T20:30:00.000' AS DateTime), CAST(N'2024-09-22T10:30:00.000' AS DateTime), 20, N'Nairobi')
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
GO