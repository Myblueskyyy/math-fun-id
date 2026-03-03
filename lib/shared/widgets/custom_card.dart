import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? padding;
  final VoidCallback? onTap;

  const CustomCard({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: EdgeInsets.all(padding ?? 20.0),
          child: child,
        ),
      ),
    );
  }
}
