import React from 'react';
import Typography from '@mui/material/Typography';

function Home() {
    return (
      <>
      <div style={{position:'fixed', textAlign:'center'}}>
        <div style={{ 
        backgroundImage:`url(https://i.pinimg.com/originals/8b/74/c8/8b74c81223959fe064de7602fbca6ff7.jpg)`,
        backgroundPosition: 'center',
        backgroundSize: 'cover',
        backgroundRepeat: 'no-repeat',
        width: '100vw',
        height: '100vh',
        // position:'absolute'
      }}>
      </div>
      <Typography style={{
        position:'absolute',
        top:'40%',
        left:'50%',
        fontSize:'3rem',
        transform: 'translate(-50%, -50%)'
        }}
        > PRAYATNA</Typography>
      </div>
      </>
    );
  }
  
  export default Home;