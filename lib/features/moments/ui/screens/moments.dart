import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:felicitime/features/moments/ui/widgets/moment.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/back_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MomentsScreen extends ConsumerStatefulWidget {
  const MomentsScreen({super.key});

  @override
  ConsumerState<MomentsScreen> createState() => _MomentsScreenState();
}

class _MomentsScreenState extends ConsumerState<MomentsScreen> {
  @override
  Widget build(BuildContext context) {

    AsyncValue moments = ref.watch(momentsStreamProvider);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BackHome(),
            Text('Moments.', style: Theme.of(context).textTheme.headlineLarge),
            gapHNormal,
            Text('Mes moments enregistrés.', style: Theme.of(context).textTheme.titleMedium),
            gapHNormal,
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
          ]
        )
      )
    );
  }
}
