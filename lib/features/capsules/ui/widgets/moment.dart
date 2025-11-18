import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:flutter/material.dart';

class AppMoments extends StatelessWidget {
  const AppMoments({super.key, required this.moments});

  final List<Moment> moments;

  @override
  Widget build(BuildContext context) {

    print("Loaded selected capsules from storage: $moments");

    return Column(
      children: [
        for (Moment moment in moments)
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Capsule: ${moment.capsule.title}'),
                Text('Created At: ${moment.createdAt.toLocal().toString()}'),
                Text('Number of Media: ${moment.medias.length}'),
              ],
            ),
          )
      ],
    );
  }
}
