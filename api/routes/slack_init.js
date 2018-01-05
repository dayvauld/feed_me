var express = require('express');
var router = express.Router();
var firebase = require('../app/firebase');
var yelp = require('../app/yelp');

const SLACK_TOKEN = 'vO98COhQB6RWMulGQUroFwx4';

router.post('/', function(req, res, next) {

  if (req.body) {
    if (req.body.token !== SLACK_TOKEN) {
      res.status(400).send('Invalid Slack token.');
      return;
    }

    var text = req.body.text;
    if (text) {
      if (text === 'start') {
        yelp.retrieveRestaurantData()
          .then((data) => {
            return firebase.setRestaurantData(data)
          })
          .then(() => {
            var result = {};
            result.text = "Retrieved nearby restaurants, starting voting now!";
            res.status(200).json(result);
          })
          .catch(err => {
            res.status(400).send(err.message);
          });
      } else if (text === 'end') {
        firebase.setChosenRestaurant()
          .then((restaurant) => {
            var result = {};
            result.text = "Voting finished, the restaurant of the week is: " + restaurant.name + "!";
            res.status(200).json(result);
          })
          .catch(err => {
            res.status(400).send(err.message);
          });
      } else {
        res.status(400).send('Invalid arguments.');
        return;
      }
    } else {
      res.status(400).send('No arguments.');
      return;
    }

  } else {
    res.status(400).send('Missing POST body.');
  }
});

module.exports = router;
