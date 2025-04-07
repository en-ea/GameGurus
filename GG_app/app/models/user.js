// Get the functions in the db.js file to use
const db = require('../services/db');
const bcrypt = require("bcryptjs");

class User {

    // User properties
    id;
    username;
    email;
    role;

    constructor(id = null, email, username = null) {
        this.id = id;
        this.email = email;
        this.username = username;
    }    
    
    // Get user by ID
   async getUserById() {
    if (!this.id) return false;
    
    const sql = "SELECT id, username, email, role FROM Users WHERE id = ?";
    const result = await db.query(sql, [this.id]);
    
    if (result.length) {
        this.username = result[0].username;
        this.email = result[0].email;
        this.role = result[0].role;
        return true;
    }
    return false;
    }

    // Get all users
    static async getAllUsers() {
        const sql = "SELECT id, username, email, role FROM Users";
        return await db.query(sql);
    }

    // Get tips by a specific user
    async getUserTips() {
        if (!this.id) return [];
        
        const sql = `
            SELECT t.*, g.title as game_title 
            FROM Tips t 
            JOIN Games g ON t.game_id = g.id 
            WHERE t.user_id = ?
        `;
        return await db.query(sql, [this.id]);
    }
    
    // Checks to see if the submitted email address exists in the Users table
    async getIdFromEmailOrUsername(identifier) {
        const sql = "SELECT id, email, username FROM Users WHERE email = ? OR username = ?";
        const result = await db.query(sql, [identifier, identifier]);
    
        if (result.length > 0) {
            this.id = result[0].id;
            this.email = result[0].email;
            this.username = result[0].username;
            return this.id;
        } else {
            return false;
        }
    }

    // Add a password to an existing user
    async setUserPassword(password) {
        const pw = await bcrypt.hash(password, 10);
        var sql = "UPDATE Users SET password = ? WHERE Users.id = ?"
        const result = await db.query(sql, [pw, this.id]);
        return true;
    }
    
    // Add a new record to the users table    
    async addUser(password) {
        const pw = await bcrypt.hash(password, 10);
        const sql = "INSERT INTO Users (username, email, password) VALUES (?, ?, ?)";
        const result = await db.query(sql, [this.username, this.email, pw]);
        this.id = result.insertId;
        return this.id;
    }
    
    
    // Test a submitted password against a stored password
    async authenticate(submitted) {
        var sql = "SELECT password FROM Users WHERE id = ?";
        const result = await db.query(sql, [this.id]);

        if (result.length === 0) {
            return false; // No user found
        }

        const storedPassword = result[0].password;

        // Check if the stored password is hashed (Bcrypt hashes start with "$2")
        if (storedPassword.startsWith("$2")) {
            return await bcrypt.compare(submitted, storedPassword);
        } else {
            // Compare plaintext passwords
            return submitted === storedPassword;
        }
    }
}

module.exports  = {
    User
}