import 'dart:io';

import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/moments/ui/screens/show_moment.dart';
import 'package:felicitime/ui/widgets/dialog.dart';
import 'package:felicitime/ui/widgets/images_gallery_details.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AppMoments extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (Moment moment in moments)
          Column(
            children: [
              GestureDetector(
                onTap: () => showMomentDialog(context, moment),
                child: Container(
                  height: 350,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    image: DecorationImage(
                      image: FileImage(
                        File(moment.medias.first.path),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Row(
                            children: [
                              Icon(FontAwesomeIcons.lightImage, size: 16, color: Theme.of(context).colorScheme.onSurface,),
                              const SizedBox(width: 5,),
                              Text(
                                moment.medias.length.toString(),
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 10,
                        left: 10,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface.withOpacity(0.8),
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                            DateFormat('dd/MM/yyyy').format(moment.createdAt),
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ]
                  )
                ),
              ),
              gapHNormal,
            ],
          )
      ],
    );
  }
}
