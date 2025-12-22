import 'package:felicitime/config/theme.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BackHome extends StatefulWidget {
  const BackHome({super.key});

  @override
  State<BackHome> createState() => _BackHomeState();
}

class _BackHomeState extends State<BackHome> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => context.pop(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(FontAwesomeIcons.lightHouse, size: 20),
              gapWNormal,
              Text('Retour', style: Theme.of(context).textTheme.titleMedium),
            ],
          )
        ),
      ]
    );
  }
}
