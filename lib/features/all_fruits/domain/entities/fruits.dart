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

  Fruits copyWith({
    String? name,
    String? family,
    int? id,
    String? order,
    String? genus,
    int? calories,
    double? fat,
    double? sugar,
    double? carbohydrates,
    double? protein,
    bool? isFavourite,
  }) {
    return Fruits(
      name: name ?? this.name,
      family: family ?? this.family,
      id: id ?? this.id,
      order: order ?? this.order,
      genus: genus ?? this.genus,
      calories: calories ?? this.calories,
      fat: fat ?? this.fat,
      sugar: sugar ?? this.sugar,
      carbohydrates: carbohydrates ?? this.carbohydrates,
      protein: protein ?? this.protein,
      isFavourite: isFavourite ?? this.isFavourite,
    );
  }
}
