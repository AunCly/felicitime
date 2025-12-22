import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppArrowGo extends StatelessWidget {
  const AppArrowGo({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -math.pi / 4,
      child: Container(
        padding: EdgeInsets.all(2),
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.inverseSurface,
          shape: BoxShape.circle,
        ),
        child: Icon(FontAwesomeIcons.arrowRight, size: 10,)
      )
    );
  }
}
