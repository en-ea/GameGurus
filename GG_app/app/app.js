// Import express.js
const express = require("express");
const path = require('path');
const { Game } = require('./models/game');
const { Tip } = require('./models/tip');
const { Category } = require('./models/category');
const { User } = require('./models/user');
const { Post } = require('./models/post');

// begin express app
const app = express();

// Configurez thr middleware
app.use(express.urlencoded({ extended: true }));
// app.use(express.static(path.join(__dirname, '../static')));

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
const create_post = require("./controllers/create-post");

// Set the sessions
var session = require('express-session');
app.use(session({
  secret: 'secretkeysdfjsflyoifasd',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }
}));

app.use((req, res, next) => {
  // Make session data available to all templates
  res.locals.session = req.session;
  next();
});

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

// Route for game search using search bar
app.get('/search', async (req, res) => {
  try {
      const searchQuery = req.query.q;
      
      // No game found
      if (!searchQuery) {
          return res.redirect('/games');
      }
      
      // Get game matching the search
      const games = await Game.searchGames(searchQuery);
      
      // Get all categories for navigation
      const categories = await Category.getAllCategories();
      
      res.render('games', {
          title: `Search Results for "${searchQuery}"`,
          games: games,
          categories: categories,
          searchQuery: searchQuery
      });
  } catch (error) {
      console.error('Error searching games:', error);
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
// route for tip detail with comments
app.get('/tips/:id', async (req, res) => {
  try {
    const tipId = req.params.id;
    const tip = new Tip(tipId);
    
    // Gets tip details
    await tip.getTipById();
    
    // Get comments for this tip
    const comments = await tip.getTipComments();
    
    res.render('tip-detail', {
      title: tip.title,
      tip: tip,
      comments: comments
    });
  } catch (error) {
    console.error('Error loading tip details:', error);
    res.status(500).send('Server error');
  }
});

// Add route to handle comment submission
app.post('/tips/:id/comment', async (req, res) => {
  // Check if user is logged in
  if (!req.session || !req.session.loggedIn) {
    return res.redirect(`/login?redirect=/tips/${req.params.id}`);
  }
  
  try {
    const tipId = req.params.id;
    const userId = req.session.uid;
    const content = req.body.content;
    
    // Create the comment
    await Tip.addComment(tipId, userId, content);
    // Add wisdom points for commenting
    const user = new User(userId);
    await user.calculateWisdom();
    // Redirect back to the tip page
    res.redirect(`/tips/${tipId}`);
  } catch (error) {
    console.error('Error adding comment:', error);
    res.status(500).send('Server error');
  }
});

// I added create post route
// Route to access the create post form - only for logged-in users
app.get('/create_post', async (req, res) => {
  // Check if user is logged in
  if (!req.session || !req.session.loggedIn) {
    return res.redirect('/login?redirect=/create_post');
  }
  
  try {
    const games = await db.query('SELECT id, title FROM Games');
    res.render('create_post', { games });
  } catch (error) {
    console.error('Error loading games for post creation:', error);
    res.status(500).send('Server error');
  }
});

// Process the form submission - also check authentication
app.post('/create_post', async (req, res) => {
  // Check if user is logged in
  if (!req.session || !req.session.loggedIn) {
    return res.redirect('/login?redirect=/create_post');
  }
  
  // Call the controller function
  return create_post.createPost(req, res);
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
    
    // Gets tips by this user
    const userTips = await user.getUserTips();
    
    // Gets comments by this user
    const userComments = await user.getUserComments();
    
    res.render('user-detail', {
      title: `${user.username}'s Profile`,
      user: user,
      tips: userTips,
      comments: userComments
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

// I added profile route (it doesn't have any buttons, so you have to add '/profile' to the link manually)
app.get('/profile', async (req, res) => {
  // Redirect if not logged in
  if (!req.session || !req.session.loggedIn) {
    return res.redirect('/login?redirect=/profile');
  }
  
  try {
    const userId = req.session.uid;
    const user = new User(userId);
    
    // Get user details
    await user.getUserById();
    
    // Calculate and update wisdom points
    await user.calculateWisdom();
    
    // Get user's tips
    const tips = await user.getUserTips();
    
    // Get user's comments
    const comments = await user.getUserComments();
    
    // Count tips and comments
    const tipCount = tips.length;
    const commentCount = comments.length;
    
    res.render('profile', {
      title: "My Profile",
      user: user,
      tips: tips,
      comments: comments,
      tipCount: tipCount,
      commentCount: commentCount
    });
  } catch (error) {
    console.error('Error loading profile:', error);
    res.status(500).send('Server error');
  }
});

// 404 - Not Found
// app.use((req, res) => {
//   res.status(404).render('404', { title: 'Page Not Found' });
// });

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