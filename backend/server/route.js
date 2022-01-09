const express = require('express');
const {
	getUsers,
	getUserById,
	editUser,
	addUser
} = require('../controller/user-controller.js');

const router = express.Router();

router.get('/', getUsers);
router.post('/add', addUser);
router.get('/:id', getUserById);
router.put('/:id', editUser);

module.exports = router;
