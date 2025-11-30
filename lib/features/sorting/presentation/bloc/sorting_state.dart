
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter_definition.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';

abstract class SortingState {}

class SortingInitial extends SortingState {}

class SortingOptionsLoaded extends SortingState {
  final Sort selectedSort;
  final List<Filter> selectedFilters;
  final Map<Filter, FilterDefinition> filterDefinitions;

  SortingOptionsLoaded({required this.selectedSort, required this.selectedFilters, required this.filterDefinitions});

  SortingOptionsLoaded copyWith({Sort? selectedSort, List<Filter>? selectedFilters}) {
    return SortingOptionsLoaded(
      selectedSort: selectedSort ?? this.selectedSort,
      selectedFilters: selectedFilters ?? this.selectedFilters,
      filterDefinitions: filterDefinitions,
    );
  }
}

class SortingApplied extends SortingState {
  final List<Fruits> sortedFruits;
  final Sort appliedSort;
  final List<Filter> appliedFilters;

  SortingApplied({required this.sortedFruits, required this.appliedSort, required this.appliedFilters});
}

class SortingError extends SortingState {
  final String message;

  SortingError(this.message);
}