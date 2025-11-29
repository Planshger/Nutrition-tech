import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';
import 'package:nutrition_tech/features/recipes/domain/entities/recipe.dart';

abstract class RecipeRepository {
  Future<List<Recipe>> getRecipes();
  Future<void> addRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(String recipeId);
}