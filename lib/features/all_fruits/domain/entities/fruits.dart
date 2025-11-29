class Fruits {
  final String name;
  final String family;
  final int id;
  final String order;
  final String genus;
  final int calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;
  final bool isFavourite;

  Fruits({
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
    this.isFavourite = false,
  });
}
