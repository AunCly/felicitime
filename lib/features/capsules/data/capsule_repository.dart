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
        _moments.value = [..._moments.value, Moment.fromJson(jsonDecode(momentStr))];
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

    for(Capsule capsule in AppCapsules.capsules){
      if(selectedCapsules.contains(capsule.id.toString())){
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

  Future<void> selectCapsulesForCurrentPeriod() async {
    AppCapsules.capsules.shuffle();
    var randomCapsules = AppCapsules.capsules.toList();

    var family_n_friend = ref.read(sharedPreferencesProvider).getString('family_n_friend') ?? 'family_all';
    var money = ref.read(sharedPreferencesProvider).getString('money') ?? 'money_all';

    if(family_n_friend == 'family_near'){
      randomCapsules.where((capsule) => capsule.tags.contains('family_far') || capsule.tags.contains('friend_only'));
    } else if(family_n_friend == 'family_no'){
      randomCapsules.where((capsule) => capsule.tags.contains('family_no'));
    }

    if(money == 'money_little'){
      randomCapsules.where((capsule) => capsule.tags.contains('money_little') || capsule.tags.contains('money_free'));
    } else if(money == 'money_free'){
      randomCapsules.where((capsule) => capsule.tags.contains('money_free'));
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

    List<String> moments = ref.read(sharedPreferencesProvider).getStringList('moments') ?? [];
    moments.add(jsonEncode(moment.toJson()));
    ref.read(sharedPreferencesProvider).setStringList('moments', moments);
    _moments.value = [..._moments.value, moment];
    _moments.value.sort((a, b) => b.createdAt.compareTo(a.createdAt));
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