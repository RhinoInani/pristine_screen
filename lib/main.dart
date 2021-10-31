import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final shortcuts = Map.of(WidgetsApp.defaultShortcuts)
    ..remove(LogicalKeySet(LogicalKeyboardKey.escape));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      shortcuts: shortcuts,
      title: 'Screen Cleaner',
      theme: ThemeData(fontFamily: 'Museo Moderno'),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
