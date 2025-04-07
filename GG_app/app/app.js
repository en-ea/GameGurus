// Import express.js
const express = require("express");
const path = require('path');
const { Game } = require('./models/game');
const { Tip } = require('./models/tip');
const { Category } = require('./models/category');
const { User } = require('./models/user');

// begin express app
const app = express();

// Configurez thr middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '../static')));

// Set up engine for pug templating
app.set('view engine', 'pug');
app.set('views', './app/views');

// Get the functions in the db.js file to use
const db = require('./services/db');
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '../static')));

// Get the classes and controllers
const set_password = require("./controllers/set-password");
const authenticate = require("./controllers/authenticate");

// Set the sessions
var session = require('express-session');
app.use(session({
  secret: 'secretkeysdfjsflyoifasd',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }
}));

// route to the home page
app.get('/', async (req, res) => {
  try {
      // Get recent tips/games for the home page
      const tips = await Tip.getAllTips();
      const games = await Game.getAllGames();
      const categories = await Category.getAllCategories();
      
      res.render('home', {
          title: 'Game Gurus - Gaming Tips & Tricks',
          tips: tips.slice(0, 3), 
          games: games,
          categories: categories
      });
  } catch (error) {
      console.error('Error loading home page:', error);
      res.status(500).send('Server error');
  }
});

// route for gameslist
app.get('/games', async (req, res) => {
  try {
      const games = await Game.getAllGames();
      const categories = await Category.getAllCategories();
      
      res.render('games', {
          title: 'All Games',
          games: games,
          categories: categories
      });
  } catch (error) {
      console.error('Error loading games:', error);
      res.status(500).send('Server error');
  }
});

// route to game detail
app.get('/games/:id', async (req, res) => {
  try {
      const gameId = req.params.id;
      const game = new Game(gameId);
      
      // Get game details
      await game.getGameById();
      
      // Get game categories
      const categories = await game.getGameCategories();
      
      // Get tips for this game
      const tips = await game.getGameTips();
      
      res.render('game-detail', {
          title: game.title,
          game: game,
          categories: categories,
          tips: tips
      });
  } catch (error) {
      console.error('Error loading game details:', error);
      res.status(500).send('Server error');
  }
});

// filter games by category
app.get('/category/:id', async (req, res) => {
  try {
      const categoryId = req.params.id;
      const category = new Category(categoryId);
      
      // Get category details
      await category.getCategoryById();
      
      // Get the games in this category
      const games = await Game.getGamesByCategory(categoryId);
      
      // get all categories for navigation
      const categories = await Category.getAllCategories();
      
      res.render('games', {
          title: `${category.name} Games`,
          games: games,
          categories: categories,
          currentCategory: categoryId
      });
  } catch (error) {
      console.error('Error loading category games:', error);
      res.status(500).send('Server error');
  }
});

// route to tips list
app.get('/tips', async (req, res) => {
  try {
      const tips = await Tip.getAllTips();
      
      res.render('tips', {
          title: 'All Tips & Tricks',
          tips: tips
      });
  } catch (error) {
      console.error('Error loading tips:', error);
      res.status(500).send('Server error');
  }
});

// route for tip detail
app.get('/tips/:id', async (req, res) => {
  try {
      const tipId = req.params.id;
      const tip = new Tip(tipId);
      
      // Gets tip details
      await tip.getTipById();
      
      res.render('tip-detail', {
          title: tip.title,
          tip: tip
      });
  } catch (error) {
      console.error('Error loading tip details:', error);
      res.status(500).send('Server error');
  }
});

// users list route
app.get('/users', async (req, res) => {
  try {
      const users = await User.getAllUsers();
      
      res.render('users', {
          title: 'Community Members',
          users: users
      });
  } catch (error) {
      console.error('Error loading users:', error);
      res.status(500).send('Server error');
  }
});

// user profile route
app.get('/users/:id', async (req, res) => {
  try {
      const userId = req.params.id;
      const user = new User(userId);
      
      // Gets user details
      await user.getUserById();
      
      // gets tips by this user
      const userTips = await user.getUserTips();
      
      res.render('user-detail', {
          title: `${user.username}'s Profile`,
          user: user,
          tips: userTips
      });
  } catch (error) {
      console.error('Error loading user profile:', error);
      res.status(500).send('Server error');
  }
});

// Register
app.get("/register", async function (req, res) {
  res.render("register");
});
app.post("/setPassword", set_password.setPassword);

// Login
app.get("/login", async function (req, res) {
  res.render("login");
});
app.post("/authenticate", authenticate.authenticate);

// Logout
app.get("/logout", function (req, res) {
  req.session.destroy();
  res.redirect("/login");
});

// About page
app.get('/about', (req, res) => {
  res.render('about', { 
      title: 'About Game Gurus'
  });
});

// 404 - Not Found
app.use((req, res) => {
  res.status(404).render('404', { title: 'Page Not Found' });
});

// About page
app.get('/about', (req, res) => {
    res.render('about', { 
        title: 'About Game Gurus'
    });
});

module.exports = app;

// Start server on port 3000
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});
