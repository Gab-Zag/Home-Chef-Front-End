class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String image;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      category: json['category'] ?? 'Unknown',
      area: json['area'] ?? 'Unknown',
      instructions: json['instructions'] ?? 'Sem instruções disponíveis',
      image: json['image'] ?? '',
    );
  }
}
