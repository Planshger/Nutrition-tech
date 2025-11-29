import 'package:flutter/cupertino.dart';

Widget recipeTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, decoration: TextDecoration.none, color: CupertinoColors.label),
      ),
    );
  }