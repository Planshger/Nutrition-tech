import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';

class Recipe {
  final String id;
  final String title;
  final String description;
  final List<Fruits> fruits;

  const Recipe(
      {required this.id,
      required this.title,
      required this.description,
      required this.fruits});
}