import 'package:flutter/material.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'isoule_ai',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: Scaffold(body: Center(child: Text('sndjsndj'))),
    );
  }
}
