import 'package:flutter/cupertino.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/pages/fruits_page.dart';
import 'package:nutrition_tech/features/favourites/presentation/pages/favourites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: CupertinoColors.systemBlue,
        inactiveColor: CupertinoColors.systemGrey,
        items: const [
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.list_bullet), label: 'Фрукты'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.star), activeIcon: Icon(CupertinoIcons.star_fill, color: CupertinoColors.systemYellow),label: 'Избранное'),
          BottomNavigationBarItem(icon: Icon(CupertinoIcons.book_solid), label: 'Рецепты'),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return Builder(
              builder: (context) {
                return const FruitsPage();
              },
            );
          case 1:
            return Builder(
              builder: (context) {
                return const FavouritesPage();
              },
            );
          default:
            return Container();
        }
      },
    );
  }

}