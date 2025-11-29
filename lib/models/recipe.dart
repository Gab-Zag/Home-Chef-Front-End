class Recipe {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String image;

  final List<String> steps;

  Recipe({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
    required this.steps,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    final rawInstructions = json['instructions'] ?? "";

    final steps = rawInstructions.isEmpty
        ? <String>[]
        : rawInstructions
              .split(RegExp(r'\r?\n'))
              .map((s) => s.trim())
              .where((s) => s.isNotEmpty)
              .toList();

    return Recipe(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      category: json['category'] ?? "",
      area: json['area'] ?? "",
      instructions: rawInstructions,
      image: json['image'] ?? "",
      steps: steps,
    );
  }
}
