import 'package:flutter/material.dart';

class CookingModePage extends StatefulWidget {
  const CookingModePage({super.key});

  @override
  State<CookingModePage> createState() => _CookingModePageState();
}

class _CookingModePageState extends State<CookingModePage> {
  int step = 0;

  final List<String> steps = [
    "Pique todos os ingredientes finamente.",
    "Aqueça a panela e adicione manteiga.",
    "Misture a farinha e mexa por 3 minutos.",
    "Adicione os ovos e continue mexendo.",
    "Cozinhe até engrossar e sirva."
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
              const SizedBox(height: 20),
              Text("Modo Cozinha",
                  style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),

              LinearProgressIndicator(
                value: (step + 1) / steps.length,
                backgroundColor: Color(0xFF3B1E47),
                valueColor: AlwaysStoppedAnimation(Color(0xFF7A3CFF)),
              ),

              const SizedBox(height: 40),
              Text(
                "Passo ${step + 1}",
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Text(
                  steps[step],
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    iconSize: 40,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: step == 0 ? null : () => setState(() => step--),
                  ),
                  IconButton(
                    color: Colors.white,
                    iconSize: 40,
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: step == steps.length - 1 ? null : () => setState(() => step++),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
