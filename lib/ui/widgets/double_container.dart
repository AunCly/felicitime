import 'package:flutter/material.dart';

class AppDoubleContainer extends StatelessWidget {
  const AppDoubleContainer({
    super.key,
    required this.primaryColor,
    required this.backgroundColor,
    required this.content,
    this.radius = 20,
  });

  final Color primaryColor;
  final Color backgroundColor;
  final Widget content;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 3),
      child: Container(
        decoration: ShapeDecoration(
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
            side: BorderSide(color:Theme.of(context).colorScheme.inverseSurface, width: 2),
          ),
          color: backgroundColor,
        ),
        child: Container(
          decoration: ShapeDecoration(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(radius),
              side: BorderSide(color: Theme.of(context).colorScheme.inverseSurface, width: 2),
            ),
            color: primaryColor,
          ),
          transform: Matrix4.translationValues(-5, -5, 0.0),
          child: content,
        ),
      ),
    );
  }
}
