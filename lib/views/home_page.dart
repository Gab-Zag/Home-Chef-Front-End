import 'dart:async';

import 'package:flutter/material.dart';
import 'package:home_chef_front_end/components/search_bar.dart';
import 'package:home_chef_front_end/theme.dart';
import 'package:home_chef_front_end/views/recipe_details.dart';
import 'package:home_chef_front_end/widgets/recipe_card.dart';
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
  bool loading = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    fetchInitialRecipes();
  }

  Future<void> fetchInitialRecipes() async {
    setState(() => loading = true);

    try {
      final data = await widget.api.getAllRecipes();
      setState(() {
        recipes = data;
        loading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = "Erro todas as carregar receitas.";
        loading = false;
      });
    }
  }

  final TextEditingController controller = TextEditingController();
  Future<void> search(String q) async {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (q.isEmpty) {
        await fetchInitialRecipes();
        return;
      }

      setState(() {
        loading = true;
        errorMessage = "";
      });

      try {
        final data = await widget.api.searchRecipes(q);
        setState(() {
          recipes = data;
        });
      } catch (e) {
        setState(() {
          errorMessage = "Erro ao buscar receitas.";
        });
      }

      setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              SearchBarWidget(
                onChanged: (value) {
                  search(value.trim());
                },
              ),
              const SizedBox(height: 25),
              Expanded(
                child: loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(AppTheme.orange),
                        ),
                      )
                    : errorMessage.isNotEmpty
                    ? Center(
                        child: Text(
                          errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                          ),
                        ),
                      )
                    : GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 6,
                              childAspectRatio: 0.8,
                            ),
                        itemCount: recipes.length,
                        itemBuilder: (_, index) {
                          final r = recipes[index];
                          return RecipeCard(
                            recipe: r,
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled:
                                    true, // permite altura maior
                                backgroundColor: Colors.transparent,
                                builder: (_) {
                                  return DraggableScrollableSheet(
                                    initialChildSize: 0.92, // tamanho inicial
                                    minChildSize: 0.5,
                                    maxChildSize: 1,
                                    expand: false,
                                    builder: (context, scrollController) {
                                      return ClipRRect(
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(25),
                                            ),
                                        child: Container(
                                          color: AppTheme.background,
                                          child: RecipeDetails(
                                            id: r.id,
                                            title: '',
                                            image: '',
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        selectedItemColor: AppTheme.orange,
        unselectedItemColor: AppTheme.placeholder,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorites",
          ),
        ],
      ),
    );
  }
}
