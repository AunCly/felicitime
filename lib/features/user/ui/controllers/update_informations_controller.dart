import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'update_informations_controller.g.dart';

@riverpod
class UpdateInformationsController extends _$UpdateInformationsController {

  @override
  FutureOr<void> build(){
  }

  Future<void> updateInformations({required Map data}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userRepositoryProvider).updateInformations(data: data));
    state.hasError == false;
  }

}