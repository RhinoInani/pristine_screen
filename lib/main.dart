import 'package:Pristine_Screen/home_page.dart';
import 'package:Pristine_Screen/screen_cleaning.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool cleanOnLaunch = false;
Color background = Color.fromRGBO(0, 0, 0, 1);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    getOnLaunch().then((value) {
      setState(() {});
    });
    super.initState();
  }

  Future<void> getOnLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    cleanOnLaunch = prefs.getBool('onLaunch')!;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      shortcuts: Map.of(WidgetsApp.defaultShortcuts)
        ..remove(LogicalKeySet(
            LogicalKeyboardKey.meta,
            LogicalKeyboardKey.escape,
            LogicalKeyboardKey.brightnessUp,
            LogicalKeyboardKey.brightnessDown)),
      actions: {
        ...WidgetsApp.defaultActions
          ..remove(LogicalKeySet(
              LogicalKeyboardKey.meta,
              LogicalKeyboardKey.escape,
              LogicalKeyboardKey.brightnessUp,
              LogicalKeyboardKey.brightnessDown)),
        ActivateAction: CallbackAction(
          onInvoke: (Intent intent) {
            return null;
          },
        ),
      },
      title: 'Screen Cleaner',
      theme: ThemeData(fontFamily: 'Museo Moderno'),
      debugShowCheckedModeBanner: false,
      home: cleanOnLaunch ? ScreenCleaningPage() : HomePage(),
    );
  }
}
