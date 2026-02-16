import 'package:felicitime/ui/widgets/arrow_go.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/config/theme.dart';
import 'package:go_router/go_router.dart';

import '../../../../ui/widgets/async_value_widget.dart';
import '../../../capsules/data/capsule_repository.dart';
import '../../../capsules/model/mood.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {

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
            Text('Besoin d\'un petit moment à vous ?', style: Theme.of(context).textTheme.headlineMedium),
            gapHLarge,
            // AsyncValueWidget(
            //   value: moods,
            //   data: (value) => Row(
            //     children: [
            //       for(var day in lastSevenDays)
            //         Expanded(
            //           child: Container(
            //             width: 50,
            //             margin: const EdgeInsets.only(right: 5),
            //             decoration: BoxDecoration(
            //               color: Theme.of(context).colorScheme.inverseSurface,
            //               borderRadius: const BorderRadius.all(Radius.circular(10)),
            //               border: Border.all(color: Theme.of(context).colorScheme.surface, width: 2),
            //             ),
            //             child: Column(
            //               children: [
            //                 gapHNormal,
            //                 Center(
            //                   child: findMoodForDay(value, day.year, day.month, day.day) == null ? Text(
            //                     '${day.day}', style: Theme.of(context).textTheme.titleSmall,
            //                   ) : findMoodIconForDay(value, day.year, day.month, day.day),
            //                 )
            //               ],
            //             )
            //           ),
            //         )
            //     ]
            //   )
            // ),
            // gapHNormal,
            Column(
              children: [
                GestureDetector(
                  onTap: () => context.push('/capsules'),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF4EE),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
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
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Image.asset('images/capsules.png', height : 200,)
                        ),
                      ],
                    ),
                  ),
                ),
                gapHNormal,
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  children: [
                    GestureDetector(
                      onTap: () => context.push('/moods'),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF4EE),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Text('Humeur.', style: Theme.of(context).textTheme.headlineLarge)
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: AppArrowGo(),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Image.asset('images/moods.png', width: 100,)
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.push('/settings'),
                      child: Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF4EE),
                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 20,
                              left: 20,
                              child: Text('Vous.', style: Theme.of(context).textTheme.headlineLarge)
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: AppArrowGo(),
                            ),
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Image.asset('images/settings.png', width: 100,)
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]
                ),
                gapHNormal,
                GestureDetector(
                  onTap: () => context.push('/moments'),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFF4EE),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Stack(
                      children: [
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
                        Positioned(
                          bottom: 10,
                          right: 10,
                          child: Image.asset('images/moments.png', width: 175,)
                        ),
                      ],
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