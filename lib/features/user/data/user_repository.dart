import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:felicitime/features/user/model/user.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository.g.dart';

class UserRepository {

  final Ref ref;
  final _user = InMemoryStore<User?>(null);
  final _syncImages = InMemoryStore<bool>(false);
  final _advancedModeEnabled = InMemoryStore<bool?>(null);

  UserRepository({required this.ref});

  User? get currentUser => _user.value;
  Stream<User?> userStateChanges() => _user.stream;
  Stream<bool> syncImagesSetting() => _syncImages.stream;
  Stream<bool?> advancedModeEnabled() => _advancedModeEnabled.stream;
  Stream<User?> meStream() => _user.stream;

  Future<User> getMe() async {
    if(_user.value != null){
      return Future.value(_user.value);
    } else {
      String? pseudo = ref.read(sharedPreferencesProvider).getString('avatar') ?? 'PommeDePain';
      return User(pseudo: pseudo);
    }
  }

  Future<void> removeMe() async {
    _user.value = null;
  }

  Future<void> resetTutorial() async {
    ref.read(sharedPreferencesProvider).remove('onboarding');
    ref.read(sharedPreferencesProvider).remove('onboarding_diagnosis');
  }

  Future<void> deleteAccount() async {
    try{
      _user.value = null;
      // Todo delete datas
    }
    catch(e){
      throw Exception(e);
    }
  }

  Future<void> updateInformations({required Map data}) async {
    try{
      ref.read(sharedPreferencesProvider).setString('avatar', data['pseudo']);
    }
    catch(e){
      throw Exception(e);
    }
  }

}

@riverpod
UserRepository userRepository(Ref ref){
  return UserRepository(ref: ref);
}

@riverpod
Stream<User?> userStateChanges(Ref ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return userRepository.userStateChanges();
}

@riverpod
Future<User> getMe(Ref ref){
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.getMe();
}

@riverpod
User? getMeTest(Ref ref){
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.currentUser;
}

@riverpod
Future<void> removeMe(Ref ref){
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.removeMe();
}

@riverpod
Stream<User?> getMeStream(Ref ref){
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.meStream();
}


@riverpod
Stream<bool?> getAdvancedModeEnabled(Ref ref){
  final userRepository = ref.read(userRepositoryProvider);
  return userRepository.advancedModeEnabled();
}
