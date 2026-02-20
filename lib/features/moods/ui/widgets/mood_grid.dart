import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/mood.dart';
import 'package:felicitime/features/moods/ui/widgets/month_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../config/colors.dart';
import '../../../../ui/widgets/badge.dart';

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

  List<DateTime> monthsWithMoods(){
    final Set<String> monthKeys = {};
    for (var mood in widget.moods) {
      monthKeys.add('${mood.createdAt.year}-${mood.createdAt.month}');
    }

    List<DateTime> months = [];
    DateTime current = DateTime(startMonth.year, startMonth.month);
    while (current.isBefore(DateTime(today.year, today.month + 1))) {
      if (monthKeys.contains('${current.year}-${current.month}')) {
        months.add(current);
      }
      current = DateTime(current.year, current.month + 1);
    }

    return months.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for(var month in monthsWithMoods()) Column(
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
                  AppBadge(
                    color: AppColors.appPink,
                    text: "${monthNames[month.month]} ${month.year}",
                    textColor: AppColors.appWhite,
                    icon: FontAwesomeIcons.solidCalendar,
                  ),
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
