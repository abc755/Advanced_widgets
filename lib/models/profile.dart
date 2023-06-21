import 'package:flutter/material.dart';

class ProfileTheme {
  final Color headerColor;
  final Color textColor;
  final Color buttonColor;
  final Color backgroundColor;

  ProfileTheme(this.headerColor, this.textColor, this.buttonColor, this.backgroundColor);
}
ProfileTheme themeDay = ProfileTheme(Colors.white70, Colors.black, Colors.tealAccent, Colors.lightGreenAccent);
ProfileTheme themeNight = ProfileTheme(Colors.black, Colors.white, Colors.lightGreenAccent, Colors.black,);