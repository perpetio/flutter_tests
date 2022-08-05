import 'package:flutter/material.dart';
import 'package:flutter_tests/home/home_screen.dart';
import 'package:flutter_tests/repositories/cat_fact_repository.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tests',
      home: HomeScreen(repository: CatfactRepository()),
    );
  }
}
