import 'package:Pristine_Screen/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'components/setting_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'': ''},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  List<String> urls = [
    "https://www.instagram.com/pristinescreen/",
    "https://github.com/RhinoInani/pristine_screen",
    "https://forms.gle/miQAhC2qUixaEvi87",
    "https://forms.gle/MUhdenYRC2AFJwCz8",
    "https://smarturl.it/pristinescreen",
  ];
  List<String> titles = [
    "Instagram",
    "Github",
    "Feature Request",
    "Report a bug",
    "Share",
  ];

  void openColorDialog(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Column(
              children: [
                ColorPicker(
                  color: background,
                  pickerOrientation: PickerOrientation.portrait,
                  onChanged: (value) {
                    setState(() {
                      background = Color.fromRGBO(
                          value.red, value.green, value.blue, value.opacity);
                    });
                  },
                  initialPicker: Picker.paletteHue,
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
          size: size.longestSide * 0.03,
        ),
      ),
      backgroundColor: background,
      body: Focus(
        autofocus: true,
        descendantsAreFocusable: true,
        onKey: (FocusNode node, RawKeyEvent event) {
          return KeyEventResult.handled;
        },
        child: ListView.builder(
          itemCount: titles.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Column(
                children: [
                  Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: size.longestSide * 0.07,
                      color: Colors.white,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035),
                    height: MediaQuery.of(context).size.height * 0.135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Clean on Launch",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.longestSide * 0.03,
                            color: Colors.white,
                          ),
                        ),
                        Tooltip(
                          message: cleanOnLaunch ? "On" : "Off",
                          child: Switch.adaptive(
                            value: cleanOnLaunch,
                            onChanged: (value) async {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              setState(() {
                                cleanOnLaunch = value;
                              });
                              prefs.setBool('onLaunch', value);
                            },
                            inactiveTrackColor: Colors.white10,
                            activeTrackColor: Colors.black,
                            activeColor: Colors.white24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035),
                    height: MediaQuery.of(context).size.height * 0.135,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Change Color",
                          style: TextStyle(
                            fontSize:
                                MediaQuery.of(context).size.longestSide * 0.03,
                            color: Colors.white,
                          ),
                        ),
                        OutlinedButton(
                            onPressed: () {
                              openColorDialog(context);
                            },
                            child: Text("Color"))
                      ],
                    ),
                  ),
                  SettingsCard(
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    pressIcon: () {
                      _launchInBrowser(
                        "${urls[index]}",
                      );
                    },
                    text: "${titles[index]}",
                  ),
                ],
              );
            } else if (index == titles.length) {
              return SettingsCard(
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                pressIcon: () {
                  showAboutDialog(
                      context: context,
                      applicationVersion: '1.0.2',
                      applicationName: 'Pristine Screen',
                      children: [
                        Text(
                          'Created by Rohin Inani',
                        ),
                        Divider(
                          height: 10,
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                        Text('rhino.inani@gmail.com'),
                      ]);
                },
                text: "About",
              );
            } else {
              return SettingsCard(
                icon: const Icon(Icons.arrow_forward_ios_rounded),
                pressIcon: () {
                  _launchInBrowser(
                    "${urls[index]}",
                  );
                },
                text: "${titles[index]}",
              );
            }
          },
        ),
      ),
    );
  }
}
