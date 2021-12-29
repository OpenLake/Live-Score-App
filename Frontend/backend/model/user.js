import mongoose from 'mongoose';
//import autoIncrement from 'mongoose-auto-increment';

// how our document look like
const badmintonSchema = mongoose.Schema({
    title: String,
    date: Date,
    winner: String,
    set1: Array,
    set2: Array,
    set3: Array,
    gender:String
});

//autoIncrement.initialize(mongoose.connection);
//userSchema.plugin(autoIncrement.plugin, 'user');
// we need to turn it into a model
const postUser = mongoose.model('badminton', badmintonSchema);

export default postUser;