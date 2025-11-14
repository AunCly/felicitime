import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('A quoi on joue aujourd\'hui ?', style: Theme.of(context).textTheme.headlineMedium),
            Container(
              height: 5,
              width: 100,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: const BorderRadius.all(Radius.circular(20)),
              )
            ),
            gapHLarge,
            Row(
              children: [
                Text('Les derniers jeux ajoutés', style: Theme.of(context).textTheme.titleMedium),
                const Spacer(),
                TextButton(
                  onPressed: () => context.push('/games'),
                  child: Text('Voir tout', style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.secondary)),
                )
              ],
            ),
            gapHNormal,
            /*
            AsyncValueWidget(
              value: games,
              data: (value) => Column(
                children: [
                  for(Game game in value) Column(
                    children: [
                      AppGameTile(game: game),
                      gapHNormal
                    ],
                  )
                ]
              ),
            )*/
          ],
        ),
      )
    );
  }
}