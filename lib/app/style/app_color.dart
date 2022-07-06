import 'package:flutter/cupertino.dart';

class AppColor {
  static LinearGradient primaryGradient = LinearGradient(
    colors: [primary, Color(0xFF072227)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static Color primary = Color(0xFF35858B);
  static Color primarySoft = Color(0xFF548DF3);
  static Color primaryExtraSoft = Color(0xFFEFF3FC);
  static Color secondary = Color(0xFF1B1F24);
  static Color secondarySoft = Color(0xFF9D9D9D);
  static Color secondaryExtraSoft = Color(0xFFE9E9E9);
  static Color error = Color(0xFFD00E0E);
  static Color success = Color(0xFF16AE26);
  static Color warning = Color(0xFFEB8600);
  static Color primaryColor = Color(0xFF13375B);
  static Color shadowColor = Color(0xFF63B1B7);
  static const Color backgroundColor = Color(0xFF35858B);
  static Color navigationColor = Color(0xFF072227);
  static Color whiteColor = Color(0xFFFFFFFF);
}
