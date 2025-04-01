const express = require('express');
const path = require('path');
const Game = require('./models/game');
const Tip = require('./models/tip');
const Category = require('./models/category');
const User = require('./models/user');

// begin express app
const app = express();

// Configurez thr middleware
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, '../static')));

// Set up engine for pug templating
app.set('view engine', 'pug');
app.set('views', '/usr/src/app/app/views');

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
-----------


// Get the functions in the db.js file to use
const db = require('./services/db');
app.use(express.urlencoded({ extended: true }));

// Get the classes and controllers
const set_password = require("./controllers/set-password");
const authenticate = require("./controllers/authenticate");

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

// Wellcome page
app.get("/welcome", function (req, res) {
  res.render("welcome");
});

// Main page
app.get("/main_p", function (req, res) {
  res.render("main_p");
});

// Start server on port 3000
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});
