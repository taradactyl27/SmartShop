var mongoose = require('mongoose');

var itemSchema = new mongoose.Schema({
    id: String,
    name: String,
    price: Number,
    picture: String,
    stock: Number,
    desc: String
});

module.exports = {
    ItemModel: mongoose.model('Item', itemSchema),
  };