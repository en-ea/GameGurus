const { User } = require("../models/user");

// Check submitted email/username and password pair
exports.authenticate = async (req, res) => {
    const { email: identifier, password } = req.body;
    const user = new User(null, identifier);

    try {
        const uId = await user.getIdFromEmailOrUsername(identifier);
        if (uId) {
            const match = await user.authenticate(password);
            if (match) {
                // Store user details in session
                req.session.uid = uId;
                req.session.username = user.username;
                req.session.loggedIn = true;
                
                console.log("Logged in:", req.session);
                
                // Check if there's a redirect parameter
                const redirectUrl = req.query.redirect || '/';
                res.redirect(redirectUrl);
            } else {
                res.send("Invalid password");
            }
        } else {
            res.send("Invalid email or username");
        }
    } catch (err) {
        console.error("Error during login:", err.message);
        res.status(500).send("Internal server error");
    }
};