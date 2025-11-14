import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reset_tutorial_controller.g.dart';

@riverpod
class ResetTutorialController extends _$ResetTutorialController {

  @override
  FutureOr<void> build(){
  }

  Future<void> resetTutorial() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userRepositoryProvider).resetTutorial());
    state.hasError == false;
  }

}