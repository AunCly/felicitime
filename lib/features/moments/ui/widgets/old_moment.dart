import 'dart:io';

import 'package:felicitime/ui/widgets/arrow_go.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/colors.dart';
import '../../../../config/theme.dart';
import '../../../capsules/model/moment.dart';

class OldMoment extends StatefulWidget {
  const OldMoment({super.key, required this.moment, required this.showAction, required this.deleteAction, required this.favoriteAction});

  final Moment moment;
  final Function showAction;
  final Function deleteAction;
  final Function favoriteAction;

  @override
  State<OldMoment> createState() => _OldMomentState();
}

class _OldMomentState extends State<OldMoment> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.showAction(),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3)),
                image: DecorationImage(
                  image: FileImage(File(widget.moment.medias.first.path)),
                  fit: BoxFit.cover,
                )
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                    right: 10,
                    child: AppArrowGo()
                  )
                ],
              )
            )),
            gapHLarge,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => widget.favoriteAction(),
                  child: Icon(widget.moment.isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.lightStar, size: 16, color: AppColors.appYellow),
                ),
                Icon(FontAwesomeIcons.lightPencil, size: 16, color: AppColors.appPurple),
                GestureDetector(
                  onTap: () => widget.deleteAction(),
                  child: Icon(FontAwesomeIcons.lightTrash, size: 16, color: AppColors.appOrange),
                ),
              ]
            ),
            gapHNormal,
          ],
        ),
      ),
    );
  }
}
