import 'package:flutter/material.dart';

class AppCircleIcon extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color backgroundColor;
  final double size;

  const AppCircleIcon({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.backgroundColor,
    required this.size
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size),
        color: backgroundColor
      ),
      child: Icon(icon, color: iconColor, size: size * 0.5),
    );
  }
}
