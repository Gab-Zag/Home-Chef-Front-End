import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_services.dart';

class RecipeDetailsPage extends StatefulWidget {
  final String id;
  final String title;
  final String image;

  const RecipeDetailsPage({
    super.key,
    required this.id,
    required this.title,
    required this.image,
  });

  @override
  State<RecipeDetailsPage> createState() => _RecipeDetailsPageState();
}

class _RecipeDetailsPageState extends State<RecipeDetailsPage> {
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
      debugPrint("ERRO: $e");
    }
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1E),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF7A3CFF),
        onPressed: () {},
        child: const Icon(Icons.favorite_border, color: Colors.white),
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator(color: Colors.white))
          : recipe == null
              ? const Center(
                  child: Text(
                    "Erro ao carregar receita",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              : SafeArea(
                  child: Column(
                    children: [
                      // --- Hero Image ---
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

                      const SizedBox(height: 20),

                      // --- Conteúdo Roxo ---
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            color: Color(0xFF3B1E47),
                            borderRadius:
                                BorderRadius.vertical(top: Radius.circular(30)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título
                              Text(
                                recipe!.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Infos rápidas
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconText(
                                    icon: Icons.category,
                                    text: recipe!.category,
                                  ),
                                  IconText(
                                    icon: Icons.flag,
                                    text: recipe!.area,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 25),

                              const Text(
                                "Modo de Preparo",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Lista de passos extraídos do "instructions"
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: recipe!.steps
                                        .asMap()
                                        .entries
                                        .map(
                                          (entry) => StepItem(
                                            number: entry.key + 1,
                                            text: entry.value,
                                          ),
                                        )
                                        .toList(),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              // Botão para modo cozinha
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF7A3CFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                  minimumSize:
                                      const Size(double.infinity, 55),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Iniciar Cozinha",
                                  style: TextStyle(fontSize: 18),
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

class StepItem extends StatelessWidget {
  final int number;
  final String text;

  const StepItem({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Bolinha do passo
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFC7B7FF),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: Color(0xFF3B1E47),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Texto do passo
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconText({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFC7B7FF)),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
