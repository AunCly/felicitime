// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capsule_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$capsuleRepositoryHash() => r'4489f394ef548aff9b52436ae3ed651beb377227';

/// See also [capsuleRepository].
@ProviderFor(capsuleRepository)
final capsuleRepositoryProvider =
    AutoDisposeProvider<CapsuleRepository>.internal(
  capsuleRepository,
  name: r'capsuleRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$capsuleRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CapsuleRepositoryRef = AutoDisposeProviderRef<CapsuleRepository>;
String _$currentCapsulesStreamHash() =>
    r'e9e678bcd4ec1729b0c382f9114838e82735f849';

/// See also [currentCapsulesStream].
@ProviderFor(currentCapsulesStream)
final currentCapsulesStreamProvider =
    AutoDisposeStreamProvider<List<Capsule>>.internal(
  currentCapsulesStream,
  name: r'currentCapsulesStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentCapsulesStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentCapsulesStreamRef = AutoDisposeStreamProviderRef<List<Capsule>>;
String _$currentCapsuleStreamHash() =>
    r'86429f93d703adce72028cae60a3831ba328e0a3';

/// See also [currentCapsuleStream].
@ProviderFor(currentCapsuleStream)
final currentCapsuleStreamProvider =
    AutoDisposeStreamProvider<Capsule?>.internal(
  currentCapsuleStream,
  name: r'currentCapsuleStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentCapsuleStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentCapsuleStreamRef = AutoDisposeStreamProviderRef<Capsule?>;
String _$momentsStreamHash() => r'aca4ab13d1b19e362fa25c7e82754e09d2c55ec3';

/// See also [momentsStream].
@ProviderFor(momentsStream)
final momentsStreamProvider = AutoDisposeStreamProvider<List<Moment>>.internal(
  momentsStream,
  name: r'momentsStreamProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$momentsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MomentsStreamRef = AutoDisposeStreamProviderRef<List<Moment>>;
String _$moodsStreamHash() => r'dbd0648cbe7c559bcade74bbef9c45c5f1a35297';

/// See also [moodsStream].
@ProviderFor(moodsStream)
final moodsStreamProvider = AutoDisposeStreamProvider<List<Mood>>.internal(
  moodsStream,
  name: r'moodsStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$moodsStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef MoodsStreamRef = AutoDisposeStreamProviderRef<List<Mood>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
