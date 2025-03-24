// Import express.js
const express = require("express");

// Create express app
var app = express();

// Add static files location
app.use(express.static("static"));

// Use the Pug templating engine
app.set('view engine', 'pug');
app.set('views', './app/views');

// Get the functions in the db.js file to use
const db = require('./services/db');
app.use(express.urlencoded({ extended: true }));

// Get the models
const { User } = require("./classes/user");

// Set the sessions
var session = require('express-session');
app.use(session({
  secret: 'secretkeysdfjsflyoifasd',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: false }
}));

// Create a route for root - /
app.get("/", function(req, res) {
    console.log(req.session);
    if (req.session.uid) {
		res.send('Welcome back, ' + req.session.uid + '!');
	} else {
		res.send('Please login to view this page!');
	}
	res.end();
});

// Register
app.get('/register', function (req, res) {
    res.render('register');
});

// Login
app.get('/login', function (req, res) {
    res.render('login');
});

// Logout
app.get('/logout', function (req, res) {
    req.session.destroy();
    res.redirect('/login');
  });

// Start server on port 3000
app.listen(3000,function(){
    console.log(`Server running at http://127.0.0.1:3000/`);
});