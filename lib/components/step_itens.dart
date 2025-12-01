import 'package:flutter/material.dart';
import 'package:home_chef_front_end/theme.dart';

class StepItem extends StatelessWidget {
  final int number;
  final String text;

  const StepItem({super.key, required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: AppTheme.yellow,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(
              child: Text(
                number.toString(),
                style: const TextStyle(
                  color: AppTheme.background,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),
          
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> buildInstructions(String instructions) {
  final steps = instructions
      .split(RegExp(r'\r?\n'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty)
      .toList();

  return List.generate(
    steps.length,
    (i) => StepItem(number: i + 1, text: steps[i]),
  );
}