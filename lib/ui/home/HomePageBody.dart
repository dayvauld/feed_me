import 'package:flutter/material.dart';
import 'package:feed_me/ui/home/RestaurantCard.dart';
import 'package:feed_me/model/Restaurant.dart';

class HomePageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: new Container(
        color: new Color(0xFFFFFFF),
        child: new CustomScrollView(
          scrollDirection: Axis.vertical,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              sliver: new SliverFixedExtentList(
                itemExtent: 152.0,
                delegate: new SliverChildBuilderDelegate(
                      (context, index) => new RestaurantCard(restaurants[index]),
                  childCount: restaurants.length,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}