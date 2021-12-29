import React from "react";
import { useParams } from 'react-router-dom';
import { useState, useEffect } from 'react';
import { getUsers } from '../Service/api';

const initialValue = {
    title: '',
    winner: '',
    date: '',
    set1: [0,0],
    set2:[0,0],
    set3:[0,0],
    gender:''
}

function BadmintonViewScore(props) {
    const [user, setUser] = useState(initialValue);
   // const { title,winner,date,set1,set2,set3,gender } = user;
    //const name = props.match.params.name;
    const { id } = useParams();
  console.log(id);

  useEffect(() => {
    loadUserDetails();
}, []);

const loadUserDetails = async() => {
    const response = await getUsers(id);
    setUser(response.data);
}
    return(
        <>
            
                
                <h1>{user.set1[0].$numberDecimal}</h1>
            
        </>
    )
}
export default BadmintonViewScore;