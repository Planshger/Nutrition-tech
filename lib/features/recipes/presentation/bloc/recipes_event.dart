import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';

abstract class RecipesEvent {}

class LoadRecipes extends RecipesEvent {}

class AddRecipeEvent extends RecipesEvent {
  final RecipeModel recipe;
  AddRecipeEvent({required this.recipe});
}

class DeleteRecipeEvent extends RecipesEvent {
  final String recipeId;
  DeleteRecipeEvent({required this.recipeId});
}