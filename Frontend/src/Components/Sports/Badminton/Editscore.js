import React from "react";
import { useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { FormControl,Input,Table, TableHead, TableCell, TableRow, TableBody,makeStyles } from '@material-ui/core'
import { getUsers } from '../../Service/api';
import { Button} from '@mui/material';



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

function Editscore(props) {
    const [user, setUser] = useState(initialValue);
    const[name,setName]=useState("hello")
    const classes = useStyles();
    const { title,winner,date,set1,set2,set3,gender } = user;
    //const name = props.match.params.name;
    const { id , set} = useParams();
  
  
  useEffect(() => {
    console.log(id);
    console.log(set)
    loadUserDetails();
},[]);

const loadUserDetails = async() => {
    const response = await getUsers(id);
    setUser(response.data);

}


const onValueChange = (e) => {
    const newData={...user}
    // console.log(e.target.value)
    // console.log(newData.set1[0].$numberDecimal)
     newData.set1[0].$numberDecimal=e.target.value

    //  console.log(newData)
    // console.log(e.target.value)
 setUser(newData)
   console.log(user)
}
const title_array=user.title.split(' ');
    return(
        <>
        {/* <Input value={name}  onChange={(e) => (setName(e.target.value))}/> */}
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
            
                   <TableRow className={classes.row}>
                        <TableCell>{set}</TableCell> 
                        <TableCell>
                        <FormControl>
                          <Input onChange={(e) => onValueChange(e)} name='set1' value={user.set1[0].$numberDecimal} autoComplete="off"/>
                        </FormControl>
                        </TableCell>
                        <TableCell>
                        <FormControl>
                          <Input  name='set1' value={user.set1[1].$numberDecimal} autoComplete="off" />
                        </FormControl>
                        </TableCell>
                        <TableCell>
                            <Button  color="primary" variant="contained" style={{marginRight:10}} >Save</Button> 
                        </TableCell>
                    </TableRow>
            </TableBody>
            </Table>            
        </>
    )
}
export default Editscore;