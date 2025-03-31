-- Drop tables if they exist to have clean start
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Tips;
DROP TABLE IF EXISTS Game_Category;
DROP TABLE IF EXISTS Categories;
DROP TABLE IF EXISTS Games;
DROP TABLE IF EXISTS Users;

-- Create Users table for user account information
CREATE TABLE Users (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(50) NOT NULL,           -- Username
  email VARCHAR(100) NOT NULL,             -- Email address
  password VARCHAR(255) NOT NULL,          -- Password
  role ENUM('guest', 'user', 'admin') DEFAULT 'user', -- permission level
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,      -- timestamp for account creation (set up to finish in sprint 4)
  PRIMARY KEY (id),                        -- primary key
  UNIQUE KEY (email),                      -- make sure emails are unique
  UNIQUE KEY (username)                    -- makes sure usernames are unique
);

-- Create Games table for game info
CREATE TABLE Games (
  id INT NOT NULL AUTO_INCREMENT,          -- Unique ID for every game
  title VARCHAR(100) NOT NULL,             -- title
  description TEXT,                        -- Game description
  platform VARCHAR(100),                   -- Platform/platforms of the game
  release_date DATE,                       -- game release date
  image_url VARCHAR(255),                  -- URL to game cover image (to finish in sprint 4)
  PRIMARY KEY (id)                         -- Primary key
);

-- Create Categories table that stores game categories
CREATE TABLE Categories (
  id INT NOT NULL AUTO_INCREMENT,          -- ID for each categorry
  name VARCHAR(50) NOT NULL,               -- Name of category
  PRIMARY KEY (id),                        -- Primary key
  UNIQUE KEY (name)                        -- have names be unique
);

-- Create the Game_Category junction table for many-to-many relationship
CREATE TABLE Game_Category (
  game_id INT NOT NULL,                    -- Reference to Games table
  category_id INT NOT NULL,                -- Reference to Categories table
  PRIMARY KEY (game_id, category_id),      -- Composite primary key
  FOREIGN KEY (game_id) REFERENCES Games(id) ON DELETE CASCADE,
  FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE
);

-- Create Tips table to store gaming tips
CREATE TABLE Tips (
  id INT NOT NULL AUTO_INCREMENT,          -- Unique ID of reach tip
  title VARCHAR(100) NOT NULL,             -- Tip title
  content TEXT NOT NULL,                   -- Tip content
  game_id INT NOT NULL,                    -- Game this tip is for
  user_id INT NOT NULL,                    -- Creator of tip
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Tip creation date (will finish in sprint 4)
  PRIMARY KEY (id),                        -- Primary key
  FOREIGN KEY (game_id) REFERENCES Games(id) ON DELETE CASCADE, -- Deletes tip if game is deleted
  FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE  -- Delete tip if user is deleted
);

-- Create Comments table to store comments for tips (not yet implemented but setup for sprint 4)
CREATE TABLE Comments (
  id INT NOT NULL AUTO_INCREMENT,          -- ID for each comment
  content TEXT NOT NULL,                   -- Comment content
  tip_id INT NOT NULL,                     -- Which tip this comment is for
  user_id INT NOT NULL,                    -- User that made the comment
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Creation time for comment (for future in sprint 4)
  PRIMARY KEY (id),                        -- Primary key
  FOREIGN KEY (tip_id) REFERENCES Tips(id) ON DELETE CASCADE, -- Delete comment if tip is deleted
  FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE -- Delete comment if user is deleted
);

-- Insert example Users (just as example in order to show functionality)
INSERT INTO Users (username, email, password, role) VALUES
('admin', 'admin@gamegurus.com', 'password', 'admin'),  -- Admin user for system management
('gamer1', 'gamer1@example.com', 'password', 'user'),   -- Regular user account
('proGamer', 'pro@example.com', 'password', 'user');    -- Another regular user account

-- Insert categories for games
INSERT INTO Categories (name) VALUES
('Action'),
('Adventure'),
('RPG'),
('Strategy'),
('Sports'),
('Shooter');

-- Insert sample game info
INSERT INTO Games (title, description, platform, release_date) VALUES
('The Legend of Zelda', 'An open-world action-adventure game', 'Nintendo Switch', '2017-03-03'),
('Elden Ring', 'An action RPG by FromSoftware', 'PlayStation, Xbox, PC', '2022-02-25'),
('FIFA 25', 'A football simulation game', 'PlayStation, Xbox, PC', '2024-09-07'),
('Call of Duty', 'A first-person shooter game', 'PlayStation, Xbox, PC', '2022-10-28');

-- Link games to categories (create many-to-many relationships)
INSERT INTO Game_Category (game_id, category_id) VALUES
(1, 1), -- Zelda: Action
(1, 2), -- Zelda: Adventure
(2, 1), -- Elden Ring: Action
(2, 3), -- Elden Ring: RPG
(3, 5), -- FIFA 23: Sports
(4, 6); -- CoD: Shooter

-- Insert example tips
INSERT INTO Tips (title, content, game_id, user_id) VALUES
('Cooking Guide', 'Combine food ingredients to create dishes that restore health.', 1, 2),
('Boss Strategy', 'For the Margit boss fight, use the Jellyfish Spirit summon.', 2, 3),
('Pass Assist', 'Turn on Assisted pass for higher accuracy as a beginner', 3, 2),
('Weapon Loadout', 'The M4 with a suppressor is great for stealth missions.', 4, 3);

-- Insert sample comments (to be implemented in our sprint 4)
INSERT INTO Comments (content, tip_id, user_id) VALUES
('This really helped me defeat the boss!', 2, 2),
('The ball roll is essential for higher difficulty.', 3, 3);
