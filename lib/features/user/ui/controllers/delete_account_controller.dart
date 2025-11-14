import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'delete_account_controller.g.dart';

@riverpod
class DeleteAccountController extends _$DeleteAccountController {

  @override
  FutureOr<void> build(){
  }

  Future<void> deleteAccount() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => ref.read(userRepositoryProvider).deleteAccount());
    state.hasError == false;
  }

}