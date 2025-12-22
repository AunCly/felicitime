import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/select_capsules_controller.dart';
import 'package:felicitime/features/capsules/ui/widgets/capsule_list_tile.dart';
import 'package:felicitime/features/capsules/ui/widgets/validate_capsule.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/button.dart';
import 'package:felicitime/ui/widgets/button_loading.dart';
import 'package:felicitime/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class CapsulesScreen extends ConsumerStatefulWidget {
  const CapsulesScreen({super.key});

  @override
  ConsumerState<CapsulesScreen> createState() => _CapsulesScreenState();
}

class _CapsulesScreenState extends ConsumerState<CapsulesScreen> {

  void selectCapsules() async {
    await ref.read(selectCapsulesControllerProvider.notifier).selectCapsules();
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue capsules = ref.watch(currentCapsulesStreamProvider);
    var state = ref.watch(selectCapsulesControllerProvider);

    ref.listen<AsyncValue>(selectCapsulesControllerProvider, (_, state) {
      state.showSnackBarOnError(context);
      if(!state.isLoading && !state.hasError){
        state.showSnackBarOnSuccess(context, 'Les capsules ont bien été sélectionnées !');
      }
    });

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () => context.pop(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(FontAwesomeIcons.lightHouse, size: 20),
                      gapWNormal,
                      Text('Retour', style: Theme.of(context).textTheme.titleMedium),
                    ],
                  )
                ),
              ]
            ),
            Text('Capsules.', style: Theme.of(context).textTheme.headlineLarge),
            gapHNormal,
            Text('Vos capsules en cours', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            AsyncValueWidget(
              value: capsules,
              data: (value) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for(Capsule capsule in value) Column(
                    children: [
                      CapsuleListTile(capsule: capsule),
                      gapHNormal,
                    ],
                  )
                ]
              ),
            ),
            AppLoadingButton(
              state: state,
              label: 'Relancer la sélection',
              icon: Icons.add_circle_outline,
              onPressed: () => selectCapsules(),
            ),
          ]
        ),
      ),
    );
  }
}
