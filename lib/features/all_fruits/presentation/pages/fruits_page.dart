import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrition_tech/core/widgets/error_display.dart';
import 'package:nutrition_tech/core/widgets/nav_details_page.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_bloc.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_event.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/bloc/fruits_state.dart';
import 'package:nutrition_tech/features/all_fruits/presentation/widgets/fruit_tile.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_bloc.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_event.dart';
import 'package:nutrition_tech/features/sorting/presentation/bloc/sorting_state.dart';
import 'package:nutrition_tech/features/sorting/presentation/pages/sorting_page.dart';

class FruitsPage extends StatefulWidget {
  const FruitsPage({super.key});

  @override
  State<FruitsPage> createState() => _FruitsPageState();
}

class _FruitsPageState extends State<FruitsPage> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  List<Fruits> _displayedFruits = [];
  Sort _currentSort = Sort.nameAsc;
  List<Filter> _activeFilters = [];

  @override
  void initState() {
    super.initState();
    context.read<FruitsBloc>().add(LoadFruits());
  }

  void _applyFilters(List<Fruits> sortedFruits, Sort sortType, List<Filter> activeFilters) {
    setState(() {_displayedFruits = sortedFruits; _currentSort = sortType;_activeFilters = activeFilters;});
  }

  void _navigateToSortingPage(List<Fruits> currentFruits) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => SortingPage(
          currentFruits: currentFruits,
          currentSort: _currentSort,
          currentFilters: _activeFilters,
          onApplyFilters: _applyFilters,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SortingBloc, SortingState>(
      listener: (context, sortingState) {
        if (sortingState is SortingApplied) {
          _applyFilters(sortingState.sortedFruits, sortingState.appliedSort, sortingState.appliedFilters);
        }
      },
      child: BlocConsumer<FruitsBloc, FruitsState>(
        listener: (context, fruitsState) {
          if (fruitsState is FruitsLoaded && (_displayedFruits.isNotEmpty || _activeFilters.isNotEmpty)) {
            final newFruits = fruitsState.fruits;
            final updatedDisplayedFruits = _displayedFruits.map((oldFruit) {
              final newFruit = newFruits.firstWhere((f) => f.id == oldFruit.id, orElse: () => oldFruit);
              return newFruit; 
            }).toList();

            setState(() {_displayedFruits = updatedDisplayedFruits;});

            context.read<SortingBloc>().add(ApplySortingAndFilters(newFruits));
          }
        },
        builder: (context, fruitsState) {
          if (fruitsState is FruitsError) {
            return CupertinoPageScaffold(
              navigationBar: const CupertinoNavigationBar(middle: Text('Фрукты')),
              child: ErrorDisplay(
                message: fruitsState.message,
                onRetry: () => context.read<FruitsBloc>().add(LoadFruits()),
              ),
            );
          }
          
          if (fruitsState is! FruitsLoaded) {
            return const CupertinoPageScaffold(
              child: Center(child: CupertinoActivityIndicator()),
            );
          }

          final fruitsToDisplay = _displayedFruits.isEmpty ? fruitsState.fruits : _displayedFruits;

          return CupertinoPageScaffold(
            child: CustomScrollView(
              controller: _scrollController,
              slivers: [
                CupertinoSliverNavigationBar(
                  largeTitle: const Text('Фрукты'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_activeFilters.isNotEmpty)
                        Badge(
                          label: Text(_activeFilters.length.toString()),
                          child: const Icon(CupertinoIcons.arrow_down),
                        ),
                      const SizedBox(width: 8),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _navigateToSortingPage(fruitsState.fruits),
                        child: const Icon(CupertinoIcons.arrow_up_arrow_down),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final fruit = fruitsToDisplay[index];
                      return FruitTile(
                        fruit: fruit,
                        onTap: () => navigateDetailsPage(context, fruit),
                        onFavourites: (ctx) => ctx.read<FruitsBloc>().add(
                              AddFavouritesEvent(fruit.id),
                            ),
                      );
                    },
                    childCount: fruitsToDisplay.length,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}