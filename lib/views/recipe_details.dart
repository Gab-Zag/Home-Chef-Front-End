import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:home_chef_front_end/components/icon_text.dart';
import 'package:home_chef_front_end/components/step_itens.dart';
import 'package:home_chef_front_end/services/api_services.dart';
import 'package:home_chef_front_end/theme.dart';
import '../models/recipe.dart';

class RecipeDetails extends StatefulWidget {
  final String id;
  final String title;
  final String image;

  const RecipeDetails({
    super.key,
    required this.id,
    required this.title,
    required this.image,
  });

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
      debugPrint("ERRO: $e");
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.background,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.orange),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          recipe?.name ?? 'Carregando...',
          style: const TextStyle(color: AppTheme.orange),
        ),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(color: AppTheme.orange),
            )
          : recipe == null
          ? const Center(child: Text('Erro ao carregar receita'))
          : SafeArea(
              child: Column(
                children: [
                  Hero(
                    tag: widget.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(
                        recipe!.image,
                        height: 260,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Gap(16),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: AppTheme.orange,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.restaurant_menu,
                                color: AppTheme.yellow,
                              ),
                              Gap(8),
                              Text(
                                recipe!.name,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Gap(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconText(
                                icon: Icons.flag,
                                text: recipe!.category,
                              ),
                              IconText(
                                icon: Icons.location_on,
                                text: recipe!.area,
                              ),
                            ],
                          ),
                          Gap(25),
                          const Text(
                            "Modo de Preparo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(10),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: buildInstructions(
                                  recipe!.instructions,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
