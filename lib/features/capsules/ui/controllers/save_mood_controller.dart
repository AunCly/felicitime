import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'save_mood_controller.g.dart';

@riverpod
class SaveMoodController extends _$SaveMoodController{

  @override
  FutureOr<void> build(){

  }

  Future<bool> saveMood({required int mood, DateTime? date}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(capsuleRepositoryProvider).saveMood(moodValue: mood, date: date));
    return state.hasError == false;
  }

}