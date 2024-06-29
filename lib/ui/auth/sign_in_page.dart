import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The details screen
class SignInPage extends StatelessWidget {
  /// Constructs a [SignInPage]
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SignInPage')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go('/'),
          child: const Text('Go back to the Home screen'),
        ),
      ),
    );
  }
}
