import { Route, Routes } from 'react-router-dom';
import React from 'react';
import Home from './Home'
import Navbar from './Navbar'
import Badminton from './Sports/Badminton'
import Cricket from './Sports/Cricket'

function App() {
  return (
    <>
     <Navbar/>
         <Routes>
              <Route path='/' element={<Home/>}/>
              <Route exact path="/badminton" element={<Badminton/>} />
              <Route exact path="/cricket" element={<Cricket/>} />
             
          </Routes>
     </>
  );
}

export default App;
