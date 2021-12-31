import  React, { useState, useEffect } from 'react';
import Timeline from '@mui/lab/Timeline';
import TimelineItem from '@mui/lab/TimelineItem';
import TimelineSeparator from '@mui/lab/TimelineSeparator';
import TimelineConnector from '@mui/lab/TimelineConnector';
import TimelineContent from '@mui/lab/TimelineContent';
import TimelineDot from '@mui/lab/TimelineDot';
import Card from '../Card/Card'
import { getUsers } from '../Service/api';
import { makeStyles } from '@material-ui/core';

const useStyles = makeStyles({
   timeline:{
     marginLeft:'1px'
   }
})

export default function ColorsTimeline() {

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
      <Timeline className={classes.timeline} >
      <TimelineItem>
        <TimelineSeparator>
          <TimelineDot color="secondary" />
          <TimelineConnector />
        </TimelineSeparator>
        <TimelineContent>
            <Card prop={val}
                // key={val.id}
                // title={val.title}
                // winner={val.winner}
            />  
        </TimelineContent>
      </TimelineItem>
     </Timeline>

    )
  }
  return( 
    <>
    {users.map(cardtime)}
    {/* { user ==="boys" && Enadata.map(cardtime)}
    { user ==="girls" && Diodata.map(cardtime)}     */}
    </>)
}