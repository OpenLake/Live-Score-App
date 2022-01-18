import React, { useState, useContext} from 'react';
import { FormGroup, FormControl, InputLabel, Input, makeStyles, Typography } from '@material-ui/core';
import Button from '@mui/material/Button';
import { UserContext } from '../UserContext';
import { Link } from 'react-router-dom';
import img from './Image/Sakshi_login.png'

const useStyles = makeStyles({
    container: {
        width: '50%',
        margin: '5% 0 0 25%',
        '& > *': {
            marginTop: 20
        }
    }
})
export default function Login() {
    const {admin,setAdmin}=useContext(UserContext)
    const [password, checkPassword] = useState(false);
    const classes = useStyles();
    

    const onValueChange = (e) => {
        const inputPassword= e.target.value;
        if(inputPassword===process.env.REACT_APP_PASSWORD)
        {
            checkPassword(true)
        }
        
    }
    const checkUser=() =>{
        if(password===true)
        {
        setAdmin(true)
         localStorage.setItem("islogin",'loggedin')
        }
    }
    return (
        <>
        <div style={{width: 'fit-content', margin: 'auto'}}>
        <img src={img} alt='logo'/>
        </div>
     <FormGroup className={classes.container}>
     
            <Typography variant="h4">Login</Typography>
            <FormControl>
                <InputLabel htmlFor="my-input">Password</InputLabel>
                <Input onChange={(e) => onValueChange(e)} name='inputpassword' />
            </FormControl>
            
            <FormControl >
            <Link to="/" style={{ textDecoration: 'none', width:'50%' }}>
                <Button variant="contained" color="primary" onClick={() => checkUser()}>Login</Button>
               
            </Link>
            </FormControl>
            
        </FormGroup>
        </>
    )
}

