import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {

  final DataSnapshot snapshot;

  DetailPage(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: const Color(0xFF736AB7),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(snapshot.value['name']),
            new Hero(tag: "restaurant-hero-${snapshot.key}",
              child: new Image.network(
                snapshot.value['image_url'],
                fit: BoxFit.cover,
                width: 96.0,
                height: 96.0,
              ),
            )
          ],
        ),
      ),
    );
  }
}