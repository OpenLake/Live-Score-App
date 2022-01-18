import React, { useState } from 'react';
import Timeline from '../../Card/Timeline';
import Button from '@mui/material/Button';
import '../../component.css';

export default function TableTennis() {
	const [active, setActive] = useState('female');
	return (
		<div>
		    <Button href="/addmatch/tennis" style={{ margin: '3px 3px' }}
					variant="contained">
					Add match
			</Button>
			{active === 'male' && (
				<Button
					onClick={() => setActive('female')}
					style={{ margin: '3px 3px' }}
					variant="contained"
				>
					GIRLS
				</Button>
			)}
			{active === 'female' && (
				<Button
					onClick={() => setActive('male')}
					style={{ margin: '3px 3px' }}
					variant="contained"
				>
					BOYS
				</Button>
			)}
			<Timeline activeuser={active} sport="tennis" />
		</div>
	);
}
