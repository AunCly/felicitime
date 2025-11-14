import 'package:felicitime/features/capsules/model/capsule.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'capsule_repository.g.dart';

class CapsuleRepository {

  List<Capsule> capsules = [
    Capsule(
      id: 1,
      title: "Capsule One",
      description: "This is the first capsule.",
      duration: Duration(minutes: 60),
      tags: ["relaxation", "focus"],
    ),
    Capsule(
      id: 2,
      title: "Capsule Two",
      description: "This is the second capsule.",
      duration: Duration(minutes: 5),
      tags: ["relaxation", "focus"],
    ),
    Capsule(
      id: 3,
      title: "Capsule Three",
      description: "This is the third capsule.",
      duration: Duration(minutes: 15),
      tags: ["meditation", "stress relief"],
    ),
  ];

  final Ref ref;

  CapsuleRepository({required this.ref});

  List<Capsule> getCapsules() {
    return capsules;
  }
}

@riverpod
CapsuleRepository capsuleRepository(Ref ref){
  return CapsuleRepository(ref: ref);
}

@riverpod
List<Capsule> getCapsules(Ref ref) {
  final capsuleRepository = ref.watch(capsuleRepositoryProvider);
  return capsuleRepository.getCapsules();
}