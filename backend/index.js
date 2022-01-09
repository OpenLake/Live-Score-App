const express = require('express');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');
const cors = require('cors');

const Routes = require('./server/route.js');

const app = express();
app.use(bodyParser.json({ extended: true }));
app.use(bodyParser.urlencoded({ extended: true }));
app.use(cors());

app.use('/users', Routes);

const URL =
	'mongodb+srv://badminton:badminton@cluster0.t3oqc.mongodb.net/Cluster0?retryWrites=true&w=majority';
const PORT = process.env.PORT || 8080;
mongoose
	.connect(URL, { useNewUrlParser: true, useUnifiedTopology: true })
	.then(() => {
		console.log('connected with mongodb');
	})
	.catch(error => {
		console.log('Error:', error.message);
	});
const server = app.listen(PORT, () =>
	console.log(`Server is running on PORT: ${PORT}`),
);

const socket = require('socket.io');
const io = socket(server, {
	cors: {
		origin: '*',
	},
});
app.io = io;

io.on('connection', socket => {
	console.log('connected to socket');
});
