import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/recipes/domain/usecases/add_recipe.dart';
import 'package:nutrition_tech/features/recipes/domain/usecases/delete_recipe.dart';
import 'package:nutrition_tech/features/recipes/domain/usecases/get_recipes.dart';
import 'package:nutrition_tech/features/recipes/presentation/bloc/recipes_event.dart';
import 'package:nutrition_tech/features/recipes/presentation/bloc/recipes_state.dart';

@injectable
class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final GetRecipes getRecipes;
  final AddRecipe addRecipe;
  final DeleteRecipe deleteRecipe;

  RecipesBloc({
    required this.getRecipes,
    required this.addRecipe,
    required this.deleteRecipe,
  }) : super(RecipesInitial()) {
    on<LoadRecipes>(_onLoadRecipes);
    on<AddRecipeEvent>(_onAddRecipe);
    on<DeleteRecipeEvent>(_onDeleteRecipe);
  }

  Future<void> _onLoadRecipes(LoadRecipes event, Emitter<RecipesState> emit) async {
    emit(RecipesLoading());
    try {
      final recipes = await getRecipes();
      emit(RecipesLoaded(recipes));
    } catch (e) {
      emit(RecipesError(e.toString()));
    }
  }

  Future<void> _onAddRecipe(AddRecipeEvent event, Emitter<RecipesState> emit) async {
    try {
      await addRecipe(event.recipe);
      add(LoadRecipes());
    } catch (e) {
      emit(RecipesError(e.toString()));
    }
  }

  Future<void> _onDeleteRecipe(DeleteRecipeEvent event, Emitter<RecipesState> emit) async {
    await deleteRecipe(event.recipeId);
    add(LoadRecipes());
  }
}