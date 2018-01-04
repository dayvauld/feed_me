import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:feed_me/ui/detail/DetailPage.dart';
import 'package:feed_me/store/store.dart' as store;
import 'package:feed_me/ui/styles/Styles.dart';

class RestaurantCard extends StatelessWidget {
  final DataSnapshot snapshot;

  RestaurantCard(this.snapshot);

  _vote() {
    DatabaseReference votesReference = store.restaurantsDatabaseReference
        .child(snapshot.key)
        .child('votes');
    if (snapshot.value['votes'] != null) {
      if (snapshot.value['votes'][store.user.id] != null) {
        // Unvote
        votesReference
            .child(store.user.id)
            .remove();
      } else {
        // Vote
        votesReference
            .child(store.user.id)
            .set(store.displayName);
      }
    } else {
      // Vote
      votesReference
          .child(store.user.id)
          .set(store.displayName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var voteTextStyle;
    var voteSelectionColor;
    if (snapshot.value['votes'] != null) {
      if (snapshot.value['votes'][store.user.id] != null) {
        voteTextStyle = Styles.voteSelectedTextStyle;
        voteSelectionColor = Colors.white;
      } else {
        voteTextStyle = Styles.voteUnselectedTextStyle;
        voteSelectionColor = Colors.transparent;
      }
    } else {
      voteTextStyle = Styles.voteUnselectedTextStyle;
      voteSelectionColor = Colors.transparent;
    }
    var voteCount = 0;
    if (snapshot.value['votes'] != null) {
      Map votes = snapshot.value['votes'];
      voteCount = votes.length;
    }

    final votesTextStyle = Styles.voteUnselectedTextStyle.copyWith(
      color: Colors.white,
      fontSize: 15.0,
    );
    var screenWidth = MediaQuery
        .of(context)
        .size
        .width;


    final restaurantThumbnail = new Container(
      alignment: FractionalOffset.center,
      child: new Hero(
        tag: "restaurant-hero-${snapshot.key}",
        child: new Image.network(
          snapshot.value['image_url'],
          width: screenWidth,
          fit: BoxFit.cover,
        ),
      ),
    );

    final restaurantThumbnailOverlay = new Container(
      color: Colors.black45,
    );

    Widget _restaurantValue({String value, String image}) {
      return new Row(
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text(value, style: Styles.regularTextStyle),
          ]
      );
    }

    final restaurantCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      constraints: new BoxConstraints.expand(),
      child: new Center(child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          // Vote Count
          new Center(
            heightFactor: 1.25,
            child: new GestureDetector(
              onTap: () {
                this._vote();
              },
              child: new Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Center(
                      child: new Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: new BoxDecoration(
                          shape: BoxShape.circle,
                          color: voteSelectionColor,
                          border: new Border.all(
                            color: Colors.white,
                            width: 1.0,
                          ),
                        ),
                        child: new Center(
                          child: new Text(
                            voteCount.toString(),
                            style: voteTextStyle,
                          ),
                        ),
                      )
                  ),
                  new Text(' votes',
                      textAlign: TextAlign.center,
                      style: votesTextStyle),
                ],
              ),
            ),
          ),
          // Category
          new Center(
            child: new Text(snapshot.value['category'],
                textAlign: TextAlign.left,
                style: Styles.subHeaderTextStyle
            ),
          ),
          // Price & Distance
          new Row(
            children: <Widget>[
              new Expanded(
                  child: _restaurantValue(
                      value: snapshot.value['distance'].toInt().toString() +
                          'm',
                      image: 'assets/img/ic_distance.png')

              ),
              new Text(snapshot.value['price'],
                  textAlign: TextAlign.center,
                  style: Styles.subHeaderTextStyle
              )
            ],
          ),
        ],
      ),
      ),
    );

    final restaurantItem = new Card(
        child: new Stack(children: <Widget>[
          restaurantThumbnail,
          restaurantThumbnailOverlay,
          restaurantCardContent,
        ],)
    );

    return new GestureDetector(
        onTap: () =>
            Navigator.of(context).push(new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(snapshot),
            )),
        child: new Container(
          height: 140.0,
          margin: const EdgeInsets.symmetric(
            vertical: 2.0,
            horizontal: 2.0,
          ),
          child: restaurantItem,
        )
    );
  }
}