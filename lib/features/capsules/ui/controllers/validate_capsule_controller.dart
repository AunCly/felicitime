import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'validate_capsule_controller.g.dart';

@riverpod
class ValidateCapsuleController extends _$ValidateCapsuleController{

  @override
  FutureOr<void> build(){

  }

  Future<bool> validateCapsule({required Map data}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(capsuleRepositoryProvider).validateCapsule(data : data));
    return state.hasError == false;
  }

}