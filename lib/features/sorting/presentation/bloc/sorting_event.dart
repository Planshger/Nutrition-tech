import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';

abstract class SortingEvent {}

class LoadSortingOptions extends SortingEvent {
  final Sort currentSort;
  final List<Filter> currentFilters;

  LoadSortingOptions({required this.currentSort, required this.currentFilters});
}

class UpdateSortType extends SortingEvent {
  final Sort sortType;

  UpdateSortType(this.sortType);
}

class ToggleFilter extends SortingEvent {
  final Filter filterType;

  ToggleFilter(this.filterType);
}

class ApplySortingAndFilters extends SortingEvent {
  final List<Fruits> fruits;

  ApplySortingAndFilters(this.fruits);
}