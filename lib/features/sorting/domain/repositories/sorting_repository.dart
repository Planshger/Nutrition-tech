import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter_definition.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';

abstract class SortingRepository {
  List<Fruits> applySortingAndFilters({
    required List<Fruits> fruits,
    required Sort sortType,
    required List<Filter> filterTypes,
  });
  
  Map<Filter, FilterDefinition> getFilterDefinitions();
}