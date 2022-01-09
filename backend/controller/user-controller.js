const User = require('../model/user.js');

// Get all users
const getUsers = async (request, response) => {
	try {
		const users = await User.find().sort({ date: 1 }); // for giving data in sorted order.
		response.status(200).json(users);
	} catch (error) {
		response.status(404).json({ message: error.message });
	}
};

// Get a user by id
const getUserById = async (request, response) => {
	try {
		const user = await User.findById(request.params.id);
		response.status(200).json(user);
	} catch (error) {
		response.status(404).json({ message: error.message });
	}
};

//add data
const addUser = async (request, response) => {
    const user = request.body;
    console.log("inside")

    const newUser = new User(user);
    try{
        await newUser.save();
        response.status(201).json(newUser);
    } catch (error){
        response.status(409).json({ message: error.message});     
    }
}

// Save data of edited user in the database
const editUser = async (request, response) => {
	try {
		const newUser = await User.findByIdAndUpdate(
			{ _id: request.params.id },
			{ $set: request.body },
			{ new: true },
		);
		console.log(newUser);
		request.app.io.emit('updated_badmintonScore', newUser);
		response.status(201).json(newUser);
		console.log('done');
	} catch (error) {
		response.status(409).json({ message: error.message });
	}
};

module.exports = { getUsers, getUserById, editUser,addUser };
