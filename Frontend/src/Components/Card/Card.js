import * as React from 'react';
import Card from '@mui/material/Card';
import CardContent from '@mui/material/CardContent';

import Typography from '@mui/material/Typography';
import { Button, CardActionArea, CardActions } from '@mui/material';
import { Link } from 'react-router-dom';

export default function MultiActionAreaCard({ prop }) {
	var currentDate = new Date().toISOString();
	let toshow = currentDate < prop.date;
	var newDate = new Date(prop.date).toLocaleDateString('en-GB');

	var current = new Date().toLocaleDateString('en-GB');
	const showmatch = newDate === current;

	return (
		<Card
			style={{
				boxShadow: showmatch
					? '0px 1px 10px 1px #0891b2'
					: '0px 1px 10px 1px black',
				marginBottom: '20px',
			}}
			sx={{ maxWidth: 700 }}
		>
			<CardActionArea>
				<div
					style={{
						height: '50px',
						background: 'linear-gradient(to left,#a5f3fc,#06b6d4)',
					}}
				>
					<Typography
						variant="h5"
						style={{ textAlign: 'center', paddingTop: '5px' }}
					>
						{newDate}
					</Typography>
				</div>

				<CardContent>
					<Typography gutterBottom variant="h6" component="div">
						{prop.title}
					</Typography>
					<Typography variant="body2" color="text.secondary">
						<span>Winner:</span> {prop.winner}
					</Typography>
				</CardContent>
			</CardActionArea>
			<CardActions>
			<Link to={`/badmintonscore/${prop._id}`} style={{ textDecoration: 'none' }}>
				<Button
					size="small"
					color="primary"
					disabled={toshow}
				>
					View Score
				</Button>
			</Link>
			</CardActions>
		</Card>
	);
}
