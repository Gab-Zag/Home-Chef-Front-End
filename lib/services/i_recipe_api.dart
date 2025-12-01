import '../models/recipe.dart';

abstract class IRecipeApi {
  Future<Recipe> getRecipeDetails(String id);
}
