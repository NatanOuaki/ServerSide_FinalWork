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


INSERT INTO [Events].[dbo].[Events] ([Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES
('Music Concert - Coldplay', '2024-08-01T19:00:00', '2024-08-01T23:00:00', 5000, 'London'),
('France vs Israel - Football', '2024-08-05T21:00:00', '2024-08-05T23:00:00', 10000, 'Paris'),
('Tech Conference 2024', '2024-08-10T09:00:00', '2024-08-10T17:00:00', 2000, 'Dubai'),
('Summer Party 2024', '2024-08-15T20:00:00', '2024-08-16T01:00:00', 1000, 'Tel-Aviv'),
('Greek Food Festival', '2024-08-20T11:00:00', '2024-08-20T23:00:00', 1500, 'Athens'),
('Charity Gala', '2024-08-25T18:00:00', '2024-08-25T23:00:00', 800, 'New-York'),
('Comedy Show Night', '2024-08-30T19:00:00', '2024-08-30T22:00:00', 700, 'Los-Angeles'),
('Outdoor Yoga Retreat', '2024-09-05T08:00:00', '2024-09-05T12:00:00', 200, 'Tokyo'),
('Art Exhibition - Modern Art', '2024-09-10T10:00:00', '2024-09-10T18:00:00', 500, 'Berlin'),
('Book Fair 2024', '2024-09-15T09:00:00', '2024-09-15T18:00:00', 1000, 'New-York'),
('Tech Startup Pitch Day', '2024-09-20T13:00:00', '2024-09-20T17:00:00', 300, 'Ruppin-Academic-Center'),
('Food & Wine Tasting', '2024-09-25T17:00:00', '2024-09-25T22:00:00', 600, 'California'),
('Film Festival 2024', '2024-10-10T10:00:00', '2024-10-10T22:00:00', 800, 'Netanya'),
('Music Festival - Jazz Edition', '2024-10-15T12:00:00', '2024-10-15T23:00:00', 3000, 'Vienna'),
('Sports Expo', '2024-10-20T09:00:00', '2024-10-20T17:00:00', 1200, 'Jerusalem'),
('Dance Competition', '2024-10-25T18:00:00', '2024-10-25T22:00:00', 500, 'Barcelona'),
('New Year’s Eve Gala', '2024-12-31T20:00:00', '2025-01-01T01:00:00', 600, 'Hong-Kong'),
('Winter Wonderland Market', '2024-12-05T10:00:00', '2024-12-05T20:00:00', 1000, 'Paris'),
('Tester for DELETE', '2000-01-01T00:00:00', '2000-01-01T23:59:00', 20, 'Roma'),
('NEW EVENT FROM SWAGGER', '2024-08-06T16:30:00.000', '2024-08-08T20:30:00.000', 1000, 'Phuket'),
('EVENT TO DELETE BY POSTMAN', '2020-09-10T20:15:00.000', '2020-09-10T22:30:00.000', 250000, 'Bogota'),
('EVENT TO DELETE BY CLIENT', '2024-09-20T20:30:00.000' ,'2024-09-22T10:30:00.000', 20,'Nairobi');
GO


INSERT INTO [Events].[dbo].[Users] ([Name], [DateOfBirth]) VALUES
('Avi Cohen', '1985-01-15'),
('Omer Adam', '1993-10-22'),
('Oren Sapira', '1992-07-30'),
('Eden Ben-David', '1988-05-10'),
('Noa Levy', '1995-11-12'),
('Daniel Peretz', '1980-06-25'),
('Itay Levy', '1988-01-25'),
('Yoni Maimon', '1987-02-08'),
('Osher Cohen', '1998-12-15'),
('Nadav Guedj', '1998-11-02'),
('Rotem Sela', '1983-08-16'),
('Aviv Alush', '1982-06-12'),
('Hila Avrahami', '1992-05-15'),
('Moshe Levi', '1984-11-20'),
('Roni Amir', '1991-03-27'),
('Gilad Frank', '1986-07-18'),
('Rivka Klein', '1993-01-09'),
('Shai Cohen', '1989-09-26'),
('Dina Shalom', '1990-12-22'),
('Ariel Yaakov', '1994-06-30'),
('Hanan Ben-Ari', '1987-10-11'),
('Lamine Yamal', '2008-05-23');


INSERT INTO [Events].[dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES
(1, 1, GETDATE()),
(1, 2, GETDATE()),
(2, 3, GETDATE()),
(2, 4, GETDATE()),
(3, 5, GETDATE()),
(3, 6, GETDATE()),
(4, 7, GETDATE()),
(4, 8, GETDATE()),
(5, 9, GETDATE()),
(5, 10, GETDATE()),
(6, 11, GETDATE()),
(6, 12, GETDATE()),
(7, 13, GETDATE()),
(7, 14, GETDATE()),
(8, 15, GETDATE()),
(8, 16, GETDATE()),
(9, 17, GETDATE()),
(9, 18, GETDATE()),
(10, 19, GETDATE()),
(15, 22, GETDATE());
GO
