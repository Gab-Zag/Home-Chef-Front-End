import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_chef_front_end/models/recipe.dart';
import 'package:home_chef_front_end/services/api_services.dart';
import 'package:home_chef_front_end/views/home_page.dart';

class FakeApiError extends Fake implements ApiService {
  @override
  Future<List<Recipe>> searchRecipes(String ingredients) async {
    throw Exception("API error");
  }
}

void main() {
  testWidgets('HomePage mostra erro quando API falha', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(api: FakeApiError()),
      ),
    );

    await tester.enterText(find.byType(TextField), "meat");
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    await tester.pump(const Duration(seconds: 1));

    expect(
      find.textContaining('Erro ao buscar receitas'),
      findsOneWidget,
    );
  });
}
