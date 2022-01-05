import  React, { useState, useEffect } from 'react';
import Card from '../Card/Card'
import { getUsers } from '../Service/api';
import { makeStyles } from '@material-ui/core';

const useStyles = makeStyles({
   timeline:{
     marginLeft:'23%',
     
   }
})

export default function ColorsTimeline(activeuser) {

  const [users, setUsers] = useState([]);
  const classes = useStyles();

    useEffect(() => {
        getAllUsers();
    }, []);


    const getAllUsers = async () => {
        let response = await getUsers();
        setUsers(response.data);
    }

  function cardtime(val){
    return(
      <>
     
    { val.gender===activeuser.activeuser &&
      <div className={classes.timeline}>
            <Card   prop={val} />  
        </div>
    }
 
</>
    )
  }
  return( 
    <>
    {users.map(cardtime)}
    </>)
}