import 'package:felicitime/ui/widgets/arrow_go.dart';
import 'package:felicitime/ui/widgets/version.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/config/theme.dart';
import 'package:go_router/go_router.dart';

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
            Text('Besoin d\'un petit moment à vous ?', style: Theme.of(context).textTheme.headlineMedium),
            gapHLarge,
            Column(
              children: [
                GestureDetector(
                  onTap: () => context.push('/capsules'),
                  child: Container(
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
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
                          child: Image.asset('images/felicitime-3.png', width: 175,)
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
                          color: Theme.of(context).colorScheme.surface,
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
                              child: Image.asset('images/felicitime-7.png', width: 100,)
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
                          color: Theme.of(context).colorScheme.surface,
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
                              child: Image.asset('images/felicitime-1.png', width: 100,)
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
                      color: Theme.of(context).colorScheme.surface,
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
                          child: Image.asset('images/felicitime-5.png', width: 175,)
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