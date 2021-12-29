import express from 'express';
import bodyParser from 'body-parser';
//import dotenv from 'dotenv';
import mongoose from 'mongoose';
import cors from 'cors';

import Routes from './server/route.js';

const app = express(); 
app.use(bodyParser.json({extended: true }));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

app.use('/users', Routes);

const URL='mongodb+srv://badminton:badminton@cluster0.t3oqc.mongodb.net/Cluster0?retryWrites=true&w=majority';
const PORT = '8080';
mongoose.connect(URL, { useNewUrlParser: true, useUnifiedTopology: true }).then(() => { 
    app.listen(PORT, () => console.log(`Server is running on PORT: ${PORT}`))
}).catch((error) => {
    console.log('Error:', error.message)
})