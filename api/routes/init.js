var express = require('express');
var router = express.Router();
var firebase = require('../app/firebase');
var Yelp = require('yelp-v3');

const YELP_API_KEY = '3CPp9gC5pl9z_EbOn8Ic4YoxP-Fu4iaGDxY1UdIh-GQ3qGGHZ9Nb-SpX5AjCfP0VubvwemeJFEtNmfs-ePoK_iwUc-nJqM-XPQ0--Q8AxoNJQ4DpYFyBezEx5upLWnYx';

var yelp = new Yelp({
  access_token: YELP_API_KEY
});

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

    yelp.search({ term: 'food', latitude: 49.2853055, longitude: -123.116441, limit: 50})
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
