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