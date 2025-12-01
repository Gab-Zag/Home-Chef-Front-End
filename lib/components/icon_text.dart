import 'package:flutter/material.dart';
import 'package:home_chef_front_end/theme.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconText({required this.icon, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.yellow),
        const SizedBox(width: 6),
        Text(text, style: const TextStyle(color: AppTheme.background)),
      ],
    );
  }
}