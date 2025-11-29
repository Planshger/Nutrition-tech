import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:nutrition_tech/features/all_fruits/data/models/fruits_model.dart';

abstract class FruitsLocalDataSource {
  Future<List<FruitsModel>> getFruits();
  Future<void> cacheFruits(List<FruitsModel> fruits);
  Future<FruitsModel?> getFruitDetails(int fruitId);
  Future<void> toggleFavourite(int fruitId);
  Future<List<int>> getFavouriteIds();
}

@LazySingleton(as: FruitsLocalDataSource)
class FruitsLocalDataSourceImpl implements FruitsLocalDataSource {
  final Box<FruitsModel> _fruitsBox;
  final Box<int> _favouritesBox;

  FruitsLocalDataSourceImpl(this._fruitsBox, this._favouritesBox);

  @override
  Future<void> cacheFruits(List<FruitsModel> fruits) async {
    await _fruitsBox.clear();
    await _fruitsBox.addAll(fruits);
  }

  @override
  Future<List<FruitsModel>> getFruits() async {
    return _fruitsBox.values.toList();
  }

  @override
  Future<FruitsModel?> getFruitDetails(int fruitId) async {
    try {
      return _fruitsBox.values.firstWhere((fruit) => fruit.id == fruitId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<int>> getFavouriteIds() async {
    return _favouritesBox.values.toList();
  }

  @override
  Future<void> toggleFavourite(int fruitId) async {
    if (_favouritesBox.values.contains(fruitId)) {
      final key = _favouritesBox.keys.firstWhere((k) => _favouritesBox.get(k) == fruitId, orElse: () => null);
      if (key != null) {
        await _favouritesBox.delete(key);
      }
    } else {
      await _favouritesBox.add(fruitId);
    }
  }
}