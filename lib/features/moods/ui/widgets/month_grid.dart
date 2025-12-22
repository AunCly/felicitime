import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/capsules/model/mood.dart';
import 'package:felicitime/features/capsules/ui/controllers/save_mood_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
                        FontAwesomeIcons.lightFaceSadCry,
                        FontAwesomeIcons.lightFaceFrown,
                        FontAwesomeIcons.lightFaceAngry,
                        FontAwesomeIcons.lightFaceMeh,
                        FontAwesomeIcons.lightFaceSmile,
                        FontAwesomeIcons.lightFaceLaugh,
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
                          child: Center(child: Icon(icon, size: 40)),
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

  IconData findMoodIconForDay(int year, int month, int day) {
    Mood? mood = findMoodForDay(year, month, day);

    if(mood == null) {
      return FontAwesomeIcons.lightQuestion;
    }

    return mood.getIcon();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(
        DateTime(widget.month.year, widget.month.month + 1, 0).day,
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
                ) : Icon(findMoodIconForDay(widget.month.year, widget.month.month, day)),
              ),
            ),
          );
        },
      ),
    );
  }
}
