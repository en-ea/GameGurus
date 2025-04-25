const { Post } = require("../models/post");

exports.createPost = async (req, res) => {
    // Ensure user is logged in
    if (!req.session || !req.session.loggedIn) {
        return res.redirect('/login?redirect=/create_post');
    }

    const data = req.body;
    console.log("Form submission received:", data);

    const post = new Post();
    post.setData({
        title: data.title,
        focus_area: data.aspects,
        level: data.level,
        content: data.description,
        game_id: parseInt(data.game_id),
        user_id: req.session.uid
    });

    try {
        const insertedId = await post.createTip();
        
        // Add wisdom points for creating a tip
        if (req.session.uid) {
            const user = new User(req.session.uid);
            await user.calculateWisdom();
        }
        
        console.log("Tip created successfully with ID:", insertedId);
        res.redirect('/tips');
    } catch (err) {
        console.error("Error creating tip:", err.message);
        res.status(500).send("Could not create tip");
    }
};