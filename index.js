// index.js - Entry point for the application
const app = require('./app/app');

// Set port from environment or default to 3000
const PORT = process.env.PORT || 3000;

// Start server
app.listen(PORT, () => {
    console.log(`Server running on port ${PORT}`);
});
