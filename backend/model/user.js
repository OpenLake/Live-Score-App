import mongoose from 'mongoose';

const badmintonSchema = mongoose.Schema({
    title: String,
    date: Date,
    winner: String,
    set1: Array,
    set2: Array,
    set3: Array,
    gender:String
});


const postUser = mongoose.model('badminton', badmintonSchema);

export default postUser;