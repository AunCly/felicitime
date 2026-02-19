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
import 'last_moment.dart';
import 'old_moment.dart';

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

  void toggleFavorite(WidgetRef ref, Moment moment) {
    ref.read(capsuleRepositoryProvider).toggleFavorite(moment);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text('Mon dernier moment.', style: Theme.of(context).textTheme.titleMedium),
        gapHNormal,
        LastMoment(
          moment: moments.first,
          showAction: () => showMomentDialog(context, moments.first),
          deleteAction: () => deleteMoment(context, ref, moments.first),
          favoriteAction: () => toggleFavorite(ref, moments.first),
        ),
        gapHNormal,
        Text('Mes anciens moments.', style: Theme.of(context).textTheme.titleMedium),
        gapHNormal,
        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: moments.skip(1).map((moment) => OldMoment(
            moment: moment,
            showAction: () => showMomentDialog(context, moment),
            deleteAction: () => deleteMoment(context, ref, moment),
            favoriteAction: () => toggleFavorite(ref, moment),
          )).toList(),
        )
      ],
    );
  }
}
