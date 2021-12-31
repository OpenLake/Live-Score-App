import User from '../model/user.js';

// Get all users
export const getUsers = async (request, response) => {
    // Step -1 // Test API
    // response.send('Code for Interview');
    try{
        // finding something inside a model is time taking, so we need to add await
        const users = await User.find();
        response.status(200).json(users);
    }catch( error ){
        response.status(404).json({ message: error.message })
    }
}


// Get a user by id
export const getUserById = async (request, response) => {
    try{
        const user = await User.findById(request.params.id);
        response.status(200).json(user);
    }catch( error ){
        response.status(404).json({ message: error.message })
    }
}