-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Apr 09, 2025 at 11:00 PM
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
  `user_id` int DEFAULT NULL,
  `profile_picture` blob,
  `saved_tips` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Account`
--

INSERT INTO `Account` (`user_id`, `profile_picture`, `saved_tips`) VALUES
(1, NULL, 3),
(2, NULL, 1),
(3, NULL, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `id` int NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Categories`
--

INSERT INTO `Categories` (`id`, `name`) VALUES
(1, 'Action'),
(2, 'Adventure'),
(10, 'Battle Royale'),
(9, 'Card Game'),
(11, 'Metroidvania'),
(7, 'Party'),
(8, 'Platformer'),
(3, 'RPG'),
(12, 'Sandbox'),
(6, 'Shooter'),
(13, 'Simulation'),
(5, 'Sports'),
(4, 'Strategy');

-- --------------------------------------------------------

--
-- Table structure for table `Comments`
--

CREATE TABLE `Comments` (
  `id` int NOT NULL,
  `content` text NOT NULL,
  `tip_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Comments`
--

INSERT INTO `Comments` (`id`, `content`, `tip_id`, `user_id`, `created_at`) VALUES
(1, 'This really helped me defeat the boss!', 2, 2, '2025-04-03 19:13:55'),
(2, 'The ball roll is essential for higher difficulty.', 3, 3, '2025-04-03 19:13:55');

-- --------------------------------------------------------

--
-- Table structure for table `Games`
--

CREATE TABLE `Games` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `platform` varchar(100) DEFAULT NULL,
  `release_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `image_url` blob
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Games`
--

INSERT INTO `Games` (`id`, `title`, `description`, `platform`, `release_date`, `image_url`) VALUES
(1, 'The Legend of Zelda', 'An open-world action-adventure game', 'Nintendo Switch', '2017-03-03 00:00:00', NULL),
(2, 'Elden Ring', 'An action RPG by FromSoftware', 'PlayStation, Xbox, PC', '2022-02-25 00:00:00', NULL),
(3, 'FIFA 25', 'A football simulation game', 'PlayStation, Xbox, PC', '2024-09-07 00:00:00', NULL),
(4, 'Call of Duty', 'A first-person shooter game', 'PlayStation, Xbox, PC', '2022-10-28 00:00:00', NULL),
(5, 'The Elder Scrolls V: Skyrim', 'An expansive open-world fantasy RPG set in the land of Skyrim. Players can explore vast landscapes, complete quests, fight dragons, and shape their own story through choices and character progression.', 'PC, PS4, Xbox One, Switch', '2025-04-05 11:23:50', NULL),
(6, 'Dark Souls III', 'A punishing yet rewarding action RPG set in a dark, gothic world filled with terrifying enemies and challenging bosses. Master strategic combat, uncover deep lore, and endure a test of skill and patience.', 'PC, PS4, Xbox One', '2025-04-05 11:23:50', NULL),
(7, 'Minecraft', 'A creative and survival-based sandbox game where players can build structures, craft tools, explore an endless world, and fight off monsters. With both single and multiplayer modes, the possibilities are endless.', 'PC, PS4, Xbox One, Switch, Mobile', '2025-04-05 11:23:50', NULL),
(8, 'Valorant', 'A team-based tactical shooter where players select unique agents, each with special abilities. Combining precise gunplay with strategic teamwork, this competitive game offers intense 5v5 matches.', 'PC', '2025-04-05 11:23:50', NULL),
(9, 'Stardew Valley', 'A relaxing farming simulation game where players take over a rundown farm, grow crops, raise animals, interact with villagers, and even explore caves filled with monsters and treasures.', 'PC, PS4, Xbox One, Switch, Mobile', '2025-04-05 11:23:50', NULL),
(10, 'Hollow Knight', 'A beautifully crafted 2D action platformer set in the hauntingly mysterious world of Hallownest. Explore interconnected environments, battle dangerous creatures, and unlock powerful abilities.', 'PC, PS4, Xbox One, Switch', '2025-04-05 11:23:50', NULL),
(11, 'Cyberpunk 2077', 'A futuristic open-world RPG set in the neon-lit Night City, where players take on the role of V, a mercenary seeking immortality. Customize your character, make impactful choices, and engage in thrilling combat.', 'PC, PS4, PS5, Xbox One, Xbox Series X/S', '2025-04-05 11:23:50', NULL),
(12, 'Among Us', 'A multiplayer social deduction game where players work together as crewmates on a spaceship while trying to identify and eliminate impostors before they sabotage the mission.', 'PC, Switch, Mobile, PS4, Xbox One', '2025-04-05 11:23:50', NULL),
(13, 'Fortnite', 'Fortnite is a fast-paced battle royale game where players build structures while fighting to be the last one standing.', 'PC, PS4, PS5, Xbox One, Xbox Series X/S, Switch, Mobile', '2025-04-05 11:23:50', NULL),
(14, 'Clash Royale', 'Clash Royale is a real-time multiplayer strategy game combining card collection, tower defense, and fast-paced duels.', 'Mobile', '2025-04-05 11:23:50', NULL),
(15, 'Super Mario Odyssey', 'A 3D platforming adventure featuring Mario and his new companion, Cappy. Travel across unique kingdoms, solve puzzles, and defeat Bowser to rescue Princess Peach.', 'Switch', '2025-04-05 11:23:50', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Game_Category`
--

CREATE TABLE `Game_Category` (
  `game_id` int NOT NULL,
  `category_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Game_Category`
--

INSERT INTO `Game_Category` (`game_id`, `category_id`) VALUES
(1, 1),
(2, 1),
(1, 2),
(2, 3),
(5, 3),
(6, 3),
(11, 3),
(14, 4),
(3, 5),
(4, 6),
(8, 6),
(12, 7),
(15, 8),
(14, 9),
(13, 10),
(10, 11),
(7, 12),
(9, 13);

-- --------------------------------------------------------

--
-- Table structure for table `Tips`
--

CREATE TABLE `Tips` (
  `id` int NOT NULL,
  `title` varchar(100) NOT NULL,
  `focus_area` varchar(100) DEFAULT NULL,
  `level` varchar(100) DEFAULT NULL,
  `content` text NOT NULL,
  `game_id` int NOT NULL,
  `user_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Tips`
--

INSERT INTO `Tips` (`id`, `title`, `focus_area`, `level`, `content`, `game_id`, `user_id`, `created_at`) VALUES
(1, 'Cooking Guide', 'Guide', 'For Begginers', 'Combine food ingredients to create dishes that restore health.', 1, 2, '2025-04-03 19:13:55'),
(2, 'Boss Strategy', 'Strategy', 'For Intermediate', 'For the Margit boss fight, use the Jellyfish Spirit summon.', 2, 3, '2025-04-03 19:13:55'),
(3, 'Pass Assist', 'Gameplay', 'For All levels', 'Turn on Assisted pass for higher accuracy as a beginner', 3, 2, '2025-04-03 19:13:55'),
(4, 'Weapon Loadout', 'Gameplay', 'For All levels', 'The M4 with a suppressor is great for stealth missions.', 4, 3, '2025-04-03 19:13:55'),
(5, 'Minecraft First Night Tips', 'Guide', 'For Beginners', 'When starting out in Minecraft, prioritize gathering basic resources like wood, stone, and food. Craft essential tools such as a pickaxe, axe, and sword to speed up resource collection and protect yourself from hostile mobs. Build a simple shelter before nightfall to avoid dangers like zombies and skeletons. Also, remember to craft torches early on—they will help you light up caves and prevent mob spawns.', 7, 14, '2025-04-05 17:38:04'),
(6, 'Fortnite Building Basics', 'Gameplay', 'For Intermediate', 'As an intermediate Fortnite player, focus on improving your building skills. Practice quickly building walls, ramps, and boxes during fights to gain the high ground. Also, learn to edit structures swiftly, allowing you to outmaneuver opponents. Pay attention to the storm circle and always rotate early to avoid getting caught off guard.', 13, 10, '2025-04-05 17:38:04'),
(7, 'Pro Valorant Tactics', 'Gameplay', 'For Pros', 'Professional Valorant players should focus on perfecting crosshair placement and minimizing unnecessary movements. Communicate precisely with your team and coordinate utility usage (smokes, flashes, etc.) to execute site takes or defenses efficiently. Regularly review your gameplay replays to identify mistakes and improve decision-making under pressure.', 8, 11, '2025-04-05 17:38:04'),
(8, 'Elixir Tips for Clash Royale', 'Strategy', 'All Levels', 'Whether you are new or experienced in Clash Royale, always pay attention to elixir management. Avoid overcommitting by deploying too many high-cost cards at once. Learn to counter popular decks and have a balance of offensive and defensive units. Don\'t forget to watch top players’ matches to understand advanced tactics.', 14, 13, '2025-04-05 17:38:04'),
(9, 'Explore Hyrule Smartly', 'Lore', 'For Beginners', 'The Legend of Zelda, exploration is key. Always keep an eye out for shrines, Korok seeds, and hidden chests. Cooking food with various ingredients not only restores health but grants powerful buffs. Spend time understanding the backstory by visiting various villages and speaking to NPCs to fully immerse yourself in Hyrule’s lore.', 1, 12, '2025-04-05 17:38:04');

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE `Users` (
  `id` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('guest','user','admin') DEFAULT 'user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `Users`
--

INSERT INTO `Users` (`id`, `username`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'admin', 'admin@gamegurus.com', 'password', 'admin', '2025-04-03 19:13:55'),
(2, 'gamer1', 'gamer1@example.com', 'password', 'user', '2025-04-03 19:13:55'),
(3, 'proGamer', 'pro@example.com', 'password', 'user', '2025-04-03 19:13:55'),
(6, 'ArtemShkurat', 'artem@example.com', 'admin_password3', 'admin', '2025-04-05 10:44:08'),
(7, 'Enea', 'enea@example.com', 'admin_password4', 'admin', '2025-04-05 10:44:08'),
(8, 'LuisGarcia', 'luis@example.com', 'admin_password2', 'admin', '2025-04-05 10:44:08'),
(9, 'Yulian', 'yulian@example.com', 'admin_password4', 'admin', '2025-04-05 10:44:08'),
(10, 'GamerKing', 'gamerking@example.com', 'hashed_password1', 'user', '2025-04-05 10:44:08'),
(11, 'ProPlayer99', 'proplayer99@example.com', 'hashed_password2', 'user', '2025-04-05 10:44:08'),
(12, 'CasualGamer', 'casualg@example.com', 'hashed_password3', 'user', '2025-04-05 10:44:08'),
(13, 'StrategyMaster', 'strategym@example.com', 'hashed_password4', 'user', '2025-04-05 10:44:08'),
(14, 'NoobSlayer', 'noobslayer@example.com', 'hashed_password5', 'user', '2025-04-05 10:44:08');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Account`
--
ALTER TABLE `Account`
  ADD KEY `tip_id` (`saved_tips`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `Comments`
--
ALTER TABLE `Comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tip_id` (`tip_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Games`
--
ALTER TABLE `Games`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Game_Category`
--
ALTER TABLE `Game_Category`
  ADD PRIMARY KEY (`game_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `Tips`
--
ALTER TABLE `Tips`
  ADD PRIMARY KEY (`id`),
  ADD KEY `game_id` (`game_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `Comments`
--
ALTER TABLE `Comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Games`
--
ALTER TABLE `Games`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `Tips`
--
ALTER TABLE `Tips`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Account`
--
ALTER TABLE `Account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`saved_tips`) REFERENCES `Tips` (`id`),
  ADD CONSTRAINT `account_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`);

--
-- Constraints for table `Comments`
--
ALTER TABLE `Comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`tip_id`) REFERENCES `Tips` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `Game_Category`
--
ALTER TABLE `Game_Category`
  ADD CONSTRAINT `game_category_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Games` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `game_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `Categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `Tips`
--
ALTER TABLE `Tips`
  ADD CONSTRAINT `tips_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Games` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `tips_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `Users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;