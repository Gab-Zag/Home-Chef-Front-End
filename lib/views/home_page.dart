import 'package:flutter/material.dart';
import 'package:home_chef_front_end/componentes/search_bar.dart';
import 'package:home_chef_front_end/theme.dart';
import 'package:home_chef_front_end/views/favorites_page.dart';
import 'package:home_chef_front_end/views/find.dart';
import 'package:home_chef_front_end/views/recipe_details.dart';
import 'package:home_chef_front_end/widgets/recipe_card.dart';

import '../models/recipe.dart';
import '../services/api_services.dart';

class HomeDashboard extends StatefulWidget {
  final ApiService api;

  const HomeDashboard({super.key, required this.api});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  int selectedTab = 0;
  List<Recipe> recipes = [];
  bool loading = false;
  String errorMessage = "";

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
        errorMessage = "Erro ao carregar receitas.";
        loading = false;
      });
    }
  }

  Future<void> search(String q) async {
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

              // HEADER ---------------------------------------------------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Home Chef",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textColor,
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => FavoritesPage()),
                      );
                    },
                    child: Icon(Icons.favorite, color: AppTheme.orange, size: 28),
                  )
                ],
              ),

              const SizedBox(height: 20),

              // SEARCH BAR ----------------------------------------------
              SearchBarWidget(
                onChanged: (value) => search(value),
              ),

              const SizedBox(height: 25),

              // ABAS -----------------------------------------------------
              Row(
                children: [
                  GestureDetector(
                    onTap: () => setState(() => selectedTab = 0),
                    child: Column(
                      children: [
                        Text(
                          "Favoritos",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 0
                                ? AppTheme.orange
                                : AppTheme.textColor,
                          ),
                        ),
                        if (selectedTab == 0)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 3,
                            width: 60,
                            color: AppTheme.orange,
                          )
                      ],
                    ),
                  ),

                  const SizedBox(width: 25),

                  GestureDetector(
                    onTap: () => setState(() => selectedTab = 1),
                    child: Column(
                      children: [
                        Text(
                          "Histórico",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: selectedTab == 1
                                ? AppTheme.orange
                                : AppTheme.textColor,
                          ),
                        ),
                        if (selectedTab == 1)
                          Container(
                            margin: const EdgeInsets.only(top: 4),
                            height: 3,
                            width: 60,
                            color: AppTheme.orange,
                          )
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // LISTA DE RECEITAS -----------------------------------------
              Expanded(
                child: loading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage.isNotEmpty
                        ? Center(
                            child: Text(
                              errorMessage,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 16),
                            ),
                          )
                        : GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 0.78, // deixa bonito
                            ),
                            itemCount: recipes.length,
                            itemBuilder: (_, index) {
                              final r = recipes[index];
                              return RecipeCard(
                                recipe: r,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => RecipeDetailsPage(
                                        id: r.id,
                                        title: r.name,
                                        image: r.image,
                                      ),
                                    ),
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

      // MENU INFERIOR ---------------------------------------------------
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppTheme.background,
        elevation: 0,
        selectedItemColor: AppTheme.orange,
        unselectedItemColor: AppTheme.placeholder,
        currentIndex: 0,
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const IngredientSearchPage()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Receitas"),
        ],
      ),
    );
  }
}
