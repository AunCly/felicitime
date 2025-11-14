import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/theme.dart';

class AppCardButton extends StatelessWidget {
  const AppCardButton({super.key, required this.text, required this.icon});

  final String text;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Row(
        children: [
          if(icon != null) Icon(icon, color: Theme.of(context).colorScheme.primary, size: 16),
          gapWNormal,
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Icon(FontAwesomeIcons.chevronRight, size: 12, color: Theme.of(context).colorScheme.primary),
          )
        ],
      ),
    );
  }
}
