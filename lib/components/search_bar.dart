import 'package:flutter/material.dart';
import 'package:home_chef_front_end/theme.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String)? onChanged;

  const SearchBarWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: const InputDecoration(
          icon: Icon(Icons.search, color: AppTheme.placeholder, size: 26),
          hintText: "Buscar receitas",
          hintStyle: TextStyle(color: AppTheme.placeholder),
          border: InputBorder.none,
        ),
      ),
    );
  }
}