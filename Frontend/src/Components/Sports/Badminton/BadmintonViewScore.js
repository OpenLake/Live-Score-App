import React from "react";
import { useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { Table, TableHead, TableCell, TableRow, TableBody,makeStyles } from '@material-ui/core'
import { getUsers } from '../../Service/api';
import { Button} from '@mui/material';
import Readrow from './Readrow'


const initialValue = {
    title: '',
    winner: '',
    date: '',
    set1: [0,0],
    set2:[0,0],
    set3:[0,0],
    gender:''
}
const useStyles = makeStyles({
    table: {
        width: '100%',
    },
    thead: {
        '& > *': {
            fontSize: 20,
            background: '#164e63',
            color: '#FFFFFF'
        }
    },
    row: {
        '& > *': {
            fontSize: 18
        }
    }
})

function BadmintonViewScore(props) {
    const [user, setUser] = useState(initialValue);
    // const[editcell,seteditcell]=useState(true);
    const classes = useStyles();
   // const { title,winner,date,set1,set2,set3,gender } = user;
    //const name = props.match.params.name;
    const { id } = useParams();
  console.log(id);
  
  useEffect(() => {
    loadUserDetails();
},[]);

const loadUserDetails = async() => {
    const response = await getUsers(id);
    setUser(response.data);
}
console.log(user.date)

const title_array=user.title.split(' ');
    return(
        <>
            <Table className={classes.table}>
            <TableHead>
                <TableRow  className={classes.thead} >
                    <TableCell></TableCell>
                    <TableCell>{title_array[0]}</TableCell>
                    <TableCell>{title_array[2]}</TableCell>      
                    <TableCell></TableCell>              
                </TableRow>
            </TableHead>
            <TableBody>
                    <Readrow user={user}/>
            </TableBody>
            </Table>
                
                {/* <h1>{user.set1[0].$numberDecimal}</h1> */}
            
        </>
    )
}
export default BadmintonViewScore;