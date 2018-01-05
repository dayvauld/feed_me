var admin = require('firebase-admin');

var serviceAccount = require('../service-account-key.json');
var database;

module.exports.initialize = function() {
  console.log('Initializing Firebase...');
  admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
    databaseURL: "https://feedme-aeq.firebaseio.com"
  });
  database = admin.database();
}

module.exports.setRestaurantData = function(data) {
  return database.ref('restaurants')
          .set(null)
          .then(() => {
            let businesses = data.businesses;
            let updates = {};
            businesses.forEach(function(business) {
              let restaurant = {
                name: business.name,
                image_url: business.image_url,
                url: business.url,
                category: business.categories[0].title,
                rating: business.rating,
                review_count: business.review_count,
                price: business.price,
                phone: business.phone,
                distance: business.distance,
                latitude: business.coordinates.latitude,
                longitude: business.coordinates.longitude,
                location: business.location.address1,
                vote_count: 0
              };
              let restaurantId = database.ref().child('restaurants').push().key;
              updates['/restaurants/' + restaurantId] = restaurant;
              updates['/chosen_restaurant/id'] = "";
            });
            return database.ref().update(updates);
          });
}

module.exports.setChosenRestaurant = function() {
  return new Promise((resolve, reject) => {
    database.ref('restaurants')
            .orderByChild('vote_count')
            .limitToFirst(1)
            .once('value', function(dataSnapshot) {
              var restaurantSnapshot;
              dataSnapshot.forEach(function(childSnapshot) {
                restaurantSnapshot = childSnapshot;
              });

              database.ref('chosen_restaurant')
                .child('id')
                .set(restaurantSnapshot.key)
                .catch((err) => {
                  reject(err);
                });
                resolve(restaurantSnapshot.val());
            })
            .catch((err) => {
              reject(err);
            });
  });
}
