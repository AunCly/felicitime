import 'dart:io';
import 'dart:ui';

import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/moments/ui/screens/show_moment.dart';
import 'package:felicitime/ui/widgets/dialog.dart';
import 'package:felicitime/ui/widgets/images_gallery_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../config/colors.dart';
import '../../../../ui/widgets/button.dart';

class AppMoments extends ConsumerWidget {
  const AppMoments({super.key, required this.moments});

  final List<Moment> moments;

  showMomentDialog(BuildContext context, Moment moment){
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dialog.fullscreen(
          child: AppDialog(
            title: 'Moment',
            content: ShowMoment(moment: moment)
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, 1), end: const Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }

  void deleteMoment(BuildContext context, WidgetRef ref, Moment moment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        insetPadding: const EdgeInsets.all(15),
        title: const Text('Supprimer le moment'),
        content: const Text('Êtes-vous sûr de vouloir supprimer ce moment ? Cette action est irréversible.'),
        actions: [
          Row(
            children: [
              Spacer(),
              AppButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: FontAwesomeIcons.lightXmark,
                text: 'Annuler',
              ),
              gapWNormal,
              AppButton(
                onPressed: () {
                  ref.read(capsuleRepositoryProvider).deleteMoment(moment);
                  Navigator.of(context).pop();
                },
                icon: FontAwesomeIcons.lightTrash,
                text: 'Supprimer',
              )
            ]
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      spacing: 20.0,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(20)),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: () => showMomentDialog(context, moments.first),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3)),
                    image: DecorationImage(
                      image: FileImage(File(moments.first.medias.first.path)),
                      fit: BoxFit.cover,
                    )
                  ),
                  height: 250,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(25)),
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
                                ),
                                child: Icon(FontAwesomeIcons.solidAngleLeft, size: 16, color: Theme.of(context).colorScheme.onSurface),
                              ),
                              gapWNormal,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Moment du ', style: Theme.of(context).textTheme.bodyMedium),
                                  Text(DateFormat('dd/MM/yyyy').format(moments.first.createdAt), style: Theme.of(context).textTheme.titleSmall),
                                ]
                              )
                            ]
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              gapHLarge,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Icon(FontAwesomeIcons.lightStar, size: 20, color: Theme.of(context).colorScheme.onSurface),
                      gapHSmall,
                      Text('Favoris', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  gapWLarge,
                  Column(
                    children: [
                      Icon(FontAwesomeIcons.lightPencil, size: 20, color: Theme.of(context).colorScheme.onSurface),
                      gapHSmall,
                      Text('Modifier', style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                  gapWLarge,
                  GestureDetector(
                    onTap: () => deleteMoment(context, ref, moments.first),
                    child: Column(
                      children: [
                        Icon(FontAwesomeIcons.lightTrash, size: 20, color: Theme.of(context).colorScheme.onSurface),
                        gapHSmall,
                        Text('Supprimer', style: Theme.of(context).textTheme.bodySmall),
                      ],
                    ),
                  ),
                ]
              ),
              gapHSmall,
            ],
          ),
        ),
        GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: moments.skip(1).map((moment) => GestureDetector(
            onTap: () => showMomentDialog(context, moment),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: AppColors.appGrey.withValues(alpha: 0.3)),
                image: DecorationImage(
                  image: FileImage(File(moment.medias.first.path)),
                  fit: BoxFit.cover,
                )
              ),
            ),
          )).toList(),
        )
      ],
    );
  }
}
