const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const buddySchema = new Schema({
    name: String,
    location:String,
    team: String,
});

const BuddyModel = mongoose.model('Buddies', buddySchema);

module.exports = BuddyModel;
