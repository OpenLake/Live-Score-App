import React, { useState, useEffect } from 'react';
import { TableCell, TableRow, makeStyles } from '@material-ui/core';
import { Button } from '@mui/material';

const useStyles = makeStyles({
	row: {
		'& > *': {
			fontSize: 18,
		},
	},
});

function Readrow({ user }) {
	const a = ['set1', 'set2', 'set3'];
	var currentDate = new Date().toLocaleDateString('en-GB');
	var matchDate = new Date(user.date).toLocaleDateString('en-GB');
	const showedit = matchDate === currentDate;
	const classes = useStyles();
	function showrow(val) {
		return (
			<>
				<TableRow key={val} className={classes.row}>
					<TableCell>{val}</TableCell>
					<TableCell>{user[val][0]}</TableCell>
					<TableCell>{user[val][1]}</TableCell>
					{showedit && (
						<TableCell>
							<Button
								href={`/editscore/${user._id}/${val}`}
								color="primary"
								variant="contained"
								style={{ marginRight: 10 }}
							>
								Edit
							</Button>
						</TableCell>
					)}
				</TableRow>
			</>
		);
	}
	return (
		<>
			{a.map(i => showrow(i))}
		</>
	);
}

export default Readrow;
