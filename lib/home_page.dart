import 'package:Pristine_Screen/main.dart';
import 'package:Pristine_Screen/screen_cleaning.dart';
import 'package:Pristine_Screen/settings_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Focus(
      autofocus: true,
      descendantsAreFocusable: true,
      onKey: (FocusNode node, RawKeyEvent event) {
        return KeyEventResult.handled;
      },
      child: Scaffold(
        backgroundColor: background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Pristine Screen",
                style: TextStyle(
                  fontSize: size.height * 0.1,
                  color: Colors.white,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return const ScreenCleaningPage();
                  }));
                },
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  padding: EdgeInsets.all(size.longestSide * 0.02),
                  side: const BorderSide(color: Colors.white),
                ),
                child: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: size.longestSide * 0.02,
                      fontFamily: 'Museo Moderno',
                      color: Colors.white,
                    ),
                    children: const [
                      TextSpan(
                        text: "Start ",
                        style: TextStyle(),
                      ),
                      TextSpan(
                        text: "Cleaning Session",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          tooltip: "Settings",
          backgroundColor: Colors.black,
          splashColor: Colors.black,
          hoverColor: Colors.transparent,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const SettingScreen();
            }));
          },
          child: Icon(
            Icons.settings,
            size: size.longestSide * 0.03,
          ),
        ),
      ),
    );
  }
}
