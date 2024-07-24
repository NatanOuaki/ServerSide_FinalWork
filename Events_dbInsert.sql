INSERT INTO [dbo].[Events] ([Name], [StartDate], [EndDate], [MaxRegistrations], [Location]) VALUES
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
('Tester for DELETE', '2000-01-01 00:00:00', '2000-01-01 23:59:00', 20, 'Roma');
GO

-- Insert 20 users
INSERT INTO [dbo].[Users] ([Name], [DateOfBirth]) VALUES
('Avi Cohen', '1985-01-15'),
('Omer Adam', '1990-03-22'),
('Oren Sapira', '1992-07-30'),
('Eden Ben-David', '1988-05-10'),
('Noa Levy', '1995-11-12'),
('Daniel Peretz', '1980-06-25'),
('Itay Levy', '1993-09-14'),
('Yoni Maimon', '1987-02-08'),
('Osher Cohen', '1994-04-18'),
('Nadav Guedj', '1991-10-03'),
('Rotem Sela', '1996-12-05'),
('Aviv Alush', '1989-08-21'),
('Hila Avrahami', '1992-05-15'),
('Moshe Levi', '1984-11-20'),
('Roni Amir', '1991-03-27'),
('Gilad Frank', '1986-07-18'),
('Rivka Klein', '1993-01-09'),
('Shai Cohen', '1989-09-26'),
('Dina Shalom', '1990-12-22'),
('Ariel Yaakov', '1994-06-30'),
('Hanan Ben-Ari', '1987-10-11');
GO

-- Insert some EventUser records
-- Ensure EventRef and UserRef values are correct and exist in Events and Users tables
INSERT INTO [dbo].[EventUser] ([EventRef], [UserRef], [Creation]) VALUES
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
(10, 20, GETDATE());
GO
