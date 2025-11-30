import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/core/widgets/nav_details_page.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';
import 'package:nutrition_tech/core/widgets/error_display.dart';
import 'package:nutrition_tech/features/favourites/presentation/widgets/favourites_tile.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocBuilder<FruitsBloc, FruitsState>(
        builder: (context, state) {
          if (state is FruitsLoading) {
            return const CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(middle: Text('Избранное')),
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          if (state is FruitsError) {
            return CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(middle: Text('Избранное')),
              child: ErrorDisplay(message: 'Не удалось загрузить избранное',
                onRetry: () => context.read<FruitsBloc>().add(LoadFruits()),
              ),
            );
          }

          if (state is FruitsLoaded) {
            final favouriteFruits =
                state.fruits.where((fruit) => fruit.isFavourite).toList();

            return CustomScrollView(
              slivers: [
                const CupertinoSliverNavigationBar(
                  largeTitle: Text('Избранное'),
                ),
                if (favouriteFruits.isEmpty)
                  const SliverFillRemaining(
                    hasScrollBody: false,
                    child: Center(child: Text('Вы пока ничего не добавили в избранное')),
                  )
                else
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final fruit = favouriteFruits[index];
                        return FavouritesTile(
                          title: Text(fruit.name),
                          onTap: () => navigateDetailsPage(context, fruit),
                          trailing: CupertinoButton(
                            padding: EdgeInsets.zero,
                            child: const Icon(CupertinoIcons.delete, color: CupertinoColors.systemRed),
                            onPressed: () => context.read<FruitsBloc>().add(AddFavouritesEvent(fruit.id)),
                          ),
                        );
                      },
                      childCount: favouriteFruits.length,
                    ),
                  ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}