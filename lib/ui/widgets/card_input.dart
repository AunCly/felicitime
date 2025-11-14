import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:felicitime/config/colors.dart';
import 'package:felicitime/config/theme.dart';

class AppCardInput extends StatefulWidget {
  const AppCardInput({super.key, required this.child});

  final Widget child;

  @override
  State<AppCardInput> createState() => _AppCardInputState();
}

class _AppCardInputState extends State<AppCardInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Theme.of(context).colorScheme.inverseSurface,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(FontAwesomeIcons.fonduePot),
              gapWNormal,
              Text('Card Number', style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
          const Divider(thickness: 2, color: AppColors.appBlack,),
          widget.child,
        ],
      ),
    );
  }
}
