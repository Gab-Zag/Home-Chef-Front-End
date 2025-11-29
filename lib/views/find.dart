import 'package:flutter/material.dart';

class IngredientSearchPage extends StatefulWidget {
  const IngredientSearchPage({super.key});

  @override
  State<IngredientSearchPage> createState() => _IngredientSearchPageState();
}

class _IngredientSearchPageState extends State<IngredientSearchPage> {
  final List<String> suggestions = [
    "Tomate", "Cebola", "Frango", "Alho", "Queijo", "Arroz", "Batata"
  ];

  final List<String> selected = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Buscar por Ingredientes",
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Color(0xFFC7B7FF)),
                  filled: true,
                  fillColor: Color(0xFF3B1E47),
                  hintText: "Digite um ingrediente...",
                  hintStyle: const TextStyle(color: Color(0xFF8A8A93)),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(18), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 30),
              const Text("Sugeridos",
                  style: TextStyle(color: Colors.white, fontSize: 18)),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: suggestions.map((i) {
                  final active = selected.contains(i);
                  return ChoiceChip(
                    label: Text(i),
                    selected: active,
                    onSelected: (_) {
                      setState(() {
                        active ? selected.remove(i) : selected.add(i);
                      });
                    },
                    selectedColor: Color(0xFF7A3CFF),
                    backgroundColor: Color(0xFF3B1E47),
                    labelStyle: const TextStyle(color: Colors.white),
                  );
                }).toList(),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7A3CFF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                  minimumSize: Size(double.infinity, 55),
                ),
                onPressed: () {},
                child: const Text("Encontrar Receitas"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
