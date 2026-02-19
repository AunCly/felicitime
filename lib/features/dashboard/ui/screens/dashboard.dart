import 'dart:ui';

import 'package:felicitime/ui/widgets/arrow_go.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/config/theme.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/colors.dart';
import '../../../../ui/widgets/async_value_widget.dart';
import '../../../capsules/data/capsule_repository.dart';
import '../../../capsules/model/mood.dart';
import '../../../capsules/ui/controllers/save_mood_controller.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

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

  Mood? findMoodForDay(List<Mood> moods, int year, int month, int day) {
    for(var mood in moods) {
      if(mood.createdAt.year == year &&
          mood.createdAt.month == month &&
          mood.createdAt.day == day) {
        return mood;
      }
    }
    return null;
  }

  Image findMoodIconForDay(List<Mood> moods, int year, int month, int day) {
    Mood? mood = findMoodForDay(moods, year, month, day);

    if(mood == null) {
      return Image.asset('images/moods/meh.png', width: 20,);
    }

    return mood.getIcon();
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue moods = ref.watch(moodsStreamProvider);
    List lastSevenDays = List.generate(5, (index) => DateTime.now().subtract(Duration(days: 4 - index)));
    List days = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];

    return SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Text('Hello, ', style: Theme.of(context).textTheme.headlineMedium),
                      Text('Auncly.', style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.appPink, fontWeight: FontWeight.bold)),
                    ]
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/settings'),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(FontAwesomeIcons.lightSlidersUp, size: 20),
                    )
                  ),
                ],
              ),
              gapHLarge,
              Row(
                children: [
                  Text('Humeurs.', style: Theme.of(context).textTheme.titleMedium),
                  Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/moods'),
                    child: AppArrowGo(),
                  ),
                ],
              ),
              gapHLarge,
              AsyncValueWidget(
                value: moods,
                data: (value) => Row(
                  children: [
                    for(var day in lastSevenDays)
                      Expanded(
                        child: GestureDetector(
                          onTap: () => saveDayMood(day.year, day.month, day.day),
                          child: Container(
                            width: 50,
                            height: 80,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.inverseSurface,
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              border: Border.all(color: Theme.of(context).colorScheme.surface, width: 1),
                            ),
                            child: Column(
                              children: [
                                gapHNormal,
                                Center(
                                  child: findMoodForDay(value, day.year, day.month, day.day) == null ? SizedBox(
                                    height: 30,
                                    child: Text(
                                      '${day.day}', style: Theme.of(context).textTheme.bodyLarge,
                                    ),
                                  ) : findMoodIconForDay(value, day.year, day.month, day.day),
                                ),
                                gapHNormal,
                                Text(days[day.weekday - 1], style: Theme.of(context).textTheme.titleSmall),
                              ],
                            )
                          ),
                        ),
                      )
                  ]
                )
              ),
              gapHNormal,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Besoin de souffler ?', style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  GestureDetector(
                    onTap: () => context.push('/capsules'),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF4EE),
                          image: const DecorationImage(
                            image: AssetImage('images/capsules.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(color: AppColors.appGrey.withValues(alpha: 0.1)),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Text('Capsules.', style: Theme.of(context).textTheme.headlineLarge)
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: AppArrowGo(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  gapHNormal,
                  Text('Les bon instant passés.', style: Theme.of(context).textTheme.titleMedium),
                  gapHNormal,
                  GestureDetector(
                    onTap: () => context.push('/moments'),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        height: 250,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF4EE),
                          image: const DecorationImage(
                            image: AssetImage('images/memories.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: Container(color: AppColors.appGrey.withValues(alpha: 0.1)),
                              ),
                            ),
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Text('Moments.', style: Theme.of(context).textTheme.headlineLarge)
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: AppArrowGo(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ],
          ),
        )
    );
  }
}