import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_capsules_controller.g.dart';

@riverpod
class SelectCapsulesController extends _$SelectCapsulesController{

  @override
  FutureOr<void> build(){

  }

  Future<bool> selectCapsules() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(capsuleRepositoryProvider).selectCapsulesForCurrentPeriod());
    return state.hasError == false;
  }

}