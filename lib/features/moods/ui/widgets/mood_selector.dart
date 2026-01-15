import 'package:felicitime/features/capsules/ui/controllers/save_mood_controller.dart';
import 'package:felicitime/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MoodSelector extends ConsumerStatefulWidget {
  const MoodSelector({super.key});

  @override
  ConsumerState<MoodSelector> createState() => _MoodSelectorState();
}

class _MoodSelectorState extends ConsumerState<MoodSelector> {

  void saveMood(int mood) async {
    ref.read(saveMoodControllerProvider.notifier).saveMood(mood: mood, date: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {

    AsyncValue state = ref.watch(saveMoodControllerProvider);
    ref.listen<AsyncValue>(saveMoodControllerProvider, (_, state) {
      state.showSnackBarOnError(context);
      if(!state.isLoading && !state.hasError){
        state.showSnackBarOnSuccess(context, 'L\'humeur a été enregistrée.');
      }
    });

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        GestureDetector(
          onTap: () => saveMood(1),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset('images/moods/cry.png'),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(2),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset('images/moods/sad.png'),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(3),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset('images/moods/angry.png'),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(4),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Image.asset('images/moods/meh.png'),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(5),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child:  Image.asset('images/moods/happy.png'),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(6),
          child: Container(
            padding: EdgeInsets.all(30),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child:  Image.asset('images/moods/very-happy.png'),
          )
        )
      ],
    );
  }
}
