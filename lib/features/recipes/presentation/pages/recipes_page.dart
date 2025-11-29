import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/core/di/injector.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/core/widgets/error_display.dart';
import 'package:nutrition_tech/features/recipes/data/models/recipe_model.dart';
import 'package:nutrition_tech/features/recipes/presentation/bloc/recipes_bloc.dart';
import 'package:nutrition_tech/features/recipes/presentation/bloc/recipes_event.dart';
import 'package:nutrition_tech/features/recipes/presentation/bloc/recipes_state.dart';
import 'package:nutrition_tech/features/recipes/presentation/widgets/action_button.dart';
import 'package:nutrition_tech/features/recipes/presentation/widgets/recipe_dialog.dart';
import 'package:nutrition_tech/features/recipes/presentation/widgets/recipe_tile.dart';
import 'package:uuid/uuid.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  double _buttonOpacity = 1.0;
  Timer? _scrollEndTimer;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    if (!_scrollController.hasClients) return;
    _scrollEndTimer?.cancel();
    setState(() => _buttonOpacity = 0.2);
    _scrollEndTimer = Timer(const Duration(milliseconds: 90), () {
      if (mounted) setState(() => _buttonOpacity = 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: BlocProvider<RecipesBloc>(
        create: (context) {
          context.read<FruitsBloc>().add(LoadFruits()); 
          return injector<RecipesBloc>()..add(LoadRecipes());
        },
          child: BlocBuilder<RecipesBloc, RecipesState>(
            builder: (context, state) {
              if (state is RecipesError) {
                return ErrorDisplay(
                  message: state.message,
                  onRetry: () => context.read<RecipesBloc>().add(LoadRecipes()),
                );
              }

              if (state is! RecipesLoaded) {
                return const Center(child: CupertinoActivityIndicator());
              }

              return Stack(
              children: [
                CustomScrollView(
                  controller: _scrollController,
                  slivers: state.recipes.isEmpty ? [
                    const CupertinoSliverNavigationBar(largeTitle: Text('Рецепты'),),
                    const SliverFillRemaining(hasScrollBody: false, child: Center(child: Text('Создайте свой первый рецепт')))
                  ] : [ 
                    const CupertinoSliverNavigationBar(largeTitle: Text('Рецепты')),
                          SliverList(
                            delegate: SliverChildBuilderDelegate((context, index) {
                              final recipe = state.recipes[index];
                              return RecipeTile(
                                recipe: recipe,
                                onDelete: () => _deleteRecipe(context, recipe.id),
                              );
                            }, childCount: state.recipes.length),
                          ),
                          SliverPadding(padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.25)),
                        ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).padding.bottom * 1.7,
                  right: MediaQuery.of(context).padding.bottom * 0.6,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: _buttonOpacity,
                    child: ActionButton(icon: CupertinoIcons.add, onPressed: () => _createRecipe(context)),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _scrollEndTimer?.cancel();
    super.dispose();
  }

  void _createRecipe(BuildContext context) {
    final recipesBloc = context.read<RecipesBloc>();
    final fruitsBloc = context.read<FruitsBloc>();

    showCupertinoModalPopup(
      context: context,
      builder: (_) {
        return BlocProvider.value(
          value: fruitsBloc,
          child: RecipeDialog(
            onSave: (name, description, selectedFruits) {
              final newRecipe = RecipeModel(
                id: const Uuid().v4(),
                title: name,
                description: description,
                fruitIds: selectedFruits.map((f) => f.id).toList(),
              );
              recipesBloc.add(AddRecipeEvent(recipe: newRecipe));
              Navigator.of(context).pop();
            },
            onCancel: () => Navigator.of(context).pop(),
          ),
        );
      },
    );
  }

  void _deleteRecipe(BuildContext context, String recipeId) {
    context.read<RecipesBloc>().add(DeleteRecipeEvent(recipeId: recipeId));
  }
}
