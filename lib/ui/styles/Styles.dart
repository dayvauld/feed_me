import 'package:flutter/material.dart';

class Styles {

  static final baseTextStyle = const TextStyle(
      fontFamily: 'Poppins'
  );

  static final regularTextStyle = baseTextStyle.copyWith(
      color: const Color(0xffb6b2df),
      fontSize: 9.0,
      fontWeight: FontWeight.w400
  );
  static final subHeaderTextStyle = regularTextStyle.copyWith(
      color: const Color(0xD9FFFFFF),
      fontSize: 12.0
  );
  static final headerTextStyle = baseTextStyle.copyWith(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600
  );
  static final voteUnselectedTextStyle = baseTextStyle.copyWith(
    color: Colors.white,
    fontSize: 20.0,
  );
  static final voteSelectedTextStyle = baseTextStyle.copyWith(
    color: Colors.black,
    fontSize: 20.0,
  );

}