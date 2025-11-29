import 'package:flutter/cupertino.dart';

Widget detailsSubtitle(String title) {
  return Padding(
    padding: const EdgeInsets.only(left: 22.0, right: 16.0, top: 24.0, bottom: 8.0),
    child: Text(
      title.toUpperCase(),
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.normal,
        color: CupertinoColors.secondaryLabel,
        decoration: TextDecoration.none,
      ),
    ),
  );
}
