import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  runApp(const CardemoApp());
}

class CardemoApp extends StatelessWidget {
  const CardemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Cardemo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
