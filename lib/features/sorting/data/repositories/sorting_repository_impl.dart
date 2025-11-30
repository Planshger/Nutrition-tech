import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/filter_definition.dart';
import 'package:nutrition_tech/features/sorting/domain/entities/sort.dart';
import 'package:nutrition_tech/features/sorting/domain/repositories/sorting_repository.dart';

@Injectable(as: SortingRepository)
class SortingRepositoryImpl implements SortingRepository {

  @override
  List<Fruits> applySortingAndFilters({required List<Fruits> fruits, required Sort sortType, required List<Filter> filterTypes}) {
    List<Fruits> filteredFruits = fruits.where((fruit) {
      if (filterTypes.isEmpty) return true;
      
      return filterTypes.every((filterType) {
        final filterDefinition = _filterDefinitions[filterType];
        if (filterDefinition != null) {
          return _matchesFilter(fruit, filterDefinition.criteria);
        }
        return false;
      });
    }).toList();

    return _applySorting(filteredFruits, sortType);
  }

  bool _matchesFilter(Fruits fruit, Map<String, dynamic> criteria) {
    if (criteria['calories'] != null) {
      final caloriesFilter = criteria['calories'] as Map<String, dynamic>;
      if (caloriesFilter['min'] != null && fruit.calories < caloriesFilter['min']) {
        return false;
      }
      if (caloriesFilter['max'] != null && fruit.calories > caloriesFilter['max']) {
        return false;
      }
    }
    
    if (criteria['carbohydrates'] != null) {
      final carbsFilter = criteria['carbohydrates'] as Map<String, dynamic>;
      if (carbsFilter['min'] != null && fruit.carbohydrates < carbsFilter['min']) {
        return false;
      }
      if (carbsFilter['max'] != null && fruit.carbohydrates > carbsFilter['max']) {
        return false;
      }
    }
    
    if (criteria['sugar'] != null) {
      final sugarFilter = criteria['sugar'] as Map<String, dynamic>;
      if (sugarFilter['max'] != null && fruit.sugar > sugarFilter['max']) {
        return false;
      }
    }

    if (criteria['protein'] != null) {
      final proteinFilter = criteria['protein'] as Map<String, dynamic>;
      if (proteinFilter['min'] != null && fruit.protein < proteinFilter['min']) {
        return false;
      }
    }

    if (criteria['fat'] != null) {
      final fatFilter = criteria['fat'] as Map<String, dynamic>;
      if (fatFilter['max'] != null && fruit.fat > fatFilter['max']) {
        return false;
      }
    }
    
    return true;
  }

  List<Fruits> _applySorting(List<Fruits> fruits, Sort sortType) {
    final sortedFruits = List<Fruits>.from(fruits);
    
    sortedFruits.sort((a, b) {
      switch (sortType) {
        case Sort.nameAsc:
          return a.name.compareTo(b.name);
        case Sort.nameDesc:
          return b.name.compareTo(a.name);
        case Sort.caloriesAsc:
          return a.calories.compareTo(b.calories);
        case Sort.caloriesDesc:
          return b.calories.compareTo(a.calories);
      }
    });

    return sortedFruits;
  }

  @override
  Map<Filter, FilterDefinition> getFilterDefinitions() {
    return _filterDefinitions;
  }

  final Map<Filter, FilterDefinition> _filterDefinitions = {
    Filter.breakfast: FilterDefinition(
      name: 'Завтрак',
      criteria: {
        'calories': {'min': 40, 'max': 80},
        'carbohydrates': {'min': 10},
        'sugar': {'max': 12},
        'fat': {'max': 0.5},
      },
    ),
    Filter.workout: FilterDefinition(
      name: 'Тренировка',
      criteria: {
        'calories': {'min': 50, 'max': 100},
        'carbohydrates': {'min': 12},
        'fat': {'max': 0.3},
      },
    ),
    Filter.fullness: FilterDefinition(
      name: 'Сытость',
      criteria: {
        'calories': {'min': 50, 'max': 90},
        'carbohydrates': {'min': 10, 'max': 15},
        'sugar': {'max': 10},
        'protein': {'min': 0.5},
      },
    ),
    Filter.snack: FilterDefinition(
      name: 'Перекус',
      criteria: {
        'calories': {'max': 50},
        'sugar': {'max': 7},
        'fat': {'max': 0.4},
      },
    ),
    Filter.diet: FilterDefinition(
      name: 'Диета',
      criteria: {
        'calories': {'max': 40},
        'sugar': {'max': 6},
        'fat': {'max': 0.3},
      },
    ),
  };
}