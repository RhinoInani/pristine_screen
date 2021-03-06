import 'package:Pristine_Screen/main.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'home_page.dart';

class ScreenCleaningPage extends StatefulWidget {
  const ScreenCleaningPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ScreenCleaningPage> createState() => _ScreenCleaningPageState();
}

class _ScreenCleaningPageState extends State<ScreenCleaningPage>
    with SingleTickerProviderStateMixin {
  bool completed = false;

  late AnimationController _animationController;
  late Animation _animation;
  late Animation<double> _curve;

  @override
  void initState() {
    DesktopWindow.setFullScreen(true);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)
          ..addListener(() {
            setState(() {});
          });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  FocusNode spaceFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(spaceFocus);
    Size size = MediaQuery.of(context).size;
    double halfWidth = MediaQuery.of(context).size.width * 0.5;
    _animation = Tween(begin: 0.0, end: halfWidth).animate(_curve)
      ..addListener(() {
        setState(() {});
      });

    return Focus(
      autofocus: true,
      descendantsAreFocusable: true,
      onKey: (FocusNode node, RawKeyEvent event) {
        if (event.isMetaPressed) {
          return KeyEventResult.handled;
        }
        if (event.physicalKey != PhysicalKeyboardKey.space) {
          return KeyEventResult.handled;
        } else {
          return KeyEventResult.handled;
        }
      },
      child: RawKeyboardListener(
        focusNode: spaceFocus,
        onKey: (RawKeyEvent key) {
          if (key.logicalKey == LogicalKeyboardKey.brightnessUp ||
              key.logicalKey == LogicalKeyboardKey.brightnessDown ||
              key.logicalKey == LogicalKeyboardKey.navigateIn ||
              key.logicalKey == LogicalKeyboardKey.navigateOut ||
              key.logicalKey == LogicalKeyboardKey.mediaApps ||
              key.logicalKey == LogicalKeyboardKey.audioVolumeUp ||
              key.logicalKey == LogicalKeyboardKey.audioVolumeDown ||
              key.logicalKey == LogicalKeyboardKey.audioVolumeMute ||
              key.logicalKey == LogicalKeyboardKey.allCandidates) {
            print('hardcode');
            _animationController.reverse();
            return;
          }
          if (key.isMetaPressed) {
            print('metapressed');
            spaceFocus.requestFocus();
            return;
          }
          if (LogicalKeyboardKey.macosPlane == key.data.hashCode ||
              RawKeyEventDataMacOs.modifierOption == 0) {
            print('macosplane');
            _animationController.reverse();
            return;
          }
          if (kMacOsToLogicalKey.containsValue(key.logicalKey)) {
            print("test");
            _animationController.reverse();
            return;
          }
          if (key.character == " ") {
            _animationController.forward();
            if (_animationController.isCompleted) {
              DesktopWindow.setFullScreen(false);
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomePage();
              }));
            }
          } else {
            _animationController.reverse();
          }
        },
        child: Scaffold(
          backgroundColor: background,
          body: Center(
            child: Stack(
              children: [
                IgnorePointer(
                  child: Container(
                    width: size.width * 0.5,
                    height: size.height * 0.1,
                    padding: EdgeInsets.all(size.height * 0.02),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(
                        color: Colors.grey[400]!,
                        width: 0.7,
                      ),
                      color: Colors.transparent,
                    ),
                    child: Text(
                      "Press the space bar for 3 seconds "
                      "\nto get out of cleaning mode",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: size.longestSide * 0.012),
                    ),
                  ),
                ),
                Container(
                  width: _animation.value,
                  height: size.height * 0.1,
                  padding: EdgeInsets.all(size.height * 0.02),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      color: Colors.grey[400]!,
                      width: 0.7,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
