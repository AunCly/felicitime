import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/theme.dart';

class AppAlertMessage extends StatelessWidget {
  const AppAlertMessage({
    super.key,
    required this.message,
    this.title,
    this.icon = FontAwesomeIcons.lightTriangleExclamation,
  });

  final String message;
  final String? title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: ShapeDecoration(
        color: Theme.of(context).colorScheme.errorContainer,
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
      ),
      child: Column(
        children: [
          if(title != null) Row(
            children: [
              Icon(icon, color: Theme.of(context).colorScheme.onErrorContainer, size: 20),
              gapWNormal,
              Flexible(
                child: Text(title!, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.onErrorContainer))
              ),
            ],
          ),
          Row(
            children: [
              if(title == null) Icon(icon, color: Theme.of(context).colorScheme.onErrorContainer, size: 20),
              if(title == null) gapWNormal,
              Flexible(
                child: Text(message, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.onErrorContainer))
              ),
            ],
          ),
        ],
      ),
    );
  }
}
