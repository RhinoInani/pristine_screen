import 'package:Pristine_Screen/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/setting_card.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "Settings",
              style: TextStyle(
                fontSize: size.longestSide * 0.07,
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.035),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Clean on Launch",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.longestSide * 0.03,
                      color: Colors.white,
                    ),
                  ),
                  Tooltip(
                    message: cleanOnLaunch ? "On" : "Off",
                    child: Switch.adaptive(
                      value: cleanOnLaunch,
                      onChanged: (value) async {
                        final prefs = await SharedPreferences.getInstance();
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
            SettingsCard(
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              pressIcon: () {
                print("test");
              },
              text: "Test",
            ),
          ],
        ),
      ),
    );
  }
}
