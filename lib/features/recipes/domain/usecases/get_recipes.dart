import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/recipes/domain/entities/recipe.dart';
import 'package:nutrition_tech/features/recipes/domain/repositories/recipe_repository.dart';

@injectable
class GetRecipes {
  final RecipeRepository repository;
  GetRecipes(this.repository);
  Future<List<Recipe>> call() => repository.getRecipes();
}