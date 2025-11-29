import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:nutrition_tech/features/all_fruits/domain/entities/fruits.dart';

part 'fruits_model.g.dart';

@HiveType(typeId: 0)
class FruitsModel {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String family;
  @HiveField(2)
  final int id;
  @HiveField(3)
  final String order;
  @HiveField(4)
  final String genus;
  @HiveField(5)
  final int calories;
  @HiveField(6)
  final double fat;
  @HiveField(7)
  final double sugar;
  @HiveField(8)
  final double carbohydrates;
  @HiveField(9)
  final double protein;

  FruitsModel({
    required this.name,
    required this.family,
    required this.id,
    required this.order,
    required this.genus,
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  factory FruitsModel.fromJson(Map<String, dynamic> json) {
    return FruitsModel(
      name: json['name'] ?? '',
      family: json['family'] ?? '',
      id: json['id'] ?? 0,
      order: json['order'] ?? '',
      genus: json['genus'] ?? '',

      calories: (json['nutritions']['calories'] as num?)?.toInt() ?? 0,
      fat: (json['nutritions']['fat'] as num?)?.toDouble() ?? 0.0,
      sugar: (json['nutritions']['sugar'] as num?)?.toDouble() ?? 0.0,
      carbohydrates:
          (json['nutritions']['carbohydrates'] as num?)?.toDouble() ?? 0.0,
      protein: (json['nutritions']['protein'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Fruits toEntity({bool isFavourite = false}) {
    return Fruits(
      name: name,
      family: family,
      id: id,
      order: order,
      genus: genus,
      calories: calories,
      fat: fat,
      sugar: sugar,
      carbohydrates: carbohydrates,
      protein: protein,
      isFavourite: isFavourite,
    );
  }
}
