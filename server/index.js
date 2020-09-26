var createError = require('http-errors');
var express = require('express');
var path = require('path');
var mongoose = require('mongoose');
var { graphqlHTTP } = require('express-graphql');
var { buildSchema } = require('graphql');
var passport = require("passport");
var db = require('./config/db.json');

var schema = buildSchema(`
  type Query {
    hello: String
  }
`);

var connection = "mongodb://" + db.DB_USER + ":" + db.DB_PASSWORD + "@smartshopdb-shard-00-00.zsyov.mongodb.net:27017,smartshopdb-shard-00-01.zsyov.mongodb.net:27017,smartshopdb-shard-00-02.zsyov.mongodb.net:27017/SmartShopDB?ssl=true&replicaSet=atlas-8q4qhe-shard-0&authSource=admin&retryWrites=true&w=majority";
mongoose.connect(connection)
.then(() =>  console.log('connection successful'))
.catch((err) => console.error(err));


var app = express();

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');


app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, 'public')));

var app = express();
app.use('/graphql', graphqlHTTP({
  schema: schema,
  rootValue: root,
  graphiql: true,
}));
app.listen(4000);



module.exports = app;