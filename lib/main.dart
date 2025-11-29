import 'package:flutter/material.dart';
import 'package:home_chef_front_end/services/api_services.dart';
import 'package:home_chef_front_end/views/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Chef',
      debugShowCheckedModeBanner: false,
      home: HomePage(api: ApiService()),
    );
  }
}
