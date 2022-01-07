const express=require('express');
const { getUsers, getUserById, editUser } =require('../controller/user-controller.js');

const router = express.Router();

router.get('/', getUsers);
router.get('/:id', getUserById);
router.put('/:id', editUser);


module.exports= router;