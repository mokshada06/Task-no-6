CREATE DATABASE Task6;
USE Task6;

CREATE TABLE Users(
user_id INT PRIMARY KEY,
username VARCHAR(50),
country VARCHAR(50),
age INT);

INSERT INTO Users VALUES
(1, 'Virat Sharma', 'India', 24),
(2, 'Jane Smith', 'USA', 29),
(3, 'Ali Khan', 'UAE', 35),
(4, 'Maria Lee', 'UK', 27),
(5, 'Rohit Verma', 'India', 22),
(6, 'Emily dey', 'Canada', 30),
(7, 'Li We', 'China', 38),
(8, 'Ana Gomez', 'Spain', 26),
(9, 'Kevin Park', 'South Korea', 31),
(10, 'Olga Mee', 'Russia', 33);

SELECT * FROM Users;

CREATE TABLE Movies(
movie_id INT PRIMARY KEY,
title VARCHAR(150),
genre VARCHAR(50),
release_year INT);

INSERT INTO Movies VALUES
(101, 'Inception', 'Sci-Fi', 2010),
(102, 'the Dark Knight', 'Action', 2008),
(103, 'Parasite', 'Thirller', 2019),
(104, 'Dangal', 'Drama', 2016),
(105, 'Interstellar', 'Sci-Fi', 2014),
(106, 'Joker', 'Drama', 2019),
(107, 'The Matrix', 'Action', 199),
(108, 'The God Father', 'Crime', 1972),
(109, '3 Idiots', 'Comedy', 2009),
(110, 'Avengers : Endgame', 'Action', 2019);

SELECT * FROM Movies;

CREATE TABLE WatchHistory(
watch_id VARCHAR(15) PRIMARY KEY,
user_id INT,
movie_id INT,
watch_date DATE,
duration_min INT,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (movie_id) REFERENCES Movies(movie_id));
    
INSERT INTO WatchHistory VALUES
('A1', 1, 101, '2025-06-01', 120),
('B2', 2, 102, '2025-06-05', 150),
('C3', 1, 103, '2025-06-10', 132),
('D4', 3, 104, '2025-06-11', 140),
('E5', 4, 101, '2025-06-13', 118),
('F6', 5, 106, '2025-06-14', 122),
('G7', 6, 105, '2025-06-15', 169),
('H8', 7, 109, '2025-06-16', 130),
('I9', 8, 107, '2025-06-17', 135),
('J10', 9, 110, '2025-06-18', 180);

SELECT * FROM WatchHistory;

CREATE TABLE Ratings (
rating_id VARCHAR(15) PRIMARY KEY,
user_id INT,
movie_id INT,
rating INT CHECK (rating BETWEEN 1 AND 50),
rating_date DATE,
FOREIGN KEY (user_id) REFERENCES Users(user_id),
FOREIGN KEY (movie_id) REFERENCES Movies(movie_id));

INSERT INTO Ratings VALUES
('AB1', 1, 101 ,5, '2025-06-02'),
('BC2', 2, 102, 4, '2025-06-06'),
('CD3', 1, 101, 3, '2025-06-11'),
('DE4', 3, 104, 4, '2025-06-12'),
('EF5', 4, 101, 5, '2025-06-14'),
('FG6', 5, 106, 2, '2025-06-15'),
('GH7', 6, 105, 5, '2025-06-16'),
('HI8', 7, 109, 4, '2025-06-17'),
('IJ9', 8, 107, 3, '2025-06-18'),
('JK10', 9, 110, 4, '2025-06-19');

SELECT * FROM Ratings;


SELECT username, 
       (SELECT COUNT(*) FROM WatchHistory) AS Total_Watched  
FROM Users;

SELECT username,
       (SELECT AVG(rating) FROM Ratings r WHERE r.user_id = u.user_id) AS Avg_User_Rating
FROM Users u;

SELECT username FROM Users
WHERE user_id IN (
    SELECT user_id FROM Ratings WHERE rating = 5);

SELECT Movies.title, AVG_R.avg_rating
FROM Movies
JOIN (
    SELECT movie_id, AVG(rating) AS avg_rating
    FROM Ratings
    GROUP BY movie_id
) AS AVG_R
ON Movies.movie_id = AVG_R.movie_id;

SELECT username,
       (SELECT COUNT(*) FROM WatchHistory WHERE WatchHistory.user_id = Users.user_id) 
       AS total_movies_watched
FROM Users;

SELECT username
FROM Users
WHERE user_id IN (
    SELECT user_id FROM Ratings WHERE rating = 5);

SELECT title
FROM Movies
WHERE EXISTS (
    SELECT 1 FROM Ratings WHERE Ratings.movie_id = Movies.movie_id);

SELECT username, age
FROM Users
WHERE age > (SELECT AVG(age) FROM Users);
