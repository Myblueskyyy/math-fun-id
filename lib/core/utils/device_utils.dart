import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class DeviceUtils {
  /// Checks if the device is a phone based on the shortest side of the screen.
  /// Typically, tablets have a shortest side >= 600dp.
  static bool isPhone(BuildContext context) {
    final shortestSide = MediaQuery.of(context).size.shortestSide;
    return shortestSide < 600;
  }

  /// Forces the orientation to portrait only.
  static Future<void> forcePortrait() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  /// Forces the orientation to landscape only.
  static Future<void> forceLandscape() async {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  /// Resets orientation to the app's default (landscape for this app).
  static Future<void> resetToDefault() async {
    await forceLandscape();
  }
}
