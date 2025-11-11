import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:8080/recipes';

  Future<List<Recipe>> searchRecipes(String ingredients) async {
    final url = Uri.parse('$baseUrl/search?ingredients=$ingredients');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((e) => Recipe.fromJson(e)).toList();
    } else {
      throw Exception('Erro ao buscar receitas: ${response.statusCode}');
    }
  }

  Future<Recipe> getRecipeDetails(String id) async {
    final url = Uri.parse('$baseUrl/details?id=$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      return Recipe.fromJson(jsonData);
    } else {
      throw Exception('Erro ao buscar detalhes da receita: ${response.statusCode}');
    }
  }
}
