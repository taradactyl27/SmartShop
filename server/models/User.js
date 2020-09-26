var mongoose = require('mongoose');

var userSchema = new mongoose.Schema({
    // link position
    id: Number,
    name: String,
    email: String,
    password: String
  });

  module.exports = {
    UserModel: mongoose.model('User', userSchema),
  };