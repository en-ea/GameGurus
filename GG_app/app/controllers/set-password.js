const { User } = require("../classes/user");

exports.setPassword = async (req, res) => {
    const params = req.body;
    const user = new User(params.email);
    try {
        const uId = await user.getIdFromEmail();
        if (uId) {
            // Existing user: set password
            await user.setUserPassword(params.password);
            res.send('Password set successfully');
        } else {
            // New user: add user
            const newId = await user.addUser(params.password);
            res.send('New user registered successfully');
        }
    } catch (err) {
        console.error(`Error while adding password: `, err.message);
        res.status(500).send("Internal server error");
    }
};