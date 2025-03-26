// Get the functions in the db.js file to use
const db = require('../services/db');
const bcrypt = require("bcryptjs");

class User {

    // Id of the user
    id;

    // Email of the user
    email;

    constructor(email) {
        this.email = email;
    }
    
    // Checks to see if the submitted email address exists in the Users table
    async getIdFromEmail() {
        var sql = "SELECT user_ID FROM Users WHERE Users.email = ?";
        const result = await db.query(sql, [this.email]);
        if (JSON.stringify(result) != '[]') {
            this.id = result[0].user_ID;
            return this.id;
        }
        else {
            return false;
        }
    }

    // Add a password to an existing user
    async setUserPassword(password) {
        const pw = await bcrypt.hash(password, 10);
        var sql = "UPDATE Users SET password = ? WHERE Users.user_ID = ?"
        const result = await db.query(sql, [pw, this.id]);
        return true;
    }
    
    // Add a new record to the users table    
    async addUser(password) {
        const pw = await bcrypt.hash(password, 10);
    
        // Get the highest existing user_ID
        var sqlGetMax = "SELECT user_ID FROM Users WHERE user_ID REGEXP '^U[0-9]+$' ORDER BY CAST(SUBSTRING(user_ID, 2) AS UNSIGNED) DESC LIMIT 1";
        const result = await db.query(sqlGetMax);
    
        let newId = "U1"; // Default for the first user
    
        if (result.length > 0) {
            const lastId = result[0].user_ID; // e.g., "U5"
            const lastNum = parseInt(lastId.substring(1)); // Extract number part
            newId = "U" + (lastNum + 1); // Increment number and format new ID
        }
    
        // Insert new user
        var sqlInsert = "INSERT INTO Users (user_ID, email, password) VALUES (?, ?, ?)";
        await db.query(sqlInsert, [newId, this.email, pw]);
    
        this.id = newId;
        return this.id;
    }
    
    // Test a submitted password against a stored password
    async authenticate(submitted) {
        var sql = "SELECT password FROM Users WHERE user_ID = ?";
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