const db = require('../services/db');

class Tip {

    // Tip properties
    id;
    title;
    focus_area; // Added focus area attribute
    level;      // Added level attribute
    content;
    game_id;
    user_id;
    
    constructor(id = null) {
        this.id = id;
    }
    
    // Get tip by ID
    async getTipById() {
        if (!this.id) return false;
        
        const sql = `
            SELECT t.*, g.title as game_title, u.username 
            FROM Tips t
            JOIN Games g ON t.game_id = g.id
            JOIN Users u ON t.user_id = u.id
            WHERE t.id = ?
        `;
        const result = await db.query(sql, [this.id]);
        
        if (result.length) {
            this.title = result[0].title;
            this.content = result[0].content;
            this.game_id = result[0].game_id;
            this.user_id = result[0].user_id;
            this.game_title = result[0].game_title;
            this.username = result[0].username;
            return true;
        }
        return false;
    }
    
    // Get all tips
    static async getAllTips() {
        const sql = `
            SELECT t.*, g.title as game_title, u.username 
            FROM Tips t
            JOIN Games g ON t.game_id = g.id
            JOIN Users u ON t.user_id = u.id
            ORDER BY t.created_at DESC
        `;
        return await db.query(sql);
    }
    
    // Get comments for a tip
    async getTipComments() {
        if (!this.id) return [];
        
        const sql = `
            SELECT c.*, u.username 
            FROM Comments c
            JOIN Users u ON c.user_id = u.id
            WHERE c.tip_id = ?
            ORDER BY c.created_at DESC
        `;
        return await db.query(sql, [this.id]);
    }

    // Static method to add a comment
    static async addComment(tipId, userId, content) {
        const sql = `
            INSERT INTO Comments (content, tip_id, user_id)
            VALUES (?, ?, ?)
        `;
        return await db.query(sql, [content, tipId, userId]);
    }
}

module.exports = {
    Tip
}