import 'package:flutter/material.dart';
import 'package:feed_me/model/Restaurant.dart';

class DetailPage extends StatelessWidget {

  final Restaurant restaurant;

  DetailPage(this.restaurant);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: const Color(0xFF736AB7),
        constraints: new BoxConstraints.expand(),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(restaurant.name),
            new Hero(tag: "restaurant-hero-${restaurant.id}",
              child: new Image.asset(
                restaurant.image,
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