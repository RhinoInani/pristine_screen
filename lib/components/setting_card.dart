import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String text;
  final Icon icon;
  final Function pressIcon;
  const SettingsCard(
      {Key? key,
      required this.text,
      required this.icon,
      required this.pressIcon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          pressIcon.call();
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.035),
              height: MediaQuery.of(context).size.height * 0.135,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    text,
                    style: TextStyle(
                        fontSize:
                            MediaQuery.of(context).size.longestSide * 0.03,
                        color: Colors.white),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    onPressed: () {
                      pressIcon.call();
                    },
                    icon: icon,
                    iconSize: MediaQuery.of(context).size.longestSide * 0.03,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
