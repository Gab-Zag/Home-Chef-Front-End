import 'package:flutter/material.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, String>> favorites = const [
    {
      "id": "1",
      "title": "Omelete Cremoso",
      "image": "https://picsum.photos/200"
    },
    {
      "id": "2",
      "title": "Macarrão com Queijo",
      "image": "https://picsum.photos/210"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1A1A1E),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Text("Favoritos",
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              Expanded(
                child: ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (_, i) {
                    final r = favorites[i];
                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                          color: Color(0xFF3B1E47),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Hero(
                              tag: r["id"]!,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(r["image"]!,
                                    width: 100, height: 100, fit: BoxFit.cover),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Text(
                                r["title"]!,
                                style:
                                    const TextStyle(color: Colors.white, fontSize: 18),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.favorite, color: Colors.redAccent),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
