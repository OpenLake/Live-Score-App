import React, { useState, useContext} from 'react';
import { FormGroup, FormControl, InputLabel, Input, makeStyles, Typography } from '@material-ui/core';
import { addUser } from '../../Service/api';
import { useParams } from 'react-router-dom';
import { Link } from 'react-router-dom';
import { FormControlLabel, Radio, RadioGroup } from '@mui/material';
import Button from '@mui/material/Button';
import { UserContext } from '../../../UserContext';

const useStyles = makeStyles({
    container: {
        width: '50%',
        margin: '5% 0 0 25%',
        '& > *': {
            marginTop: 20
        }
    }
})

const AddMatch = () => {
    const { sport } = useParams();
    const {admin,setAdmin}=useContext(UserContext)
    const initialValue = {
        title: '',
        winner: 'Match pending',
        date: '',
        set1: [0, 0],
        set2: [0, 0],
        set3: [0, 0],
        gender: '',
        sports: sport,
    }
    const [user, setUser] = useState(initialValue);
    const classes = useStyles();
    

    const onValueChange = (e) => {
        const newData = { ...user };
        newData[e.target.name]= e.target.value;
        setUser(newData);
    }

    const addUserDetails = async() => {
        await addUser(user);
    }

    return (
        <>
        {admin ? <FormGroup className={classes.container}>
            <Typography variant="h4">Add Match</Typography>
            <FormControl>
                <InputLabel htmlFor="my-input">Player1 VS Player2</InputLabel>
                <Input onChange={(e) => onValueChange(e)} name='title' required autoComplete="off" />
            </FormControl>
            <FormControl>
                <InputLabel htmlFor="my-input">YYYY/MM/DD</InputLabel>
                <Input onChange={(e) => onValueChange(e)} name='date' required autoComplete="off" />
            </FormControl>
            <RadioGroup onChange={(e) => onValueChange(e)} name='gender'>
                <FormControlLabel value="female" label="Girls" control={<Radio/>}/>
                <FormControlLabel value="male" label="Boys" control={<Radio/>}/>
            </RadioGroup>
            
            <Link to="/" style={{ textDecoration: 'none' }}>
            <FormControl>
                <Button  variant="contained" color="primary" onClick={() => addUserDetails()}>Add Match</Button>
            </FormControl>
            </Link>
        </FormGroup> :
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
    )
}

export default AddMatch;