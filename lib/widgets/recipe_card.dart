import 'package:flutter/material.dart';

import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback onTap;

  const RecipeCard({super.key, required this.recipe, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(recipe.image, width: 60, fit: BoxFit.cover),
        title: Text(recipe.name),
        subtitle: Text(recipe.category),
        onTap: onTap,
      ),
    );
  }
}
