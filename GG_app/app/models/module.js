// Get the functions in the db.js file to use
const db = require('../services/db');

class Module {
    //Module ID
    code;
    // Module name
    mName;

    constructor(code, name) {
        this.code = code;
        this.mName = name;
    }

    async getModuleName() {
        if (typeof this.mName !== 'string') {
            var sql = "SELECT * from Modules where code = ?"
            const results = await db.query(sql, [this.id]);
            this.mName = results[0].name;
            this.code = results[0].code;
        }
    }
}

module.exports = {
    Module
}