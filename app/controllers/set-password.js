const { User } = require("../models/user");

exports.setPassword = async (req, res) => {
    const { email, password, username } = req.body;

    const user = new User(null, email, username);

    try {
        const uId = await user.getIdFromEmailOrUsername(email);
        if (uId) {
            await user.setUserPassword(password);
            res.send('Password updated successfully');
        } else {
            await user.addUser(password);
            res.send('New user registered successfully');
        }
    } catch (err) {
        console.error("Error while adding password:", err.message);
        res.status(500).send("Internal server error");
    }
};