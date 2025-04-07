const db = require('../services/db');

//Provides methods for retrieving category data from the database
class Category {
    // properties for Category
    id;         // Unique ID for the category
    name;       // Name of the category (like Action, RPG)

    //create instance for category
    constructor(id = null) {
        this.id = id;
    }
    
/*gets and populates category details from database
returns {Promise<boolean>} True if category was found, false otherwise */
    async getCategoryById() {
        if (!this.id) return false;
        
        // Query for getting category details by ID
        const sql = "SELECT * FROM Categories WHERE id = ?";
        const result = await db.query(sql, [this.id]);
        
        // If category was found, populate instance properties
        if (result.length) {
            this.name = result[0].name;
            return true;
        }
        return false;
    }
    
//Gets all categories from the db, sorted by name
    static async getAllCategories() {
        const sql = "SELECT * FROM Categories ORDER BY name";
        return await db.query(sql);
    }
}

module.exports  = {
    Category
}