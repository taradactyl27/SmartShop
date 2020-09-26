var mogoose = require('mongoose');

var userSchema = new mongoose.Schema({
    // link position
    name: String,
    email: String,
    password: String
  });

  module.exports = {
    UserModel: mongoose.model('User', userSchema),
  };