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
    ref.read(saveMoodControllerProvider.notifier).saveMood(mood: mood);
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

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.sentiment_very_dissatisfied),
            onPressed: () => saveMood(1),
          ),
          IconButton(
            icon: const Icon(Icons.sentiment_dissatisfied),
            onPressed: () => saveMood(2),
          ),
          IconButton(
            icon: const Icon(Icons.sentiment_neutral),
            onPressed: () => saveMood(3),
          ),
          IconButton(
            icon: const Icon(Icons.sentiment_satisfied),
            onPressed: () => saveMood(4),
          ),
          IconButton(
            icon: const Icon(Icons.sentiment_very_satisfied),
            onPressed: () => saveMood(5),
          ),
        ],
      )
    );
  }
}
