import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/select_capsule_controller.dart';
import 'package:felicitime/features/capsules/ui/screens/validate_capsule.dart';
import 'package:felicitime/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/colors.dart';
import '../../../../ui/widgets/arrow_go.dart';
import '../../../../ui/widgets/badge.dart';

class CapsuleListTile extends ConsumerStatefulWidget {
  const CapsuleListTile({super.key, required this.capsule, this.canValidate = true});

  final Capsule capsule;
  final bool canValidate;

  @override
  ConsumerState<CapsuleListTile> createState() => _CapsuleListTileState();
}

class _CapsuleListTileState extends ConsumerState<CapsuleListTile> {

  selectCapsule(int id) async {
    ref.read(selectCapsuleControllerProvider.notifier).selectCapsule(id);
  }

  showValidationDialog(){
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dialog.fullscreen(
          child: AppDialog(
            title: 'Enregistrer le moment',
            content: ValidateCapsule(capsule: widget.capsule)
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

    Map<String, String> tagTitles = {
      'price_all': 'Gratuit',
      'price_little': 'Quelques euros',
      'price_high': 'Payant',
      'family_all': 'Seul, en famille ou entre amis',
      'family_no': 'Seul',
      'family_yes': 'En famille ou entre amis',
      'season_all': 'Toute l\'année',
      'season_spring': 'Printemps',
      'season_summer': 'Été',
      'season_autumn': 'Automne',
      'season_winter': 'Hiver',
    };

    return GestureDetector(
      onTap: () => (!widget.capsule.isValidated && widget.canValidate == true) ? showValidationDialog() : null,
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.capsule.title, style: Theme.of(context).textTheme.titleMedium),
                gapHNormal,
                Text(widget.capsule.description, style: Theme.of(context).textTheme.bodyMedium),
                if(widget.capsule.isValidated && widget.canValidate == true) ...[
                  gapHSmall,
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.solidCircleCheck, color: Theme.of(context).colorScheme.primary, size: 16,),
                      gapWNormal,
                      Text('Capsule validée', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
                    ],
                  ),
                ],
                gapHNormal,
                Wrap(
                  spacing: 5,
                  runSpacing: 5,
                  children: [
                    for(String tag in widget.capsule.tags) AppBadge(
                      icon: tag.contains('price_') ? FontAwesomeIcons.solidCoins : (tag.contains('family_') ? FontAwesomeIcons.solidUsers : (tag.contains('season_') ? FontAwesomeIcons.solidWheat : FontAwesomeIcons.solidCoins)),
                      text: tagTitles[tag] ?? tag,
                      color: tag.contains('price_') ? AppColors.appYellow : (tag.contains('family_') ? AppColors.appPink : (tag.contains('season_') ? AppColors.appOrange : AppColors.appPurple)),
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ]
                )
              ],
            ),
            if(!widget.capsule.isValidated && widget.canValidate == true) Positioned(
              top: 0,
              right: 0,
              child: AppArrowGo(),
            ),
          ],
        ),
      ),
    );
  }
}
