import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF6C63FF);
  static const Color secondary = Color(0xFFFF6584);
  static const Color accent = Color(0xFFFFD166);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFFF4D4D);
  static const Color success = Color(0xFF4CAF50);

  static const Color textPrimary = Color(0xFF2D3436);
  static const Color textSecondary = Color(0xFF636E72);

  // Custom colors from reference
  static const Color blueIcon = Color(0xFF4285F4);
  static const Color orangeIcon = Color(0xFFFBBC05);
  static const Color greenIcon = Color(0xFF34A853);
  static const Color purpleIcon = Color(0xFF7E57C2);
  static const Color redIcon = Color(0xFFEA4335);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C63FF), Color(0xFF8E88FF)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
