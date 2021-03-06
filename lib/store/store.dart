import 'dart:async';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';


final googleSignIn = new GoogleSignIn();
final auth = FirebaseAuth.instance;
final databaseReference = FirebaseDatabase.instance.reference();
var restaurantsDatabaseReference = databaseReference.child('restaurants');
var chosenRestaurantReference = databaseReference.child('chosen_restaurant');

GoogleSignInAccount user;
var displayName;

Future<Null> _ensureLoggedIn() async {
  user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    await googleSignIn.signIn();
  }
  if (await auth.currentUser() == null) {
    GoogleSignInAuthentication credentials =
    await googleSignIn.currentUser.authentication;
    await auth.signInWithGoogle(
      idToken: credentials.idToken,
      accessToken: credentials.accessToken,
    );
  }

  displayName = user.displayName.split(" ")[0];
}

var logIn = _ensureLoggedIn();