import { Route, Routes } from 'react-router-dom';
import React from 'react';
import Home from './Home'
import Navbar from './Navbar'
import Badminton from './Sports/Badminton'
import Cricket from './Sports/Cricket'
import BadmintonViewScore from './Sports/BadmintonViewScore'

function App() {
  return (
    <>
     <Navbar/>
         <Routes>
              <Route path='/' element={<Home/>}/>
              <Route exact path="/badminton" element={<Badminton/>} />
              <Route exact path="/cricket" element={<Cricket/>} />
              <Route exact path="/badmintonscore/:id"  element={<BadmintonViewScore/>} />
          </Routes>
     </>
  );
}

export default App;
