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
      style: ElevatedButton.styleFrom(
        backgroundColor: color ?? Theme.of(context).colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)
      ),
      onPressed: () => onPressed(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if(icon != null) Icon(icon, color: Theme.of(context).colorScheme.surface, size: 15),
          if(icon != null && text != null) gapWSmall,
          if(text != null) Text(text!, style: Theme.of(context).textTheme.titleSmall!.copyWith(color: Theme.of(context).colorScheme.surface)),
        ],
      )
    );
  }
}
