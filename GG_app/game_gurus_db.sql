-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Oct 30, 2022 at 09:54 AM
-- Server version: 8.0.24
-- PHP Version: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sd2-db`
--

-- --------------------------------------------------------

-- Create tables
CREATE TABLE Users (
    user_ID VARCHAR(50) PRIMARY KEY,
    username VARCHAR(255),
    email VARCHAR(255),
    password VARCHAR(255),
    role VARCHAR(100)
);

CREATE TABLE Game (
    game_name VARCHAR(255) PRIMARY KEY,
    genre VARCHAR(100),
    description VARCHAR(1000)
);

CREATE TABLE Tip (
    tip_ID VARCHAR(50) PRIMARY KEY,
    game_name VARCHAR(255),
    user_ID VARCHAR(50),
    category VARCHAR(100),
    focus_area VARCHAR(100),
    level VARCHAR(50),
    platform VARCHAR(50),
    content VARCHAR(2500),
    FOREIGN KEY (game_name) REFERENCES Game(game_name),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

CREATE TABLE Comment (
    comment_ID VARCHAR(50) PRIMARY KEY,
    tip_ID VARCHAR(50),
    user_ID VARCHAR(50),
    content VARCHAR(1500),
    FOREIGN KEY (tip_ID) REFERENCES Tip(tip_ID),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID)
);

CREATE TABLE Account (
    user_ID VARCHAR(50),
    profile_picture BLOB,
    tip_ID VARCHAR(50),
    FOREIGN KEY (user_ID) REFERENCES Users(user_ID),
    FOREIGN KEY (tip_ID) REFERENCES Tip(tip_ID)
);

-- Insert data into Users table
INSERT INTO Users (user_ID, username, email, password, role) VALUES
('U001', 'GamerKing', 'gamerking@example.com', 'hashed_password1', 'Admin'),
('U002', 'ProPlayer99', 'proplayer99@example.com', 'hashed_password2', 'User'),
('U003', 'CasualGamer', 'casualg@example.com', 'hashed_password3', 'User'),
('U004', 'StrategyMaster', 'strategym@example.com', 'hashed_password4', 'Moderator'),
('U005', 'NoobSlayer', 'noobslayer@example.com', 'hashed_password5', 'User');

-- Insert data into Game table
INSERT INTO Game (game_name, genre, description) VALUES
('Call of Duty: Modern Warfare', 'Shooter', 'A fast-paced first-person shooter with intense multiplayer battles.'),
('League of Legends', 'MOBA', 'A team-based strategy game with unique champions and competitive gameplay.'),
('Minecraft', 'Sandbox', 'A sandbox game allowing players to build and explore infinite worlds.'),
('Elden Ring', 'Action RPG', 'An open-world action RPG with challenging combat and deep lore.'),
('Fortnite', 'Battle Royale', 'A battle royale game with building mechanics and vibrant graphics.');

-- Insert data into Tip table
INSERT INTO Tip (tip_ID, game_name, user_ID, category, focus_area, level, platform, content) VALUES
('T001', 'Call of Duty: Modern Warfare', 'U002', 'Strategy', 'Multiplayer', 'Intermediate', 'PC', 'Always check corners and use cover effectively to survive longer.'),
('T002', 'League of Legends', 'U004', 'Character Guide', 'Top Lane', 'Advanced', 'PC', 'Master wave control to freeze the lane and gain an advantage.'),
('T003', 'Minecraft', 'U003', 'Building', 'Survival Mode', 'Beginner', 'PC', 'Always carry a water bucket to safely descend cliffs and extinguish lava.'),
('T004', 'Elden Ring', 'U001', 'Combat', 'Boss Fights', 'Expert', 'Console', 'Learn boss attack patterns and keep stamina for dodging, not attacking.'),
('T005', 'Fortnite', 'U005', 'Building', 'Endgame', 'Intermediate', 'PC', 'Use quick ramps and walls to gain high ground during final circles.');

-- Insert data into Comment table
INSERT INTO Comment (comment_ID, tip_ID, user_ID, content) VALUES
('C001', 'T001', 'U005', 'Great tip! Helped me improve my K/D ratio.'),
('C002', 'T002', 'U002', 'I never thought about wave control like that, thanks!'),
('C003', 'T003', 'U004', 'Classic advice but essential for survival.'),
('C004', 'T004', 'U003', 'That boss drove me crazy. This tip saved me!'),
('C005', 'T005', 'U001', 'Building mechanics are tricky, but this helps a lot.');

-- Insert data into Account table
INSERT INTO Account (user_ID, profile_picture, tip_ID) VALUES
('U001', NULL, 'T004'),
('U002', NULL, 'T001'),
('U003', NULL, 'T003'),
('U004', NULL, 'T002'),
('U005', NULL, 'T005');
