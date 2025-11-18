import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/ui/controllers/select_capsules_controller.dart';
import 'package:felicitime/features/capsules/ui/widgets/capsule_list_tile.dart';
import 'package:felicitime/features/capsules/ui/screens/validate_capsule_widget.dart';
import 'package:felicitime/features/capsules/ui/widgets/moment.dart';
import 'package:felicitime/features/capsules/ui/widgets/mood_selector.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/button_loading.dart';
import 'package:felicitime/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/config/theme.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  void selectCapsules() async {
    await ref.read(selectCapsulesControllerProvider.notifier).selectCapsules();
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue capsules = ref.watch(currentCapsulesStreamProvider);
    AsyncValue capsule = ref.watch(currentCapsuleStreamProvider);
    AsyncValue moments = ref.watch(momentsStreamProvider);
    AsyncValue moods = ref.watch(moodsStreamProvider);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Besoin d\'un petit moment à vous ?', style: Theme.of(context).textTheme.headlineMedium),
            Container(
              height: 5,
              width: 100,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              )
            ),
            gapHNormal,
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text('Les capsules sont des moments de bien-être à vivre seul ou en famille. Choisissez vos capsules pour la période en cours ou découvrez-en de nouvelles !', style: Theme.of(context).textTheme.bodyMedium),
            ),
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
            gapHNormal,
            AppLoadingButton(
              state: state,
              label: 'Sélectionner des capsules',
              icon: Icons.add_circle_outline,
              onPressed: () => selectCapsules(),
            ),
            gapHNormal,
            AsyncValueWidget(
              value: capsule,
              data: (value) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Capsule actuellement sélectionnée', style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  CapsuleListTile(capsule: value),
                ],
              ),
            ),
            gapHNormal,
            Text('Valider ma capsule du jour', style: Theme.of(context).textTheme.titleMedium),
            AsyncValueWidget(
              value: capsule,
              data: (value) => ValidateCapsuleWidget(capsule: value),
            ),
            gapHNormal,
            Text('Mes moments enregistrés', style: Theme.of(context).textTheme.titleMedium),
            AsyncValueWidget(
              value: moments,
              data: (value) {
                if(value.isNotEmpty){
                  return AppMoments(moments: value);
                }
                return Text('Aucun moment enregistré pour le moment.', style: Theme.of(context).textTheme.bodyMedium);
              },
            ),
            gapHNormal,
            Text('Humeur du jour', style: Theme.of(context).textTheme.titleMedium),
            MoodSelector(),
            gapHNormal,
            Text('Historique des humeurs', style: Theme.of(context).textTheme.titleMedium),
            AsyncValueWidget(
              value: moods,
              data: (value) => Column(
                children: [
                  for(var mood in value) ListTile(
                    title: Row(
                      children: [
                        Text('Humeur: '),
                        Icon(mood.getIcon()),
                      ],
                    ),
                    subtitle: Text('Date: ${mood.createdAt.toLocal().toString()}'),
                  )
                ],
              )
            )
          ],
        ),
      )
    );
  }
}