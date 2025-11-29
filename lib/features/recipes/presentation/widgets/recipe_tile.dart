import 'package:flutter/cupertino.dart';
import 'package:nutrition_tech/features/recipes/domain/entities/recipe.dart';
import 'package:nutrition_tech/features/recipes/presentation/widgets/recipe_tile_row.dart';
import 'package:nutrition_tech/features/recipes/presentation/widgets/recipe_title.dart';

class RecipeTile extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onDelete;

  const RecipeTile({super.key, required this.recipe, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final ingredients = recipe.fruits.map((f) => f.name).join(', ');

    final totalCalories = recipe.fruits.fold(0.0, (sum, item) => sum + item.calories);
    final totalFat = recipe.fruits.fold(0.0, (sum, item) => sum + item.fat);
    final totalSugar = recipe.fruits.fold(0.0, (sum, item) => sum + item.sugar);
    final totalCarbs = recipe.fruits.fold(0.0, (sum, item) => sum + item.carbohydrates);
    final totalProtein = recipe.fruits.fold(0.0, (sum, item) => sum + item.protein);

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: CupertinoTheme.of(context).brightness == Brightness.light
                ? CupertinoColors.white
                : CupertinoColors.secondarySystemGroupedBackground,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: CupertinoColors.separator.withOpacity(0.5), width: 0.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      recipe.title,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, decoration: TextDecoration.none, color: CupertinoColors.label),
                    ),
                  ),
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: onDelete,
                    child: const Icon(CupertinoIcons.delete, color: CupertinoColors.systemRed),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(recipe.description, style: const TextStyle(fontSize: 15, decoration: TextDecoration.none, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 12),
              recipeTitle('Состав:'),
              Text(ingredients, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, decoration: TextDecoration.none, color: CupertinoColors.secondaryLabel)),
              const SizedBox(height: 12),
              recipeTitle('Питательные вещества (сумма):'),
              recipeTileRow('Калории:', '${totalCalories.toStringAsFixed(2)} kcal'),
              recipeTileRow('Жиры:', '${totalFat.toStringAsFixed(2)} г'),
              recipeTileRow('Сахар:', '${totalSugar.toStringAsFixed(2)} г'),
              recipeTileRow('Углеводы:', '${totalCarbs.toStringAsFixed(2)} г'),
              recipeTileRow('Белки:', '${totalProtein.toStringAsFixed(2)} г'),
            ],
          ),
        ),
      );
  }
}