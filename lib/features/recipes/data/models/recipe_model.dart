import 'package:hive_ce_flutter/hive_flutter.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 1)
class RecipeModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<int> fruitIds;

  RecipeModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.fruitIds});
}