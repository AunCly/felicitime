import 'dart:io';

import 'package:felicitime/ui/widgets/arrow_go.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/colors.dart';
import '../../../../config/theme.dart';
import '../../../../ui/widgets/badge.dart';
import '../../../capsules/model/moment.dart';

class LastMoment extends StatefulWidget {
  const LastMoment({super.key, required this.moment, required this.deleteAction, required this.showAction, required this.favoriteAction});

  final Moment moment;
  final Function showAction;
  final Function deleteAction;
  final Function favoriteAction;

  @override
  State<LastMoment> createState() => _LastMomentState();
}

class _LastMomentState extends State<LastMoment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        spacing: 10.0,
        children: [
          GestureDetector(
            onTap: () => widget.showAction(),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3)),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Hero(
                            tag: widget.moment.medias.first.path,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              child: Image.file(
                                File(widget.moment.medias.first.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 10,
                            right: 10,
                            child: AppArrowGo()
                        ),
                        Positioned(
                            top: 10,
                            left: 10,
                            child: AppBadge(
                              color: AppColors.appPink,
                              text: DateFormat('dd/MM/yyyy').format(widget.moment.createdAt),
                              icon: FontAwesomeIcons.lightCalendar,
                            )
                        ),
                      ],
                    ),
                  ),
                ),
                gapWNormal,
                Column(
                  children: [
                    GestureDetector(
                      onTap: () => widget.favoriteAction(),
                      child: Column(
                        children: [
                          Icon(widget.moment.isFavorite ? FontAwesomeIcons.solidStar : FontAwesomeIcons.lightStar, size: 20, color: AppColors.appYellow),
                          gapHSmall,
                          Text('Favoris', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                    gapHLarge,
                    Column(
                      children: [
                        Icon(FontAwesomeIcons.lightPencil, size: 20, color: AppColors.appPurple),
                        gapHSmall,
                        Text('Modifier', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                    gapHLarge,
                    GestureDetector(
                      onTap: () => widget.deleteAction(),
                      child: Column(
                        children: [
                          Icon(FontAwesomeIcons.lightTrash, size: 20, color: AppColors.appOrange),
                          gapHSmall,
                          Text('Supprimer', style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ]
                )
              ],
            ),
          ),
          Column(
            children: [
              Row(
                textBaseline: TextBaseline.alphabetic,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: [
                  Text("Capsule : ", style: Theme.of(context).textTheme.titleMedium),
                  Text(widget.moment.capsule.title, style: Theme.of(context).textTheme.bodyMedium),
                ],
              ),
            ]
          ),
        ],
      ),
    );
  }
}
