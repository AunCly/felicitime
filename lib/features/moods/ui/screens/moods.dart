import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/moods/ui/widgets/mood_grid.dart';
import 'package:felicitime/features/moods/ui/widgets/mood_selector.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MoodsScreen extends ConsumerStatefulWidget {
  const MoodsScreen({super.key});

  @override
  ConsumerState<MoodsScreen> createState() => _MoodsScreenState();
}

class _MoodsScreenState extends ConsumerState<MoodsScreen> {
  @override
  Widget build(BuildContext context) {

    AsyncValue moods = ref.watch(moodsStreamProvider);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BackHome(),
            Text('Humeurs.', style: Theme.of(context).textTheme.headlineLarge),
            gapHNormal,
            Text('Humeur du jour.', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            MoodSelector(),
            gapHNormal,
            Text('Historique d\'humeur.', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
            AsyncValueWidget(
              value: moods,
              data: (value) => Column(
                children: [
                  MoodGrid(moods: value),
                ],
              )
            ),
          ]
        )
      )
    );
  }
}
