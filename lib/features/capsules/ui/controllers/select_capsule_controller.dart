import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'select_capsule_controller.g.dart';

@riverpod
class SelectCapsuleController extends _$SelectCapsuleController{

  @override
  FutureOr<void> build(){

  }

  Future<bool> selectCapsule(int id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(capsuleRepositoryProvider).selectCapsule(id));
    return state.hasError == false;
  }

}