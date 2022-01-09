import axios from 'axios';

const PORT = process.env.PORT || 8080;
const usersUrl = `http://localhost:${PORT}/users`;

export const getUsers = async id => {
	id = id || '';
	return await axios.get(`${usersUrl}/${id}`);
};
export const addUser = async (user) => {
    return await axios.post(`${usersUrl}/add`, user);
}
export const editUser = async (id, user) => {
	return await axios.put(`${usersUrl}/${id}`, user);
};
