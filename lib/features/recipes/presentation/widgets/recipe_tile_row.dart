import 'package:flutter/cupertino.dart';

Widget recipeTileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 14, decoration: TextDecoration.none, color: CupertinoColors.secondaryLabel)),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, decoration: TextDecoration.none, color: CupertinoColors.label)),
        ],
      ),
    );
  }
  
 