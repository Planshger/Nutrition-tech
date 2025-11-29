import 'package:flutter/cupertino.dart';

Widget detailsRow(String label, String value) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 14.0),
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: CupertinoColors.separator, width: 0.5))),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 16, color: CupertinoColors.label, decoration: TextDecoration.none, fontWeight: FontWeight.normal)),
        Text(value, style: const TextStyle(fontSize: 16, color: CupertinoColors.secondaryLabel, decoration: TextDecoration.none, fontWeight: FontWeight.normal)),
      ],
    ),
  );
}