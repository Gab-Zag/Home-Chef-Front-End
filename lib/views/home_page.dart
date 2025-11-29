import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_services.dart';

class HomePage extends StatefulWidget {
  final ApiService api;

  const HomePage({super.key, required this.api});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Recipe> recipes = [];
  String errorMessage = "";

  final TextEditingController controller = TextEditingController();

  Future<void> search() async {
    setState(() {
      errorMessage = ""; // reseta erro
    });

    try {
      final data = await widget.api.searchRecipes(controller.text);
      setState(() {
        recipes = data;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Erro ao buscar receitas"; // AQUI!
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TextField(controller: controller),
          IconButton(icon: const Icon(Icons.search), onPressed: search),

          if (errorMessage.isNotEmpty)
            Text(errorMessage, style: const TextStyle(color: Colors.red)),

          Expanded(
            child: ListView(
              children: recipes.map((r) => Text(r.name)).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
