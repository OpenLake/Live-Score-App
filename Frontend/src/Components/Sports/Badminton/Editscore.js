import React, {useContext} from 'react';
import { useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { FormGroup,Typography } from '@material-ui/core';
import {
	FormControl,
	Input,
	Table,
	TableHead,
	TableCell,
	TableRow,
	TableBody,
	makeStyles,
} from '@material-ui/core';
import { getUsers, editUser } from '../../Service/api';
import { Button } from '@mui/material';
import { io } from 'socket.io-client';
import { UserContext } from '../../../UserContext';
import { Link } from 'react-router-dom';

const PORT = process.env.PORT || 8080;
const socket = io(`http://localhost:${PORT}8080`);

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

function Editscore(props) {
	const [user, setUser] = useState(initialValue);
	const [show, setShow] = useState(true);
	const {admin,setAdmin}=useContext(UserContext)
	const classes = useStyles();
	const { id, set } = useParams();
	useEffect(() => {
		loadUserDetails();
	}, []);

	const loadUserDetails = async () => {
		const response = await getUsers(id);
		setUser(response.data);
	};
	socket.on('updated_badmintonScore', user => {
		setUser(user);
	});

	const editUserDetails = async () => {
		const response = await editUser(id, user);
		setShow(false);
		setTimeout(() => {
			setShow(true);
		}, 1000);
	};

	const onValueChange = e => {
		const newData = { ...user };
		if (e.target.name === 'one') newData[set][0] = Number(e.target.value);
		else newData[set][1] = Number(e.target.value);
		setUser(newData);
	};
	const title_array = user.title.split(' ');
	return (
		<>
		{admin ?
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
					<TableRow className={classes.row}>
						<TableCell>{set}</TableCell>
						<TableCell>
							<FormControl>
								<Input
									onChange={e => onValueChange(e)}
									name="one"
									value={user[set][0]}
									autoComplete="off"
								/>
							</FormControl>
						</TableCell>
						<TableCell>
							<FormControl>
								<Input
									onChange={e => onValueChange(e)}
									name="two"
									value={user[set][1]}
									autoComplete="off"
								/>
							</FormControl>
						</TableCell>
						{show ? (
							<TableCell>
								<Button
									onClick={() => editUserDetails()}
									color="primary"
									variant="contained"
									style={{ marginRight: 10 }}
								>
									Save
								</Button>
							</TableCell>
						) : (
							<TableCell>
								<Button
									style={{
										marginRight: 10,
										backgroundColor: '#0f766e',
										color: 'white',
									}}
								>
									Saved
								</Button>
							</TableCell>
						)}
					</TableRow>
				</TableBody>
			</Table>:
			<div>
        <FormGroup className={classes.container}>
        <Typography variant="h4">Please Login to continue.</Typography>
        <Link to="/login" style={{ textDecoration: 'none' }}>
                <Button  variant="contained" color="primary">Go to Login Page</Button>
        </Link>
        </FormGroup>
        </div>
        }
		</>
	);
}
export default Editscore;
