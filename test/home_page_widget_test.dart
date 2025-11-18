import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_chef_front_end/models/recipe.dart';
import 'package:home_chef_front_end/services/api_services.dart';
import 'package:home_chef_front_end/views/home_page.dart';

/// Fake da API que sempre lança erro.
/// Isso serve apenas para testes — não existe como arquivo separado.
class FakeApiError extends Fake implements ApiService {
  @override
  Future<List<Recipe>> searchRecipes(String ingredients) async {
    throw Exception("API error");
  }
}

void main() {
  testWidgets('HomePage mostra erro quando API falha', (tester) async {
    // Usamos o FakeApiError aqui — criado no mesmo arquivo
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(api: FakeApiError()),
      ),
    );

    await tester.enterText(find.byType(TextField), "meat");
    await tester.tap(find.byIcon(Icons.search));
    await tester.pump();

    // Aguarda reconstrução
    await tester.pump(const Duration(seconds: 1));

    // Verifica se sua HomePage exibiu o erro
    expect(
      find.textContaining('Erro ao buscar receitas'),
      findsOneWidget,
    );
  });
}
