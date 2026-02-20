import 'package:flutter/material.dart';

import '../../config/colors.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({super.key, required this.text, required this.icon, this.color = AppColors.appWhite, this.textColor = AppColors.appBlack});

  final String text;
  final IconData icon;
  final Color color;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: textColor),
          const SizedBox(width: 5),
          Text(text, style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.bold, color: textColor))
        ],
      ),
    );
  }
}
