import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';

abstract class FruitsState {}

class FruitsInitial extends FruitsState {}

class FruitsLoading extends FruitsState {}

class FruitsLoaded extends FruitsState {
  final List<Fruits> fruits;
  
  FruitsLoaded(this.fruits);
}

class FruitDetailsLoaded extends FruitsState {
  final Fruits fruit;
  FruitDetailsLoaded(this.fruit);
}

class FruitsError extends FruitsState {
  final String message;
  FruitsError(this.message);
}
