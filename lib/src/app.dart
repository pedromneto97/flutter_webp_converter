import 'package:flutter/material.dart';

import 'presentation/home/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebP Converter',
      theme: ThemeData.from(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
