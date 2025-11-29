import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class DeleteRecipe {
  final RecipeRepository repository;
  DeleteRecipe(this.repository);
  Future<void> call(String recipeId) => repository.deleteRecipe(recipeId);
}