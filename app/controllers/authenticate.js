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
                req.session.uid = uId;
                req.session.loggedIn = true;
                console.log("Logged in:", req.session.uid);
                res.redirect("/");
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