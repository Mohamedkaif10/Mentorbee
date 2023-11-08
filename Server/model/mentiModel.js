const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const mentiSchema = new Schema({
    name: String,
    location:String,
    team: String,
});

const MentiModel = mongoose.model('Mentis', mentiSchema);

module.exports =MentiModel;
