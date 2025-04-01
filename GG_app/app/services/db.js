// services/db.js - Database connection service
require('dotenv').config();
const mysql = require('mysql2/promise');

// Create a connection pool
const pool = mysql.createPool({
    host: process.env.DB_HOST || 'localhost',
    user: process.env.DB_USER || 'root',
    password: process.env.DB_PASSWORD || 'password',
    database: process.env.DB_NAME || 'game_gurus',
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Helper function to execute queries
async function query(sql, params) {
    const [rows] = await pool.execute(sql, params);
    return rows;
}

module.exports = {
    query
};
