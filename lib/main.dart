import 'package:acousticsapp/core/theme/theme.dart';
import 'package:acousticsapp/core/theme/theme_provider.dart';
import 'package:acousticsapp/features/auth/presentation/login.dart';
import 'package:acousticsapp/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: blackTheme,
      themeMode: themeMode,
      theme: theme,
      home: Login(),
    );
  }
}
