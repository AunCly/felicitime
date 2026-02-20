import 'package:flutter/material.dart';

class AppGradientText extends StatelessWidget {
  const AppGradientText({super.key, required this.text, required this.textStyle, required this.gradientColors, this.overflow});

  final String text;
  final TextStyle textStyle;
  final List<Color> gradientColors;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(
        colors: gradientColors,
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
      child: Text(text, style: textStyle, overflow: overflow, maxLines: 1)
    );
  }
}
