import 'package:flutter/material.dart';

class BubblyBackground extends StatelessWidget {
  final Widget child;

  const BubblyBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildBackgroundGradient(context), _buildMathSymbols(), child],
    );
  }

  Widget _buildBackgroundGradient(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: isDark
              ? [const Color(0xFF1E3A8A), const Color(0xFF0F172A)]
              : [const Color(0xFFE0F7FA), const Color(0xFFB2EBF2)],
        ),
      ),
    );
  }

  Widget _buildMathSymbols() {
    return const Stack(
      children: [
        // Top section
        Positioned(
          top: 60,
          left: 20,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '+',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: 180,
          child: Opacity(
            opacity: 0.1,
            child: Text(
              '%',
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 80,
          right: 30,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '×',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 150,
          right: 120,
          child: Opacity(
            opacity: 0.12,
            child: Text(
              '=',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Middle section
        Positioned(
          top: 250,
          left: 40,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '÷',
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 220,
          right: 60,
          child: Opacity(
            opacity: 0.1,
            child: Text(
              '+',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 320,
          left: 160,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '-',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 350,
          right: 40,
          child: Opacity(
            opacity: 0.12,
            child: Text(
              '×',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 420,
          left: 70,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '=',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 450,
          right: 140,
          child: Opacity(
            opacity: 0.1,
            child: Text(
              '%',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Lower middle section
        Positioned(
          top: 550,
          left: 30,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '+',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 520,
          right: 70,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '-',
              style: TextStyle(fontSize: 65, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          top: 600,
          right: 180,
          child: Opacity(
            opacity: 0.12,
            child: Text(
              '÷',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
        ),

        // Bottom section (using bottom property for different screen sizes)
        Positioned(
          bottom: 250,
          left: 60,
          child: Opacity(
            opacity: 0.12,
            child: Text(
              '×',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 200,
          right: 40,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '=',
              style: TextStyle(fontSize: 55, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: 120,
          child: Opacity(
            opacity: 0.1,
            child: Text(
              '%',
              style: TextStyle(fontSize: 45, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 80,
          right: 80,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '+',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 40,
          left: 40,
          child: Opacity(
            opacity: 0.12,
            child: Text(
              '-',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Positioned(
          bottom: 150,
          left: 200,
          child: Opacity(
            opacity: 0.15,
            child: Text(
              '÷',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
