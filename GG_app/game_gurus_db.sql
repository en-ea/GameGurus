-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 26, 2025 at 07:20 PM
-- Server version: 9.2.0
-- PHP Version: 8.2.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `game_gurus_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE `Account` (
  `user_ID` varchar(50) DEFAULT NULL,
  `profile_picture` blob,
  `tip_ID` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Account`
--

INSERT INTO `Account` (`user_ID`, `profile_picture`, `tip_ID`) VALUES
('ASH', NULL, 'T4'),
('LG', NULL, 'T1'),
('EN', NULL, 'T2'),
('YU', NULL, 'T3'),
('U1', NULL, 'T5');

-- --------------------------------------------------------

--
-- Table structure for table `Comment`
--

CREATE TABLE `Comment` (
  `comment_ID` varchar(50) NOT NULL,
  `tip_ID` varchar(50) DEFAULT NULL,
  `user_ID` varchar(50) DEFAULT NULL,
  `content` varchar(1500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Comment`
--

INSERT INTO `Comment` (`comment_ID`, `tip_ID`, `user_ID`, `content`) VALUES
('C1', 'T1', 'U5', 'Great tip! Helped me improve my K/D ratio.'),
('C2', 'T2', 'U2', 'I never thought about wave control like that, thanks!'),
('C3', 'T3', 'U4', 'Classic advice but essential for survival.'),
('C4', 'T4', 'U3', 'That boss drove me crazy. This tip saved me!'),
('C5', 'T5', 'U1', 'Building mechanics are tricky, but this helps a lot.');

-- --------------------------------------------------------

--
-- Table structure for table `Game`
--

CREATE TABLE `Game` (
  `game_name` varchar(255) NOT NULL,
  `genre` varchar(100) DEFAULT NULL,
  `description` varchar(1000) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Game`
--

INSERT INTO `Game` (`game_name`, `genre`, `description`) VALUES
('Among Us', 'Party', 'A multiplayer social deduction game where players work together as crewmates on a spaceship while trying to identify and eliminate impostors before they sabotage the mission.'),
('Breath of the Wild', 'Action-Adventure', 'The Legend of Zelda: Breath of the Wild is an expansive open-world action-adventure game where players explore the vast land of Hyrule. Combining exploration, puzzle-solving, and combat, it offers freedom to approach challenges in multiple ways.'),
('Clash Royale', 'Strategy/Card Game', 'Clash Royale is a real-time multiplayer strategy game combining card collection, tower defense, and fast-paced duels. Players build custom decks and deploy units to destroy their opponent’s towers while defending their own.'),
('Cyberpunk 2077', 'RPG', 'A futuristic open-world RPG set in the neon-lit Night City, where players take on the role of V, a mercenary seeking immortality. Customize your character, make impactful choices, and engage in thrilling combat.'),
('Dark Souls III', 'Action RPG', 'A punishing yet rewarding action RPG set in a dark, gothic world filled with terrifying enemies and challenging bosses. Master strategic combat, uncover deep lore, and endure a test of skill and patience.'),
('Fortnite', 'Battle Royale', 'Fortnite is a fast-paced battle royale game where players build structures while fighting to be the last one standing. Featuring vibrant graphics and constant updates, it combines shooting mechanics with creative building elements.'),
('Hollow Knight', 'Metroidvania', 'A beautifully crafted 2D action platformer set in the hauntingly mysterious world of Hallownest. Explore interconnected environments, battle dangerous creatures, and unlock powerful abilities.'),
('Minecraft', 'Sandbox', 'A creative and survival-based sandbox game where players can build structures, craft tools, explore an endless world, and fight off monsters. With both single and multiplayer modes, the possibilities are endless.'),
('Stardew Valley', 'Simulation', 'A relaxing farming simulation game where players take over a rundown farm, grow crops, raise animals, interact with villagers, and even explore caves filled with monsters and treasures.'),
('Super Mario Odyssey', 'Platformer', 'A 3D platforming adventure featuring Mario and his new companion, Cappy. Travel across unique kingdoms, solve puzzles, and defeat Bowser to rescue Princess Peach.'),
('The Elder Scrolls V: Skyrim', 'RPG', 'An expansive open-world fantasy RPG set in the land of Skyrim. Players can explore vast landscapes, complete quests, fight dragons, and shape their own story through choices and character progression.'),
('The Legend of Zelda: Breath of the Wild', 'Adventure', 'An open-world action-adventure game set in the kingdom of Hyrule. Players can climb, glide, and battle their way through breathtaking landscapes while uncovering the story of the fallen kingdom.'),
('Valorant', 'FPS', 'A team-based tactical shooter where players select unique agents, each with special abilities. Combining precise gunplay with strategic teamwork, this competitive game offers intense 5v5 matches.');

-- --------------------------------------------------------

--
-- Table structure for table `Tip`
--

CREATE TABLE `Tip` (
  `tip_ID` varchar(50) NOT NULL,
  `game_name` varchar(255) DEFAULT NULL,
  `user_ID` varchar(50) DEFAULT NULL,
  `focus_area` varchar(100) DEFAULT NULL,
  `level` varchar(50) DEFAULT NULL,
  `platform` varchar(50) DEFAULT NULL,
  `content` varchar(2500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Tip`
--

INSERT INTO `Tip` (`tip_ID`, `game_name`, `user_ID`, `focus_area`, `level`, `platform`, `content`) VALUES
('T1', 'Minecraft', 'ASH', 'Gameplay', 'For Beginners', 'PC', 'When starting out in Minecraft, prioritize gathering basic resources like wood, stone, and food. Craft essential tools such as a pickaxe, axe, and swg your builord to speed up resource collection and protect yourself from hostile mobs. Build a simple shelter before nightfall to avoid dangers like zombies and skeletons. Also, remember to craft torches early on—they will help you light up caves and prevent mob spawns.'),
('T2', 'Fortnite', 'LG', 'Gameplay', 'For Intermediate', 'PC', 'As an intermediate Fortnite player, focus on improvinding skills. Practice quickly building walls, ramps, and boxes during fights to gain the high ground. Also, learn to edit structures swiftly, allowing you to outmaneuver opponents. Pay attention to the storm circle and always rotate early to avoid getting caught off guard.'),
('T3', 'Valorant', 'EN', 'Gameplay', 'For Pros', 'PC', 'Professional Valorant players should focus on perfecting crosshair placement and minimizing unnecessary movements. Communicate precisely with your team and coordinate utility usage (smokes, flashes, etc.) to execute site takes or defenses efficiently. Regularly review your gameplay replays to identify mistakes and improve decision-making under pressure.'),
('T4', 'Clash Royale', 'YU', 'Strategy', 'All above', 'Mobile', 'Whether you are new or experienced in Clash Royale, always pay attention to elixir management. Avoid overcommitting by deploying too many high-cost cards at once. Learn to counter popular decks and have a balance of offensive and defensive units. Don\'t forget to watch top players’ matches to understand advanced tactics.'),
('T5', 'Breath of the Wild', 'ASH', 'Lore', 'For Beginners', 'Console', 'In Breath of the Wild, exploration is key. Always keep an eye out for shrines, Korok seeds, and hidden chests. Cooking food with various ingredients not only restores health but grants powerful buffs. Spend time understanding the backstory by visiting various villages and speaking to NPCs to fully immerse yourself in Hyrule’s lore.');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `user_ID` varchar(50) NOT NULL,
  `username` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'User'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`user_ID`, `username`, `email`, `password`, `role`) VALUES
('ASH', 'ArtemShkurat', 'artem@example.com', 'admin_password1', 'Admin'),
('EN', 'Enea', 'enea@example.com', 'admin_password3', 'Admin'),
('LG', 'LuisGarcia', 'luis@example.com', 'admin_password2', 'Admin'),
('U1', 'GamerKing', 'gamerking@example.com', 'hashed_password1', 'User'),
('U2', 'ProPlayer99', 'proplayer99@example.com', 'hashed_password2', 'User'),
('U3', 'CasualGamer', 'casualg@example.com', 'hashed_password3', 'User'),
('U4', 'StrategyMaster', 'strategym@example.com', 'hashed_password4', 'User'),
('U5', 'NoobSlayer', 'noobslayer@example.com', 'hashed_password5', 'User'),
('YU', 'Yulian', 'yulian@example.com', 'admin_password4', 'Admin');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Account`
--
ALTER TABLE `Account`
  ADD KEY `user_ID` (`user_ID`),
  ADD KEY `tip_ID` (`tip_ID`);

--
-- Indexes for table `Comment`
--
ALTER TABLE `Comment`
  ADD PRIMARY KEY (`comment_ID`),
  ADD KEY `tip_ID` (`tip_ID`),
  ADD KEY `user_ID` (`user_ID`);

--
-- Indexes for table `Game`
--
ALTER TABLE `Game`
  ADD PRIMARY KEY (`game_name`);

--
-- Indexes for table `Tip`
--
ALTER TABLE `Tip`
  ADD PRIMARY KEY (`tip_ID`),
  ADD KEY `game_name` (`game_name`),
  ADD KEY `user_ID` (`user_ID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`user_ID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Account`
--
ALTER TABLE `Account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `Users` (`user_ID`),
  ADD CONSTRAINT `account_ibfk_2` FOREIGN KEY (`tip_ID`) REFERENCES `Tip` (`tip_ID`);

--
-- Constraints for table `Comment`
--
ALTER TABLE `Comment`
  ADD CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`tip_ID`) REFERENCES `Tip` (`tip_ID`),
  ADD CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_ID`) REFERENCES `Users` (`user_ID`);

--
-- Constraints for table `Tip`
--
ALTER TABLE `Tip`
  ADD CONSTRAINT `tip_ibfk_1` FOREIGN KEY (`game_name`) REFERENCES `Game` (`game_name`),
  ADD CONSTRAINT `tip_ibfk_2` FOREIGN KEY (`user_ID`) REFERENCES `Users` (`user_ID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
