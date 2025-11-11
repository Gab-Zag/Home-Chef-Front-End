import 'package:flutter/material.dart';
import 'package:home_chef_front_end/services/api_services.dart';

import '../models/recipe.dart';

class RecipeDetails extends StatefulWidget {
  final String id;
  const RecipeDetails({super.key, required this.id});

  @override
  State<RecipeDetails> createState() => _RecipeDetailsState();
}

class _RecipeDetailsState extends State<RecipeDetails> {
  final _api = ApiService();
  Recipe? recipe;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() async {
    try {
      recipe = await _api.getRecipeDetails(widget.id);
    } catch (e) {
      debugPrint(e.toString());
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe?.name ?? 'Caregando...')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : recipe == null
          ? const Center(child: Text('Erro ao carregar receita'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(recipe!.image),
                  const SizedBox(height: 12),
                  Text(
                    '${recipe!.image} • ${recipe!.area}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(recipe!.instructions),
                ],
              ),
            ),
    );
  }
}
