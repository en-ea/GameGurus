const db = require('../services/db');

//Game class, provides methods to retriev game data and related info
class Game {
    // Game properties
    id;               // Unique id for the game
    title;            // title/name
    description;      // description
    platform;         // Platform the game is available on
    release_date;     // Release date
    
// Creates a new Game instance
    constructor(id = null) {
        this.id = id;
    }
    
    /* Get and populate game details from database
       returns {Promise<boolean>} True if game is found, else its false */
    async getGameById() {
        if (!this.id) return false;
        
        // Query to get game details by ID
        const sql = "SELECT * FROM Games WHERE id = ?";
        const result = await db.query(sql, [this.id]);
        
        // If game was found, populate instance properties
        if (result.length) {
            this.title = result[0].title;
            this.description = result[0].description;
            this.platform = result[0].platform;
            this.release_date = result[0].release_date;
            return true;
        }
        return false;
    }
    
//Get all games from the database, sorted by title
    static async getAllGames() {
        const sql = "SELECT * FROM Games ORDER BY title";
        return await db.query(sql);
    }
    
    // Get all games from a specific category
    static async getGamesByCategory(categoryId) {
        const sql = `
            SELECT g.* 
            FROM Games g 
            JOIN Game_Category gc ON g.id = gc.game_id 
            WHERE gc.category_id = ?
        `;
        return await db.query(sql, [categoryId]);
    }
    

    //Get all categories that this game belongs to
    async getGameCategories() {
        if (!this.id) return [];
        
        // Query to get categories for this game using junction table
        const sql = `
            SELECT c.* 
            FROM Categories c 
            JOIN Game_Category gc ON c.id = gc.category_id 
            WHERE gc.game_id = ?
        `;
        return await db.query(sql, [this.id]);
    }
    
    
    //Get every tip for this game

    async getGameTips() {
        if (!this.id) return [];
        
        // Query to get tips for this game with username of the author
        const sql = `
            SELECT t.*, u.username 
            FROM Tips t 
            JOIN Users u ON t.user_id = u.id 
            WHERE t.game_id = ?
        `;
        return await db.query(sql, [this.id]);
    }
}

<<<<<<< HEAD
module.exports  = {
    Game
}
=======
module.exports = Game;
>>>>>>> baaee21f0a46c6caae60e3a757d6bf2ff5764f95
