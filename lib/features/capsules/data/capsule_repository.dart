import 'dart:convert';

import 'package:felicitime/config/capsules.dart';
import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/capsules/model/mood.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'capsule_repository.g.dart';

class CapsuleRepository {

  final Ref ref;
  final _capsules = InMemoryStore<List<Capsule>>([]);
  final _capsule = InMemoryStore<Capsule?>(null);
  final _moments = InMemoryStore<List<Moment>>([]);
  final _moods = InMemoryStore<List<Mood>>([]);

  CapsuleRepository({required this.ref}){

    var moments = ref.read(sharedPreferencesProvider).getStringList('moments');
    var moods = ref.read(sharedPreferencesProvider).getStringList('moods');
    var selectedCapsules = ref.read(sharedPreferencesProvider).getStringList('selected_capsules');
    var selectedCapsule = ref.read(sharedPreferencesProvider).getString('selected_capsule');

    if(moments != null){
      for(String momentStr in moments){
        Capsule capsule = AppCapsules.capsules.firstWhere((c) => c.id == jsonDecode(momentStr)['capsule_id']);
        _moments.value = [..._moments.value, Moment.fromJson(jsonDecode(momentStr), capsule)];
      }

      // sort moments by createdAt descending
      _moments.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    if(moods != null){
      for(String moodStr in moods){
        _moods.value = [..._moods.value, Mood.fromJson(jsonDecode(moodStr))];
      }
    }

    if(selectedCapsule != null){
      _capsule.value = Capsule.fromJson(jsonDecode(selectedCapsule));
    }

    if(selectedCapsules == null){
      return;
    }

    // Collect validated capsule IDs from moments saved during the current period
    Set<int> validatedCapsuleIds = {};
    var selectionDate = ref.read(sharedPreferencesProvider).getString('selection_date');
    if(selectionDate != null){
      DateTime lastSelectionDate = DateTime.parse(selectionDate);
      for(var moment in _moments.value){
        if(moment.createdAt.isAfter(lastSelectionDate)){
          validatedCapsuleIds.add(moment.capsule.id);
        }
      }
    }

    for(Capsule capsule in AppCapsules.capsules){
      if(selectedCapsules.contains(capsule.id.toString())){
        capsule.isValidated = validatedCapsuleIds.contains(capsule.id);
        _capsules.value = [..._capsules.value, capsule];
      }
    }
  }

  Stream<List<Capsule>> currentCapsulesStream() => _capsules.stream;
  Stream<Capsule?> currentCapsuleStream() => _capsule.stream;
  Stream<List<Moment>> momentsStream() => _moments.stream;
  Stream<List<Mood>> moodsStream() => _moods.stream;

  void getRandomCapsules() async {
    AppCapsules.capsules.shuffle();
    _capsules.value = AppCapsules.capsules.take(2).toList();
  }

  String getCurrentSeason() {
    final month = DateTime.now().month;
    if (month >= 3 && month <= 5) return 'season_spring';
    if (month >= 6 && month <= 8) return 'season_summer';
    if (month >= 9 && month <= 11) return 'season_autumn';
    return 'season_winter';
  }

  Future<void> selectCapsulesForCurrentPeriod() async {
    AppCapsules.capsules.shuffle();
    var randomCapsules = AppCapsules.capsules.toList();

    var familyAndFriend = ref.read(sharedPreferencesProvider).getString('family_n_friend') ?? 'family_all';
    var money = ref.read(sharedPreferencesProvider).getString('money') ?? 'money_all';

    if(familyAndFriend == 'family_near'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('family_near') || capsule.tags.contains('family_all')).toList();
    } else if(familyAndFriend == 'family_no'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('family_no') || capsule.tags.contains('family_all')).toList();
    }

    if(money == 'price_little'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('price_little') || capsule.tags.contains('price_free') || capsule.tags.contains('price_all')).toList();
    } else if(money == 'price_free'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('price_free') || capsule.tags.contains('price_all')).toList();
    }

    var currentSeason = getCurrentSeason();
    if(currentSeason == 'season_spring'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('season_spring') || capsule.tags.contains('season_all')).toList();
    } else if(currentSeason == 'season_summer'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('season_summer') || capsule.tags.contains('season_all')).toList();
    } else if(currentSeason == 'season_autumn'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('season_autumn') || capsule.tags.contains('season_all')).toList();
    } else if(currentSeason == 'season_winter'){
      randomCapsules = randomCapsules.where((capsule) => capsule.tags.contains('season_winter') || capsule.tags.contains('season_all')).toList();
    }

    randomCapsules = randomCapsules.take(3).toList();

    var selectionDate = ref.read(sharedPreferencesProvider).getString('selection_date');

    if(selectionDate != null){
      DateTime lastSelectionDate = DateTime.parse(selectionDate);
      DateTime now = DateTime.now();
      Duration difference = now.difference(lastSelectionDate);

      String? settingsRecurrence = ref.read(sharedPreferencesProvider).getString('selection_recurrence');
      int recurrence = 7;

      if(settingsRecurrence != null) {
        if(settingsRecurrence == 'day'){
          recurrence = 1;
        } else if(settingsRecurrence == 'weekly'){
          recurrence = 7;
        } else if(settingsRecurrence == 'monthly'){
          recurrence = 30;
        }
      }

      if(difference.inDays < recurrence){
        // Selection is still valid
        throw Exception('Selection is still valid for today.');
      }
    }

    ref.read(sharedPreferencesProvider).setString('selection_date', DateTime.now().toIso8601String());
    ref.read(sharedPreferencesProvider).setStringList('selected_capsules', randomCapsules.map((c) => c.id.toString()).toList());
    _capsules.value = randomCapsules;
    return;

  }

  Future<void> selectCapsule(int id) async {
    Capsule capsule = AppCapsules.capsules.firstWhere((c) => c.id == id);
    ref.read(sharedPreferencesProvider).setString('selected_capsule', jsonEncode(capsule.toJson()));
    _capsule.value = capsule;
  }

  Future<void> validateCapsule({required Map data}) async {

    Moment moment = Moment(
      capsule: data['capsule'],
      createdAt: DateTime.now(),
      medias: data['medias'],
      comment: data['comment'] ?? '',
    );

    _capsules.value = _capsules.value.map((c) {
      if(c.id == moment.capsule.id){
        c.isValidated = true;
      }
      return c;
    }).toList();

    ref.read(sharedPreferencesProvider).setStringList('selected_capsules', _capsules.value.map((c) => c.id.toString()).toList());

    List<String> moments = ref.read(sharedPreferencesProvider).getStringList('moments') ?? [];
    moments.add(jsonEncode(moment.toJson()));
    ref.read(sharedPreferencesProvider).setStringList('moments', moments);
    _moments.value = [..._moments.value, moment];
    _moments.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> deleteMoment(Moment moment) async {

    List<String> moments = ref.read(sharedPreferencesProvider).getStringList('moments') ?? [];

    moments.removeWhere((momentStr) {
      final decoded = jsonDecode(momentStr);
      return decoded['created_at'] == moment.createdAt.toIso8601String() && decoded['capsule_id'] == moment.capsule.id;
    });

    ref.read(sharedPreferencesProvider).setStringList('moments', moments);

    _moments.value = _moments.value.where((m) => !(m.createdAt == moment.createdAt && m.capsule.id == moment.capsule.id)).toList();

    // Reset capsule validation status
    _capsules.value = _capsules.value.map((c) {
      if (c.id == moment.capsule.id) {
        c.isValidated = false;
      }
      return c;
    }).toList();

  }

  Future<void> updateMoment({required Moment moment, required Map data}) async {
    moment.medias = data['medias'];
    moment.comment = data['comment'] ?? '';
    if (data['date'] != null) {
      moment.createdAt = DateTime.parse(data['date']);
    }

    // Update in SharedPreferences
    List<String> moments = ref.read(sharedPreferencesProvider).getStringList('moments') ?? [];
    moments = moments.map((momentStr) {
      final decoded = jsonDecode(momentStr);
      if (decoded['created_at'] == moment.createdAt.toIso8601String() && decoded['capsule_id'] == moment.capsule.id) {
        return jsonEncode(moment.toJson());
      }
      return momentStr;
    }).toList();
    ref.read(sharedPreferencesProvider).setStringList('moments', moments);

    _moments.value = [..._moments.value];
  }

  Future<void> toggleFavorite(Moment moment) async {
    moment.isFavorite = !moment.isFavorite;

    // Update in SharedPreferences
    List<String> moments = ref.read(sharedPreferencesProvider).getStringList('moments') ?? [];
    moments = moments.map((momentStr) {
      final decoded = jsonDecode(momentStr);
      if (decoded['created_at'] == moment.createdAt.toIso8601String() && decoded['capsule_id'] == moment.capsule.id) {
        decoded['is_favorite'] = moment.isFavorite;
        return jsonEncode(decoded);
      }
      return momentStr;
    }).toList();
    ref.read(sharedPreferencesProvider).setStringList('moments', moments);

    // Trigger stream update
    _moments.value = [..._moments.value];
  }

  Future<void> saveMood({required int moodValue, DateTime? date}) async {

    Mood mood = Mood(
      createdAt: date ?? DateTime.now(),
      mood: moodValue,
    );

    List<String> moods = ref.read(sharedPreferencesProvider).getStringList('moods') ?? [];

    if(moods.isNotEmpty){

      List<String> moodsCopy = List<String>.from(moods);

      // check if there is already a mood for today
      DateTime now = date ?? DateTime.now();

      for(String moodStr in moods){
        Mood existingMood = Mood.fromJson(jsonDecode(moodStr));
        if(existingMood.createdAt.year == now.year && existingMood.createdAt.month == now.month && existingMood.createdAt.day == now.day && existingMood.mood != moodValue) {
          moodsCopy.remove(moodStr);
        }
      }

      moods = moodsCopy;

    }

    moods.add(jsonEncode(mood.toJson()));
    ref.read(sharedPreferencesProvider).setStringList('moods', moods);
    _moods.value = moods.map((moodStr) => Mood.fromJson(jsonDecode(moodStr))).toList();
  }

  Future<void> clearAllData() async {
    // Clear from shared preferences
    await ref.read(sharedPreferencesProvider).remove('moments');
    await ref.read(sharedPreferencesProvider).remove('moods');
    await ref.read(sharedPreferencesProvider).remove('selected_capsules');
    await ref.read(sharedPreferencesProvider).remove('selected_capsule');
    await ref.read(sharedPreferencesProvider).remove('selection_date');

    // Clear in-memory stores
    _moments.value = [];
    _moods.value = [];
    _capsules.value = [];
    _capsule.value = null;
  }

}

@riverpod
CapsuleRepository capsuleRepository(Ref ref){
  return CapsuleRepository(ref: ref);
}

@riverpod
Stream<List<Capsule>> currentCapsulesStream(Ref ref) {
  final capsuleRepository = ref.read(capsuleRepositoryProvider);
  return capsuleRepository.currentCapsulesStream();
}

@riverpod
Stream<Capsule?> currentCapsuleStream(Ref ref) {
  final capsuleRepository = ref.read(capsuleRepositoryProvider);
  return capsuleRepository.currentCapsuleStream();
}

@riverpod
Stream<List<Moment>> momentsStream(Ref ref) {
  final capsuleRepository = ref.read(capsuleRepositoryProvider);
  return capsuleRepository.momentsStream();
}

@riverpod
Stream<List<Mood>> moodsStream(Ref ref) {
  final capsuleRepository = ref.read(capsuleRepositoryProvider);
  return capsuleRepository.moodsStream();
}