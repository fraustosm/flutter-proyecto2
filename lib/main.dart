import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme/app_theme.dart';
import 'presentation/providers/theme_provider.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(themeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,

      themeMode:
          isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,

      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends ConsumerWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isDarkMode = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wallpaper Gallery'),

        actions: [

          IconButton(
            onPressed: () {

              ref
                  .read(themeProvider.notifier)
                  .toggleTheme();

            },

            icon: Icon(
              isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),

        ],
      ),

      body: const Center(
        child: Text('holi'),
      ),
    );
  }
}