import '../models/recipe.dart';

abstract class IRecipeApi {
  Future<List<Recipe>> searchRecipes(String ingredients);
  Future<Recipe> getRecipeDetails(String id);
}
