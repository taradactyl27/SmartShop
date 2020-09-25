// module imports
const express = require("express");
const mongoose = require("mongoose");
const bodyParser = require("body-parser");
const passport = require("passport");
const app = express();

// file imports
const users = require("./api/users");
const Manager = require("./api/TaskManager");
const keys = require("./config/keys");
require("./config/passport")(passport); // Passport config

// export universal manager
//const TaskManager = new Manager();
//module.exports = TaskManager;

// Bodyparser middleware
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// Connect to MongoDB
const opts = { useNewUrlParser: true, useUnifiedTopology: true };
mongoose.connect(keys.MONGO_KEY, opts).then(() => {
  console.log("Connected to database");
}).catch((err) => {
  console.log(err);
});

// Passport middleware
app.use(passport.initialize());

// Routes
app.use("/api/users", users);
app.use("/api/taskmanager", Manager)

app.post('/dataSubmittedHW', function(req, res){
  let data = req.body.data;
  User.find({username: Username}, function (err, user) {
  /*const vision = require('@google-cloud/vision');
  const client = new vision.ImageAnnotatorClient();
  
  const fileName = 'Local image file, e.g. /path/to/image.png';

  // Performs text detection on the local file
  const [result] = await client.textDetection(fileName);
  const detections = result.textAnnotations;
  console.log('Text:');
  detections.forEach(text => console.log(text));*/
  user.save(function (err) {
    if(err) {
        console.error('ERROR!');
    }
});
});
})
app.post('/dataSubmittedNotes', function(req,res){
  let data = req.body.data;
  User.find({username: Username}, function (err, user) {
  /*const vision = require('@google-cloud/vision');

  const client = new vision.ImageAnnotatorClient();
  const fileName = 'Local image file, e.g. /path/to/image.png';
  
  // Read a local image as a text document
  const [result] = await client.documentTextDetection(fileName);
  const fullTextAnnotation = result.fullTextAnnotation;
  console.log(`Full text: ${fullTextAnnotation.text}`);
  fullTextAnnotation.pages.forEach(page => {
    page.blocks.forEach(block => {
      console.log(`Block confidence: ${block.confidence}`);
      block.paragraphs.forEach(paragraph => {
        console.log(`Paragraph confidence: ${paragraph.confidence}`);
        paragraph.words.forEach(word => {
          const wordText = word.symbols.map(s => s.text).join('');
          console.log(`Word text: ${wordText}`);
          console.log(`Word confidence: ${word.confidence}`);
          word.symbols.forEach(symbol => {
            console.log(`Symbol text: ${symbol.text}`);
            console.log(`Symbol confidence: ${symbol.confidence}`);
          });
        });
      });
    });
  });*/
  user.save(function (err) {
    if(err) {
        console.error('ERROR!');
    }
});
});
})

app.put('/profileupdate', function(req,res){
  let data = req.body.data;
  User.update({username: oldUsername}, {
    data: newUser.data
}, function(err, numberAffected, rawResponse) {
   //handle it
})
})
// run the server
const port = process.env.PORT || 5000; // process.env.port is Heroku's port if we deploy
app.listen(port, () => console.log(`Server running on port ${port}!`));
