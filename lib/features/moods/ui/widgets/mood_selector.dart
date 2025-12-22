import 'package:felicitime/features/capsules/ui/controllers/save_mood_controller.dart';
import 'package:felicitime/utils/async_value_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart' show FontAwesomeIcons;

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
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: Icon(FontAwesomeIcons.lightFaceSadCry, size: 50,),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(2),
          child: Container(
            decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(FontAwesomeIcons.lightFaceFrown, size: 50,),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(3),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(FontAwesomeIcons.lightFaceAngry, size: 50,),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(4),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(FontAwesomeIcons.lightFaceMeh, size: 50,),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(5),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(FontAwesomeIcons.lightFaceSmile, size: 50,),
          )
        ),
        GestureDetector(
          onTap: () => saveMood(6),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: const Icon(FontAwesomeIcons.lightFaceLaugh, size: 50,),
          )
        )
      ],
    );
  }
}
