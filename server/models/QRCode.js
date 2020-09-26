var mongoose = require('mongoose');

var qrSchema = new mongoose.Schema({
    id: String,
    value: String
});

module.exports = {
    qrModel: mongoose.model('QR', qrSchema),
  };