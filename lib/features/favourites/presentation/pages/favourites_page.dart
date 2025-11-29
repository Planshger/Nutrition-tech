import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/core/di/widgets/nav_details_page.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';
import 'package:nutrition_tech/features/favourites/presentation/widgets/favourites_tile.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Избранное'),
      ),
      child: BlocBuilder<FruitsBloc, FruitsState>(
        builder: (context, state) {
          if (state is FruitsLoading) {
            return const Center(child: CupertinoActivityIndicator());
          }

          if (state is FruitsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Произошла ошибка'),
                  const SizedBox(height: 10),
                  CupertinoButton.filled(
                    child: const Text('Перезагрузить'),
                    onPressed: () {
                      context.read<FruitsBloc>().add(LoadFruits());
                    },
                  )
                ],
              ),
            );
          }

          if (state is FruitsLoaded) {
            final favouriteFruits =
                state.fruits.where((fruit) => fruit.isFavourite).toList();

            if (favouriteFruits.isEmpty) {
              return const Center(
                child: Text('Вы пока ничего не добавили в избранное'),
              );
            }

            return ListView.builder(
              itemCount: favouriteFruits.length,
              itemBuilder: (context, index) {
                final fruit = favouriteFruits[index];
                return FavouritesTile(
                  title: Text(fruit.name),
                  onTap: () => navigateDetailsPage(context, fruit),
                  trailing: CupertinoButton(
                    padding: EdgeInsets.zero,
                    child: const Icon(
                      CupertinoIcons.delete,
                      color: CupertinoColors.systemRed,
                    ),
                    onPressed: () {
                      context
                          .read<FruitsBloc>()
                          .add(AddFavouritesEvent(fruit.id));
                    },
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}