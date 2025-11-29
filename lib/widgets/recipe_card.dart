import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../theme.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onTap;

  const RecipeCard({
    super.key,
    required this.recipe,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.network(
                recipe.image,
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (c, e, s) => Container(
                  height: 120,
                  color: Colors.grey[300],
                  child: Icon(Icons.broken_image),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                recipe.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: AppTheme.textColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
