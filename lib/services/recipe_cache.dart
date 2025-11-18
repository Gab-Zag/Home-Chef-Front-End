import 'package:hive/hive.dart';

class RecipeCache {
  final Box _box = Hive.box('cacheRecipes');

  Future<void> saveRecipes(String key, List<Map<String, dynamic>> recipes) async {
    await _box.put(key, recipes);
  }

  List<Map<String,dynamic>>? getRecipes(String key) {
    final raw = _box.get(key);
    if (raw == null) return null;
    return List<Map<String,dynamic>>.from(raw);
  }

  Future<void> clear() => _box.clear();
}
