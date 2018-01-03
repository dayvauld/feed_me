import 'package:flutter/material.dart';
import 'package:feed_me/model/Restaurant.dart';
import 'package:feed_me/ui/detail/DetailPage.dart';

class RestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantCard(this.restaurant);

    @override
    Widget build(BuildContext context) {
      final baseTextStyle = const TextStyle(
          fontFamily: 'Poppins'
      );
      final regularTextStyle = baseTextStyle.copyWith(
          color: const Color(0xffb6b2df),
          fontSize: 9.0,
          fontWeight: FontWeight.w400
      );
      final subHeaderTextStyle = regularTextStyle.copyWith(
          color: const Color(0xAAFFFFFF),
          fontSize: 12.0
      );
      final headerTextStyle = baseTextStyle.copyWith(
          color: Colors.white,
          fontSize: 18.0,
          fontWeight: FontWeight.w600
      );

      var screenWidth = MediaQuery.of(context).size.width;


      final restaurantThumbnail = new Container(
            alignment: FractionalOffset.center,
        child: new Hero(
          tag: "restaurant-hero-${restaurant.id}",
          child: new Image(
            image: new AssetImage('assets/img/sample_img_0.png'),
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
              new Text(value, style: regularTextStyle),
            ]
        );
      }

      final restaurantCardContent = new Container(
        margin: new EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
        constraints: new BoxConstraints.expand(),
        child: new Center(child:new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //Name
            new Container(height: 4.0),
            new Center(child:new Text(restaurant.name,
              style: headerTextStyle,
            )),
            //Location
//            new Container(height: 2.0),
            new Center(child:new Text(restaurant.location,
                style: subHeaderTextStyle
            )),
//            new Container(
//                margin: new EdgeInsets.symmetric(vertical: 4.0),
//                height: 4.0,
//                width: 18.0,
//                color: new Color(0xff00c6ff)
//            ),
            //Vote Count
            new Center(
              child:new Row(
              children: <Widget>[
                new Center(
                  child: new Container(
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      border: new Border.all(
                        color: Colors.white,
                        width: 1.0,
                      ),
                    ),
                    child: new Center(
                      child: new Text(
                        "3",
                      ),
                    ),
                  )
                ),
              new Text('votes',
                  textAlign: TextAlign.center,
                  style: subHeaderTextStyle),
              ],
              ),
            ),
            // Cuisine Type
            new Center(
              child: new Text(restaurant.cuisine,
                textAlign: TextAlign.left,
                style: subHeaderTextStyle
              ),
            ),
            // Price & Distance
            new Row(
              children: <Widget>[
                new Expanded(
                    child: _restaurantValue(
                        value: restaurant.distance,
                        image: 'assets/img/ic_distance.png')

                ),
                new Expanded(
                    child: _restaurantValue(
                        value: restaurant.price,
                        image: 'assets/img/ic_distance.png')
                )
              ],
            ),
          ],
        ),
        ),
      );

      final restaurantItem = new Card(
        child: new Stack(children: <Widget>[restaurantThumbnail,restaurantThumbnailOverlay,restaurantCardContent,],)
      );

      return new GestureDetector(
          onTap: () => Navigator.of(context).push(new PageRouteBuilder(
            pageBuilder: (_, __, ___) => new DetailPage(restaurant),
          )),
          child: new Container(
            height: 120.0,
            margin: const EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 2.0,
            ),
            child: new Stack(
              children: <Widget>[
                restaurantItem,
              ],
            ),
          )
      );
    }
}