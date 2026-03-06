import 'dart:ui';
import 'package:flutter/material.dart';

class BubblyBackground extends StatelessWidget {
  final Widget child;

  const BubblyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Background Image
        Image.asset('assets/images/background_1.png', fit: BoxFit.cover),

        // Blur and Darken Overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
            child: Container(color: Colors.black.withValues(alpha: 0.3)),
          ),
        ),

        // The actual content
        child,
      ],
    );
  }
}
