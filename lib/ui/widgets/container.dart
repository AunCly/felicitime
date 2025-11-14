import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    required this.content,
    this.primaryColor,
    this.radius = 20,
    this.padding = 10,
    this.margin = 0,
  });

  final Color? primaryColor;
  final Widget content;
  final double radius;
  final double padding;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      margin: EdgeInsets.only(top: margin, bottom: margin),
      decoration: ShapeDecoration(
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: Theme.of(context).colorScheme.inverseSurface, width: 2),
        ),
        color: primaryColor ?? Colors.white,
      ),
      child: content,
    );
  }
}
