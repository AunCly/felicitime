import 'package:flutter/material.dart';
import 'package:felicitime/config/theme.dart';

class AppButton extends StatelessWidget {

  const AppButton({
    super.key,
    this.text,
    required this.onPressed,
    this.icon,
    this.color,
  });

  final String? text;
  final IconData? icon;
  final Function onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null) Icon(icon, color: Theme.of(context).colorScheme.surface, size: 15),
          if(icon != null && text != null) gapWNormal,
          if(text != null) Text(text!, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
        ],
      )
    );
  }
}
