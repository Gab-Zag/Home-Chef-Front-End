import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:home_chef_front_end/models/recipe.dart';
import 'package:home_chef_front_end/services/api_services.dart';
import 'package:home_chef_front_end/views/home_page.dart';

class FakeApi extends Fake implements ApiService {
  @override
  Future<List<Recipe>> searchRecipes(String ingredients) async {
    return [
      Recipe(
        id: "1",
        name: "Pizza",
        area: "Italian",
        image: "https://via.placeholder.com/150",
        instructions: "Bake",
        category: 'Main Course',
        ingredients: '',
        measures: '',
      ),
    ];
  }
}


void main() {
  testWidgets('HomePage deve buscar receitas e atualizar a UI', (tester) async {
    final fakeApi = FakeApi();

    await tester.pumpWidget(MaterialApp(home: HomePage(api: fakeApi)));

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), "cheese");
    await tester.pump();

    await tester.tap(find.byIcon(Icons.search), warnIfMissed: false);
    await tester.pump();
    await tester.pumpAndSettle();
    expect(find.text("Pizza"), findsOneWidget);
  });
}
