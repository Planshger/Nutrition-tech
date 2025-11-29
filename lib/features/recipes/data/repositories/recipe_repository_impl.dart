import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/domain/repositories/fruits_repository.dart';
import 'package:nutrition_tech/features/recipes/data/datasources/recipe_local_data_source.dart';
import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';
import 'package:nutrition_tech/features/recipes/domain/entities/recipe.dart';
import 'package:nutrition_tech/features/recipes/domain/repositories/recipe_repository.dart';

@Injectable(as: RecipeRepository)
class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;
  final FruitsRepository fruitsRepository;

  RecipeRepositoryImpl({required this.localDataSource, required this.fruitsRepository});

  @override
  Future<void> addRecipe(RecipeModel recipe) {
    return localDataSource.addRecipe(recipe);
  }

  @override
  Future<void> deleteRecipe(String recipeId) {
    return localDataSource.deleteRecipe(recipeId);
  }

  @override
  Future<List<Recipe>> getRecipes() async {
    final recipeModels = await localDataSource.getRecipes();
    final allFruits = await fruitsRepository.getFruits();

    return recipeModels.map((model) {
      final recipeFruits = allFruits.where((fruit) => model.fruitIds.contains(fruit.id)).toList();
      return Recipe(
        id: model.id,
        title: model.title,
        description: model.description,
        fruits: recipeFruits,
      );
    }).toList();
  }
}