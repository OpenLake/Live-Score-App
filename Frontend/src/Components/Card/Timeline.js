import React, { useState, useEffect } from 'react';
import Card from '../Card/Card';
import { getUsers } from '../Service/api';
import { makeStyles } from '@material-ui/core';

const useStyles = makeStyles({
	timeline: {
		marginLeft: '23%',
	},
});

export default function ColorsTimeline(props) {
	const [users, setUsers] = useState([]);
	const classes = useStyles();

	useEffect(() => {
		getAllUsers();
	}, []);

	const getAllUsers = async () => {
		let response = await getUsers();
		setUsers(response.data);
	};

	function cardtime(val) {
		const show = val.gender === props.activeuser; //matching gender
		const sport = val.sports === props.sport; //matching sport
		const validData = show && sport; //both condition should satisfy.
		return (
			<>
				{validData && (
					<div className={classes.timeline}>
						<Card key={val._id} prop={val} />
					</div>
				)}
			</>
		);
	}
	return <>{users.map(cardtime)}</>;
}
