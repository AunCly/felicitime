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
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              shape: BoxShape.circle,
            ),
            child: const Icon(FontAwesomeIcons.arrowLeft, size: 20,),
          ),
        ),
      ]
    );
  }
}
