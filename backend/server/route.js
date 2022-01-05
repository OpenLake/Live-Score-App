import express from 'express';
import { getUsers, getUserById, editUser } from '../controller/user-controller.js';

const router = express.Router();

router.get('/', getUsers);
router.get('/:id', getUserById);
router.put('/:id', editUser);


export default router;