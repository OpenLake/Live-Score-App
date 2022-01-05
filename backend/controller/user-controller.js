import User from '../model/user.js';

// Get all users
export const getUsers = async (request, response) => {
    try{
        const users = await User.find().sort( { date: 1 } ); // for giving data in sorted order.
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

// Save data of edited user in the database
export const editUser = async (request, response) => {
    // let user = await User.findById(request.params.id);
    // user = request.body;

    // const editUser = new User(user);
    // try{
    //     await User.updateOne({_id: request.params.id}, editUser);
    //     response.status(201).json(editUser);
    // } catch (error){
    //     response.status(409).json({ message: error.message});     
    // }
    try{
        const newUser=await User.findByIdAndUpdate({_id:request.params.id},{$set:request.body},{new:true})
        console.log(newUser)
        response.status(201).json(newUser);
        console.log("done")
    }
    catch(error){
        response.status(409).json({ message: error.message}); 
    }
}