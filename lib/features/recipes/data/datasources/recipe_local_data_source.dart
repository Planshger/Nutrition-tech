
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';

abstract class RecipeLocalDataSource {
  Future<List<RecipeModel>> getRecipes();
  Future<void> addRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(String recipeId);
}

@LazySingleton(as: RecipeLocalDataSource)
class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box<RecipeModel> _recipesBox;

  RecipeLocalDataSourceImpl(this._recipesBox);

  @override
  Future<void> addRecipe(RecipeModel recipe) async {
    await _recipesBox.put(recipe.id, recipe);
  }

  @override
  Future<void> deleteRecipe(String recipeId) async {
    await _recipesBox.delete(recipeId);
  }

  @override
  Future<List<RecipeModel>> getRecipes() async {
    return _recipesBox.values.toList();
  }
}