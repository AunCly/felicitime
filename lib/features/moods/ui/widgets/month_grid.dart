import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/mood.dart';
import 'package:felicitime/features/capsules/ui/controllers/save_mood_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MonthGrid extends ConsumerStatefulWidget {
  const MonthGrid({super.key, required this.month, required this.moods});

  final List<Mood> moods;

  final DateTime month;

  @override
  ConsumerState<MonthGrid> createState() => _MonthGridState();
}

class _MonthGridState extends ConsumerState<MonthGrid> {

  void saveMood(int mood, DateTime date) async {
    ref.read(saveMoodControllerProvider.notifier).saveMood(mood: mood, date: date);
  }

  saveDayMood(int year, int month, int day) {

    return showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (BuildContext context){
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min, // important: let dialog size to content
            children: [
              Column(
                children: [
                  Text('Humeur du $day/${month.toString().padLeft(2, '0')}/$year', style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  GridView.count(
                    crossAxisCount: 3,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    padding: EdgeInsets.zero,
                    children: List.generate(6, (i) {
                      final icon = [
                        Image.asset('images/moods/cry.png'),
                        Image.asset('images/moods/sad.png'),
                        Image.asset('images/moods/angry.png'),
                        Image.asset('images/moods/meh.png'),
                        Image.asset('images/moods/happy.png'),
                        Image.asset('images/moods/very-happy.png'),
                      ][i];
                      final moodValue = i + 1;
                      return Material(
                        color: Theme.of(context).colorScheme.inverseSurface,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            saveMood(moodValue, DateTime(year, month, day));
                            Navigator.of(context).pop(); // close dialog after selection
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            child: icon
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        );
      }
    );
  }

  Mood? findMoodForDay(int year, int month, int day) {
    for(var mood in widget.moods) {
      if(mood.createdAt.year == year &&
         mood.createdAt.month == month &&
         mood.createdAt.day == day) {
        return mood;
      }
    }
    return null;
  }

  Image findMoodIconForDay(int year, int month, int day) {
    Mood? mood = findMoodForDay(year, month, day);

    if(mood == null) {
      return Image.asset('images/moods/meh.png');
    }

    return mood.getIcon();
  }

  @override
  Widget build(BuildContext context) {
    final dayLabels = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    final firstWeekday = DateTime(widget.month.year, widget.month.month, 1).weekday; // 1=Monday
    final daysInMonth = DateTime(widget.month.year, widget.month.month + 1, 0).day;
    final offset = firstWeekday - 1; // empty cells before the 1st

    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        // Header row with day letters
        for (var label in dayLabels)
          Center(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.bold)),
          ),
        // Empty cells to align the 1st day to the correct column
        for (var i = 0; i < offset; i++)
          const SizedBox.shrink(),
        // Day cells
        ...List.generate(
          daysInMonth,
          (index) {
            final day = index + 1;
            return GestureDetector(
              onTap: () => saveDayMood(widget.month.year, widget.month.month, day),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: findMoodForDay(widget.month.year, widget.month.month, day) == null ? Text(
                    '$day', style: Theme.of(context).textTheme.bodySmall,
                  ) : findMoodIconForDay(widget.month.year, widget.month.month, day),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
