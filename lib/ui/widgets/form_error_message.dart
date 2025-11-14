import 'package:flutter/material.dart';

class AppFormValidationErrorMessage extends StatelessWidget {
  const AppFormValidationErrorMessage({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Text(message, style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).colorScheme.error))
      ]
    );
  }
}
