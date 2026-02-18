import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/select_capsule_controller.dart';
import 'package:felicitime/features/capsules/ui/screens/validate_capsule.dart';
import 'package:felicitime/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

    return GestureDetector(
      onTap: () => showValidationDialog(),
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
                    if(widget.capsule.tags.contains('price_all')) AppBadge(
                      icon: FontAwesomeIcons.lightCoins,
                      text:  'Gratuit',
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    if(widget.capsule.tags.contains('family_all')) AppBadge(
                      icon: FontAwesomeIcons.lightUsers,
                      text: 'Seul, en famille ou entre amis',
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                    if(widget.capsule.tags.contains('season_all')) AppBadge(
                      icon: FontAwesomeIcons.lightWheat,
                      text:  'Toute l\'annnée',
                      color: Theme.of(context).colorScheme.primary,
                      textColor: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ]
                )
              ],
            ),
            Positioned(
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
