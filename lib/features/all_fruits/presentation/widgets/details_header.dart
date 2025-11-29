import 'package:flutter/cupertino.dart';

Widget detailsHeader(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 22.0, right: 16.0, top: 24.0, bottom: 8.0),
    child: Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 19, 
        color: CupertinoColors.label, 
        decoration: TextDecoration.none),
    ),
  );
}