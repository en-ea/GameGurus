const db = require('../services/db');

class User {
   // User properties
   id;
   username;
   email;
   role;
   
   constructor(id = null) {
       this.id = id;
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
}

module.exports = User;
