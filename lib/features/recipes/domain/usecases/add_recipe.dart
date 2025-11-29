import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';
import 'package:nutrition_tech/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class AddRecipe {
  final RecipeRepository repository;
  AddRecipe(this.repository);
  Future<void> call(RecipeModel recipe) => repository.addRecipe(recipe);
}