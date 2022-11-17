import 'package:brothers_keeper/core/constants/themes.dart';
import 'package:brothers_keeper/features/onboard/views/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brother\'s Keeper',
      theme: AppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      home: const OnboardScreen(),
    );
  }
}
