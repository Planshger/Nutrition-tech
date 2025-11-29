import 'package:nutrition_tech/features/recipes/domain/entities/recipe.dart';

abstract class RecipesState {}

class RecipesInitial extends RecipesState {}

class RecipesLoading extends RecipesState {}

class RecipesLoaded extends RecipesState {
  final List<Recipe> recipes;
  RecipesLoaded(this.recipes);
}

class RecipesError extends RecipesState {
  final String message;
  RecipesError(this.message);
}