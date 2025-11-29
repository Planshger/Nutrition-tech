import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';

abstract class FruitsRepository {
  Future<List<Fruits>> getFruits();
  Future<Fruits?> getDetails(int fruitId);
  Future<void> addFavourites(int fruitId);
}
