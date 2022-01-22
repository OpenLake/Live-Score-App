import { Route, Routes } from 'react-router-dom';
import React,{useState,useEffect} from 'react';
import Home from './Home';
import Navbar from './Navbar';
import Badminton from './Sports/Badminton/Badminton';
import BadmintonViewScore from './Sports/Badminton/BadmintonViewScore';
import Editscore from './Sports/Badminton/Editscore';
import TableTennis from './Sports/TableTennis/TableTennis';
import AddMatch from './Sports/Badminton/AddMatch';
import {UserContext} from '../UserContext';
import Login from './Login';



function App() {
	const [admin,setAdmin]=useState(false)

	useEffect(() => {
		if(localStorage.getItem("islogin")==null)
		{
		localStorage.setItem('islogin','')
		}
		if(localStorage.getItem("islogin")==="loggedin"){
			setAdmin(true);
		}
	}, [])
	return (
		<>
		<UserContext.Provider value={{admin,setAdmin}}>
			<Navbar />
			<Routes>
				<Route path="/" element={<Home />} />
				<Route exact path="/login" element={<Login />} />
				<Route exact path="/badminton" element={<Badminton />} />
				<Route exact path="/tabletennis" element={<TableTennis />} />
				<Route exact path="/addmatch/:sport" element={<AddMatch/>} />
				<Route
					exact
					path="/badmintonscore/:id"
					element={<BadmintonViewScore />}
				/>
				<Route exact path="/editscore/:id/:set" element={<Editscore />} />
			</Routes>
			</UserContext.Provider>
		</>

	);
}

export default App;
