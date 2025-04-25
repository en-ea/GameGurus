const db = require('../services/db');

class Post {

    id;
    title;
    focus_area;
    level;
    content;
    game_id;
    user_id;
    
    constructor(id = null, title, focus_area, level, content, game_id, user_id) {
        this.id = id;
        this.title = title;
        this.focus_area = focus_area;
        this.level = level;
        this.content = content;
        this.game_id = game_id;
        this.user_id = user_id;
    }

    setData({ title, focus_area, level, content, game_id, user_id }) {
        this.title = title;
        this.focus_area = focus_area;
        this.level = level;
        this.content = content;
        this.game_id = game_id;
        this.user_id = user_id;
      }

    async createTip() {
        if (!this.title || !this.content || !this.game_id || !this.user_id) {
            throw new Error("Missing required fields");
        }

        const sql = `
          INSERT INTO Tips (title, focus_area, level, content, game_id, user_id)
          VALUES (?, ?, ?, ?, ?, ?)
        `;
        const result = await db.query(sql, [
          this.title,
          this.focus_area,
          this.level,
          this.content,
          this.game_id,
          this.user_id
        ]);
        this.id = result.insertId;
        return this.id;
      }
}

module.exports  = {
    Post
}