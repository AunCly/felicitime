import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/select_capsule_controller.dart';
import 'package:felicitime/features/capsules/ui/screens/validate_capsule.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/button.dart';
import 'package:felicitime/ui/widgets/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

  showValidationDialog(Capsule capsule){
    showGeneralDialog(
      transitionDuration: const Duration(milliseconds: 400),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Dialog.fullscreen(
          child: AppDialog(
            title: 'Moment',
            content: ValidateCapsule(capsule: capsule)
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

    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.capsule.title, style: Theme.of(context).textTheme.titleMedium),
          gapHNormal,
          Text(widget.capsule.description, style: Theme.of(context).textTheme.bodyMedium),
          gapHNormal,
          if(widget.canValidate) Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Spacer(),
              AppButton(
                text: 'Valider la capsule',
                icon: FontAwesomeIcons.lightImagePolaroid,
                onPressed: () => showValidationDialog(widget.capsule),
              ),
            ],
          ),
        ]
      ),
    );
  }
}
