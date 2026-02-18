import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cardemo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '카드 덱 메모 앱',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.go('/card/new'),
              child: const Text('새 카드 작성'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.go('/cards'),
              child: const Text('카드 목록 보기'),
            ),
          ],
        ),
      ),
    );
  }
}
