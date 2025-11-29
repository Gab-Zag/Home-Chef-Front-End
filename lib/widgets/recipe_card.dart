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
        leading: SizedBox(
          width: 60,
          height: 60,
          child: Image.network(
            recipe.image,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.fastfood),
          ),
        ),

        title: Text(recipe.name),
        subtitle: Text(recipe.category),
        onTap: onTap,
      ),
    );
  }
}
