import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/widgets/details_header.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/widgets/details_row.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/widgets/details_subtitle.dart';

class DetailsPage extends StatelessWidget {
  final Fruits fruit;

  const DetailsPage({super.key, required this.fruit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FruitsBloc, FruitsState>(
      builder: (context, state) {
        final currentFruit = (state is FruitsLoaded)
            ? state.fruits.firstWhere((f) => f.id == fruit.id, orElse: () => fruit)
            : fruit;

        return CupertinoPageScaffold(
          backgroundColor: CupertinoColors.systemGroupedBackground,
          navigationBar: CupertinoNavigationBar(
            middle: Text(currentFruit.name),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                context.read<FruitsBloc>().add(AddFavouritesEvent(currentFruit.id));
              },
              child: Icon(
                currentFruit.isFavourite ? CupertinoIcons.star_fill : CupertinoIcons.star,
                color: currentFruit.isFavourite
                    ? CupertinoColors.systemYellow
                    : CupertinoColors.systemGrey,
              ),
            ),
          ),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              detailsHeader('Вся информация о фрукте:'),
              Container(
                color: CupertinoColors.secondarySystemGroupedBackground,
                child: Column(
                  children: [
                    detailsRow('Family', currentFruit.family),
                    detailsRow('Order', currentFruit.order),
                    detailsRow('Genus', currentFruit.genus),
                  ],
                ),
              ),
              detailsSubtitle('Питательные свойства:'),
              Container(
                color: CupertinoColors.secondarySystemGroupedBackground,
                child: Column(
                  children: [
                    detailsRow('Calories', '${currentFruit.calories} kcal'),
                    detailsRow('Fat', '${currentFruit.fat} g'),
                    detailsRow('Sugar', '${currentFruit.sugar} g'),
                    detailsRow('Carbohydrates', '${currentFruit.carbohydrates} g'),
                    detailsRow('Protein', '${currentFruit.protein} g'),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
  
