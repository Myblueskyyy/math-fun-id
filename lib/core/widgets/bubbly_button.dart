import 'package:flutter/material.dart';

class BubblyButton extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color mainColor;
  final Color shadowColor;
  final VoidCallback onTap;
  final bool isFullWidth;
  final double? fontSize;
  final EdgeInsetsGeometry? margin;

  const BubblyButton({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.mainColor,
    required this.shadowColor,
    required this.onTap,
    this.isFullWidth = false,
    this.fontSize,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final double paddingVert = isFullWidth ? 20 : 16;
    final double paddingHoriz = isFullWidth ? 24 : 8;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin:
            margin ?? const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        padding: const EdgeInsets.only(bottom: 8), // 3D shadow depth
        decoration: BoxDecoration(
          color: shadowColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: paddingVert,
            horizontal: paddingHoriz,
          ),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.5), width: 3),
          ),
          child: _buildContent(),
        ),
      ),
    );
  }

  Widget _buildContent() {
    final bool hasSubtitle = subtitle != null && subtitle!.isNotEmpty;
    final bool hasIcon = icon != null;

    if (isFullWidth) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasIcon) ...[
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(width: 16),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment: hasIcon
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  textAlign: hasIcon ? TextAlign.left : TextAlign.center,
                  style: TextStyle(
                    fontSize: fontSize ?? 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    height: 1.1,
                    shadows: const [
                      Shadow(
                        blurRadius: 4,
                        color: Colors.black26,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                ),
                if (hasSubtitle) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    textAlign: hasIcon ? TextAlign.left : TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.95),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIcon) ...[
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 12),
          ],
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: fontSize ?? 16,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              height: 1.1,
              shadows: const [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black26,
                  offset: Offset(0, 2),
                ),
              ],
            ),
          ),
          if (hasSubtitle) ...[
            const SizedBox(height: 6),
            Text(
              subtitle!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.95),
              ),
            ),
          ],
        ],
      );
    }
  }
}
