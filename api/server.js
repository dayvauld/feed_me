var express = require('express');
var app = express();
var bodyParser = require('body-parser');
var firebase = require('./app/firebase');

var init = require('./routes/init');
var slackInit = require('./routes/slack_init');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(bodyParser.json());

var port = process.env.PORT || 8080;

firebase.initialize();
app.use('/api/init', init);
app.use('/api/slack/init', slackInit);

app.listen(port);
console.log('Magic happens on port ' + port);
