import { Route, Routes } from 'react-router-dom';
import React, { useEffect } from 'react';
import Home from './Home'
import Navbar from './Navbar'
import Badminton from './Sports/Badminton/Badminton'
import Cricket from './Sports/Cricket'
import BadmintonViewScore from './Sports/Badminton/BadmintonViewScore'
import Editscore from './Sports/Badminton/Editscore'
import TableTennis from './Sports/TableTennis/TableTennis'
import {io} from 'socket.io-client'

function App() {
//   useEffect(() => {
//      const socket=io('http://localhost:8080/users')
// },[]);
  return (
    <>
     <Navbar/>
         <Routes>
              <Route path='/' element={<Home/>}/>
              <Route exact path="/badminton" element={<Badminton/>} />
              <Route exact path="/cricket" element={<Cricket/>} />
              <Route exact path="/tabletennis" element={<TableTennis/>} />
              <Route exact path="/badmintonscore/:id"  element={<BadmintonViewScore/>} />
              <Route exact path="/editscore/:id/:set"  element={<Editscore/>} />
          </Routes>
     </>
  );
}

export default App;
