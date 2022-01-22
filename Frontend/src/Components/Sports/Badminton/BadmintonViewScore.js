import React, {useContext} from 'react';
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
import { getUsers, editUser } from '../../Service/api';
import Readrow from './Readrow';
import { io } from 'socket.io-client';
import { FormGroup, FormControl, InputLabel, Input, Typography } from '@material-ui/core';
import { Button } from '@mui/material';
import { Link } from 'react-router-dom';
import { UserContext } from '../../../UserContext';

const PORT = process.env.PORT || 8080;
const socket = io("https://backendlivescore.herokuapp.com/");




const initialValue = {
	title: '',
	winner: '',
	date: '',
	set1: [0, 0],
	set2: [0, 0],
	set3: [0, 0],
	gender: '',
	sports: '',
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
	container: {
        width: '50%',
        margin: '5% 0 0 25%',
        '& > *': {
            marginTop: 20
        }
    }
});

function BadmintonViewScore(props) {
	const [user, setUser] = useState(initialValue);
	const [show, setShow] = useState(true);
	const {admin,setAdmin}=useContext(UserContext)
	var currentDate = new Date().toLocaleDateString('en-GB');
	var matchDate = new Date(user.date).toLocaleDateString('en-GB');
	const showedit = matchDate === currentDate;
	const classes = useStyles();
	const { id } = useParams();
	socket.on('updated_badmintonScore', user => {
		setUser(user);
	});
	useEffect(() => {
		loadUserDetails();
	}, []);

	const loadUserDetails = async () => {
		const response = await getUsers(id);
		setUser(response.data);
	};
	const onValueChange = e => {
		const newData = { ...user };
		newData['winner'] = (e.target.value);
		setUser(newData);
	};
	const editUserDetails = async () => {
		const response = await editUser(id, user);
		setShow(false);
		setTimeout(() => {
			setShow(true);
		}, 1000);
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



			{showedit && (
				<>
				<FormGroup style={{width:'30%'}}>
            <FormControl style={{marginLeft: '6%', marginTop: '3%'}}>
                <InputLabel  htmlFor="my-input">Winner</InputLabel>
                <Input  onChange={(e) => onValueChange(e)} name='winner' />
            </FormControl>
			</FormGroup>
				{show ? (
								<Button
									onClick={() => editUserDetails()}
									color="primary"
									variant="contained"
									style={{margin: '1% 2%'}}
								>
									Save
								</Button>
						) : (
						
								<Button
									style={{
										margin: '1% 2%',
										backgroundColor: '#0f766e',
										color: 'white',
									}}
								>
									Saved
								</Button>
							
					)}
					</>
					)
					}
		</>
	);
}
export default BadmintonViewScore;
