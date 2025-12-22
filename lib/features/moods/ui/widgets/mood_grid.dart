import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/mood.dart';
import 'package:felicitime/features/moods/ui/widgets/month_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodGrid extends ConsumerStatefulWidget {
  const MoodGrid({super.key, required this.moods});

  final List<Mood> moods;

  @override
  ConsumerState<MoodGrid> createState() => _MoodGridState();
}

class _MoodGridState extends ConsumerState<MoodGrid> {

  var startMonth = DateTime.parse('2024-09-01');
  var today = DateTime.now();
  Map<int, String> monthNames = {
    1: 'Janvier',
    2: 'Février',
    3: 'Mars',
    4: 'Avril',
    5: 'Mai',
    6: 'Juin',
    7: 'Juillet',
    8: 'Août',
    9: 'Septembre',
    10: 'Octobre',
    11: 'Novembre',
    12: 'Décembre',
  };

  monthListFromStart(){
    List<DateTime> months = [];
    DateTime current = DateTime(startMonth.year, startMonth.month);
    while (current.isBefore(DateTime(today.year, today.month + 1))) {
      months.add(current);
      current = DateTime(current.year, current.month + 1);
    }

    // reverse the list to have the most recent month first
    months = months.reversed.toList();

    return months;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var month in monthListFromStart()) Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${monthNames[month.month]} ${month.year}', style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  MonthGrid(month: month, moods: widget.moods),
                ],
              )
            ),
            gapHNormal
          ],
        )
      ]
    );
  }
}
