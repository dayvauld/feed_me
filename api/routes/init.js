var express = require('express');
var router = express.Router();
var firebase = require('../app/firebase');
var yelp = require('../app/yelp');

router.post('/', function(req, res, next) {
  if (req.body.username && req.body.password) {
    if (req.body.username !== 'admin') {
      res.status(400).send('Invalid username.');
      return;
    }

    if (req.body.password !== 'feedmeaeq2018') {
      res.status(400).send('Invalid password.');
      return;
    }
    yelp.retrieveRestaurantData()
      .then((data) => {
        return firebase.setRestaurantData(data)
      })
      .then(() => {
        res.status(200).send('Successfully retrieved and stored restaurants. Start voting!');
      })
      .catch(err => {
        res.status(400).send(err.message);
      });
  } else {
    res.status(400).send('Missing username and password.');
  }
});

module.exports = router;
