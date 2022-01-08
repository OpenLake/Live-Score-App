import React from 'react';
import { useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import {
	Table,
	TableHead,
	TableCell,
	TableRow,
	TableBody,
	makeStyles,
} from '@material-ui/core';
import { getUsers } from '../../Service/api';
import Readrow from './Readrow';
import { io } from 'socket.io-client';
const socket = io('http://localhost:8080');



const initialValue = {
	title: '',
	winner: '',
	date: '',
	set1: [0, 0],
	set2: [0, 0],
	set3: [0, 0],
	gender: '',
	sport: '',
};
const useStyles = makeStyles({
	table: {
		width: '100%',
	},
	thead: {
		'& > *': {
			fontSize: 20,
			background: '#164e63',
			color: '#FFFFFF',
		},
	},
	row: {
		'& > *': {
			fontSize: 18,
		},
	},
});

function BadmintonViewScore(props) {
	const [user, setUser] = useState(initialValue);
	const classes = useStyles();
	const { id } = useParams();
	socket.on('updated_badmintonScore', user => {
		console.log('got the data', user);
		setUser(user);
	});
	useEffect(() => {
		loadUserDetails();
	}, []);

	const loadUserDetails = async () => {
		const response = await getUsers(id);
		setUser(response.data);
	};

	const title_array = user.title.split(' ');
	return (
		<>
			<Table className={classes.table}>
				<TableHead>
					<TableRow className={classes.thead}>
						<TableCell></TableCell>
						<TableCell>{title_array[0]}</TableCell>
						<TableCell>{title_array[2]}</TableCell>
						<TableCell></TableCell>
					</TableRow>
				</TableHead>
				<TableBody>
					<Readrow user={user} />
				</TableBody>
			</Table>
		</>
	);
}
export default BadmintonViewScore;
