import 'dart:convert';

import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:felicitime/features/capsules/model/moment.dart';
import 'package:felicitime/features/capsules/model/mood.dart';
import 'package:felicitime/features/picture/models/image.dart';
import 'package:felicitime/main.dart';
import 'package:felicitime/utils/in_memory_store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'capsule_repository.g.dart';

class CapsuleRepository {

  List<Capsule> capsules = [
    Capsule(
      id: 1,
      title: "Prendre en photo un papillon",
      description: "This is the first capsule.",
      duration: Duration(minutes: 60),
      tags: ["relaxation", "focus"],
    ),
    Capsule(
      id: 2,
      title: "Cuisiner un gateau",
      description: "This is the second capsule.",
      duration: Duration(minutes: 5),
      tags: ["relaxation", "focus"],
    ),
    Capsule(
      id: 3,
      title: "Ecrire un petit poême",
      description: "This is the third capsule.",
      duration: Duration(minutes: 15),
      tags: ["meditation", "stress relief"],
    ),
    Capsule(
      id: 4,
      title: "Prendre un café au soleil",
      description: "This is the third capsule.",
      duration: Duration(minutes: 5),
      tags: ["meditation", "stress relief"],
    ),
  ];

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

    for(Capsule capsule in capsules){
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
    capsules.shuffle();
    _capsules.value = capsules.take(2).toList();
  }

  Future<void> selectCapsulesForCurrentPeriod() async {
    capsules.shuffle();

    var randomCapsules = capsules.take(2).toList();
    var selectionDate = ref.read(sharedPreferencesProvider).getString('selection_date');

    print("Checking selection date: $selectionDate");

    if(selectionDate != null){
      DateTime lastSelectionDate = DateTime.parse(selectionDate);
      DateTime now = DateTime.now();
      Duration difference = now.difference(lastSelectionDate);

      print("Last selection date: $lastSelectionDate, now: $now, difference in days: ${difference.inDays}");

      if(difference.inDays < 1){
        // Selection is still valid
        throw Exception('Selection is still valid for today.');
      }
    }

    print("Selecting new capsules for the current period: $randomCapsules");

    ref.read(sharedPreferencesProvider).setString('selection_date', DateTime.now().toIso8601String());
    ref.read(sharedPreferencesProvider).setStringList('selected_capsules', randomCapsules.map((c) => c.id.toString()).toList());
    _capsules.value = randomCapsules;
    return;

  }

  Future<void> selectCapsule(int id) async {
    print("Selecting capsule with id: $id");
    Capsule capsule = capsules.firstWhere((c) => c.id == id);
    ref.read(sharedPreferencesProvider).setString('selected_capsule', jsonEncode(capsule.toJson()));
    _capsule.value = capsule;
  }

  Future<void> validateCapsule({required Map data}) async {

    print("Validating capsule with data: $data");

    Moment moment = Moment(
      capsule: _capsule.value!,
      createdAt: DateTime.now(),
      medias: data['medias'],
    );
    print("capsule saved");
    print(moment.toJson());
    List<String> moments = ref.read(sharedPreferencesProvider).getStringList('moments') ?? [];
    moments.add(jsonEncode(moment.toJson()));
    ref.read(sharedPreferencesProvider).setStringList('moments', moments);
    _moments.value = [..._moments.value, moment];
  }

  Future<void> saveMood({required int moodValue}) async {

    print("Saving mood with data: $moodValue");

    Mood mood = Mood(
      createdAt: DateTime.now(),
      mood: moodValue,
    );

    print("mood saved");
    print(mood.toJson());
    List<String> moods = ref.read(sharedPreferencesProvider).getStringList('moods') ?? [];

    if(moods.isNotEmpty){

      print("Checking for existing mood for today.");

      List<String> moodsCopy = List<String>.from(moods);
      print("Current moods: $moodsCopy");

      // check if there is already a mood for today
      DateTime now = DateTime.now();
      for(String moodStr in moods){
        Mood existingMood = Mood.fromJson(jsonDecode(moodStr));
        if(existingMood.createdAt.year == now.year && existingMood.createdAt.month == now.month && existingMood.createdAt.day == now.day) {
          print("Mood for today already exists, updating it.");
          moodsCopy.remove(moodStr);
          print("Updated moods: $moodsCopy");
          break;
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