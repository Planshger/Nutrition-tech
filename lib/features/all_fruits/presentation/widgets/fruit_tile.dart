import 'package:flutter/cupertino.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';

class FruitTile extends StatelessWidget {
  final Fruits fruit;
  final Function(BuildContext)? onFavourites;
  final VoidCallback? onTap;

  const FruitTile({
    super.key,
    required this.fruit,
    this.onFavourites,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).brightness == Brightness.light
                ? CupertinoColors.white
                : CupertinoColors.secondarySystemGroupedBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(
              color: CupertinoColors.separator.withOpacity(0.5),
              width: 0.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      fruit.name,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: CupertinoColors.label,
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      fruit.family,
                      style: const TextStyle(
                        fontSize: 14,
                        color: CupertinoColors.secondaryLabel,
                        decoration: TextDecoration.none,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              if (onFavourites != null)
                CupertinoButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: () => onFavourites!(context),
                  child: Icon(
                    fruit.isFavourite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                    color: fruit.isFavourite
                        ? CupertinoColors.systemYellow
                        : CupertinoColors.systemGrey,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}