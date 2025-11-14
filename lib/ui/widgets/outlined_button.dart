import 'package:flutter/material.dart';
import 'package:felicitime/config/theme.dart';

class AppOutlinedButton extends StatelessWidget {

  const AppOutlinedButton({
    super.key,
    this.text,
    required this.icon,
    required this.onPressedMethod,
  });

  final String? text;
  final IconData icon;
  final Function onPressedMethod;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => onPressedMethod(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 15),
          if(text != null) gapWNormal,
          if(text != null) Text(text!, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
        ],
      )
    );
  }
}
