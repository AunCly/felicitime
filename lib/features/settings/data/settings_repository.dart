import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/utils/in_memory_store.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'settings_repository.g.dart';

class SettingsRepository {

  final Ref ref;
  final _theme = InMemoryStore<String>('light');

  SettingsRepository({required this.ref}){
    _theme.value = ref.read(sharedPreferencesProvider).getString('theme') ?? 'light';
  }

  Stream<String> theme() => _theme.stream;

  updateTheme(String theme){
    _theme.value = theme;
    ref.read(sharedPreferencesProvider).setString('theme', theme);
  }
}

@riverpod
SettingsRepository settingsRepository(Ref ref){
  return SettingsRepository(ref: ref);
}

@riverpod
Stream<String> watchTheme(Ref ref) {
  final settingsRepository = ref.watch(settingsRepositoryProvider);
  return settingsRepository.theme();
}