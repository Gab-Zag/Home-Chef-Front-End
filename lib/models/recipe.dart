class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String image;
  final String ingredients;
  final String measures;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
    required this.ingredients,
    required this.measures,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? 'Unknown',
      area: json['area'] ?? 'Unknown',
      instructions: json['instructions'] ?? 'Sem instruções disponíveis',
      image: json['image'] ?? '',
      ingredients: json['ingredients'] ?? '',
      measures: json['measures']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "category": category,
      "area": area,
      "instructions": instructions,
      "image": image,
      "ingredients": ingredients,
      "measures": measures,
    };
  }
}
