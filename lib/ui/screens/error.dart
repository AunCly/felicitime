import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ErrorScreen extends StatelessWidget {

  const ErrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text('Error Screen'),
            ElevatedButton(
              onPressed: () {
                context.go('/dashboard');
              },
              child: const Text('Go to dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}