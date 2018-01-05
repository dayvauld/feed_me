import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:feed_me/ui/home/RestaurantCard.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:feed_me/store/store.dart' as store;

class HomePageBody extends StatefulWidget {
  @override
  HomePageBodyState createState() => new HomePageBodyState();
}

class HomePageBodyState extends State<HomePageBody> {

  DataSnapshot snapshot;
  String chosenRestaurantId;

  Future updateSnapshot() async {
    var snap = await store.restaurantsDatabaseReference.once();
    this.setState(() {
      snapshot = snap;
    });
    return 'Success!';
  }

  @override
  void initState() {
    super.initState();
    store.chosenRestaurantReference.onChildChanged
        .listen((Event event) {
          setState(() {
            this.chosenRestaurantId = event.snapshot.value;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: new Color(0xFFFFFFF),
        child: new FirebaseAnimatedList(
            query: store.restaurantsDatabaseReference.orderByChild('vote_count'),
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            itemBuilder: (_, DataSnapshot snapshot, Animation<double> animation) =>
          new RestaurantCard(snapshot, chosenRestaurantId)
        ),
      ),
    );
  }
}