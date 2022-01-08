import axios from 'axios';

const usersUrl = 'http://localhost:8080/users';

export const getUsers = async id => {
	id = id || '';
	return await axios.get(`${usersUrl}/${id}`);
};

export const editUser = async (id, user) => {
	return await axios.put(`${usersUrl}/${id}`, user);
};
