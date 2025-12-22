import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_controller.g.dart';

@riverpod
class SettingsController extends _$SettingsController {

  @override
  FutureOr<void> build(){
  }

  Future<void> setSettings(String key, value) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userRepositoryProvider).setSettings(key, value));
    state.hasError == false;
  }

}