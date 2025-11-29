import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';
import 'i_recipe_api.dart';

class ApiService implements IRecipeApi {
  static const String baseUrl = 'http://localhost:9090/recipes';

  @override
  Future<List<Recipe>> searchRecipes(String ingredients) async {
    final url = Uri.parse('$baseUrl/search?ingredients=$ingredients');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar receitas (${response.statusCode})');
    }
  }

  @override
  Future<Recipe> getRecipeDetails(String id) async {
    final url = Uri.parse('$baseUrl/details?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Recipe.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar detalhes (${response.statusCode})');
    }
  }

  @override
  Future<List<Recipe>> getAllRecipes() async {
    final url = Uri.parse('$baseUrl/all');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception("Erro ao carregar receitas iniciais");
    }
  }
}
