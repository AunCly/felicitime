import 'package:felicitime/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppInfoMessage extends StatelessWidget {
  const AppInfoMessage({
    super.key,
    required this.message,
    this.icon = FontAwesomeIcons.lightCircleInfo,
    this.action,
    this.title
  });

  final String? title;
  final String message;
  final IconData? icon;
  final Function? action;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).colorScheme.inverseSurface,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title != null) Column(
            children: [
              Row(
                children : [
                  if(icon != null) Icon(icon, color: Theme.of(context).colorScheme.primary, size: 15),
                  if(icon != null) gapWNormal,
                  Text(title!, style: Theme.of(context).textTheme.titleMedium),
                ]
              ),
              gapHNormal,
            ]
          ),
          Row(
            children: [
              if(title == null) Icon(icon, color: Theme.of(context).colorScheme.primary, size: 15),
              if(title == null) gapWNormal,
              Flexible(
                child: Text(message, style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary))
              ),
            ],
          ),
          if(action != null) Column(
            children: [
              gapHNormal,
              ElevatedButton(
                onPressed: () => action!(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(FontAwesomeIcons.lightSliders, color: Colors.white, size: 15),
                    const SizedBox(width: 5),
                    Text('Ouvrir les réglages', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.white))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
