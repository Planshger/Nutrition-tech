import 'package:flutter/cupertino.dart';

class FavouritesTile extends StatelessWidget {
  final Widget title;
  final VoidCallback? onTap;
  final Widget? trailing;

  const FavouritesTile({super.key, required this.title, this.onTap, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).brightness == Brightness.light ? CupertinoColors.white : CupertinoColors.secondarySystemGroupedBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: const Color.fromARGB(36, 12, 136, 140), 
              width: 2.0, 
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              title,
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}