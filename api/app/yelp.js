var Yelp = require('yelp-v3');

const YELP_API_KEY = '3CPp9gC5pl9z_EbOn8Ic4YoxP-Fu4iaGDxY1UdIh-GQ3qGGHZ9Nb-SpX5AjCfP0VubvwemeJFEtNmfs-ePoK_iwUc-nJqM-XPQ0--Q8AxoNJQ4DpYFyBezEx5upLWnYx';

var yelp = new Yelp({
  access_token: YELP_API_KEY
});

module.exports.retrieveRestaurantData = function() {
  return yelp.search({ term: 'food', latitude: 49.2853055, longitude: -123.116441, limit: 50});
}
