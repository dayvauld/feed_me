import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:feed_me/ui/styles/Styles.dart';
import 'package:feed_me/store/store.dart' as store;

class DetailPage extends StatelessWidget {

  final DataSnapshot snapshot;

  DetailPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    var mapUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
        + snapshot.value['latitude'].toString()
        + ","
        + snapshot.value['longitude'].toString()
        +
        "&zoom=17&size=640x400&style=element:labels|visibility:on&style=element:geometry.stroke|visibility:off&style=feature:landscape|element:geometry|saturation:-100&style=feature:water|saturation:-100|invert_lightness:true&key=AIzaSyBoIqBIhlfrP2aagQ-kbo0SyV7YGXnrfG4";

    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    DatabaseReference votesReference = store.restaurantsDatabaseReference
        .child(snapshot.key)
        .child('votes');

    final body = new Container(
      color: const Color(0xFF736AB7),
      constraints: new BoxConstraints.expand(),
      child: new Column(
//          mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Hero(tag: "restaurant-hero-${snapshot.key}",
            child: new Image.network(
              snapshot.value['image_url'],
              fit: BoxFit.cover,
              width: screenWidth,
              height: 300.0,
            ),
          ),
          // Name
          new Container(height: 4.0),
          new Center(
              child: new Text(snapshot.value['name'],
                style: Styles.headerTextStyle,
              )),
          // Location
          new Center(
              child: new Text(snapshot.value['location'],
                  style: Styles.subHeaderTextStyle
              )),
          new Flexible(child:
          new Image.network(
            mapUrl,
            fit: BoxFit.cover,
            width: screenWidth,
            height: 400.0,
          ),
          ),
        ],
      ),
    );

    return new Scaffold(
//      appBar: new AppBar(backgroundColor: const Color(0xAA736AB7),),
      body: new Stack(children: <Widget>[
        body,
        new AppBar(backgroundColor: const Color(0x00736AB7),)
      ]
      )
    );
  }
}