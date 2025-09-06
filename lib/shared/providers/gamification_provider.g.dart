// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gamification_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$gamificationNotifierHash() =>
    r'8c7b9f01aa5f16fb43137917ee53461c606ba95f';

/// See also [GamificationNotifier].
@ProviderFor(GamificationNotifier)
final gamificationNotifierProvider = AutoDisposeAsyncNotifierProvider<
    GamificationNotifier, Map<String, dynamic>>.internal(
  GamificationNotifier.new,
  name: r'gamificationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$gamificationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GamificationNotifier = AutoDisposeAsyncNotifier<Map<String, dynamic>>;
String _$userBadgesNotifierHash() =>
    r'dd5755a5ece477e891472816095e0d8df1cfb725';

/// See also [UserBadgesNotifier].
@ProviderFor(UserBadgesNotifier)
final userBadgesNotifierProvider =
    AutoDisposeAsyncNotifierProvider<UserBadgesNotifier, List<Badge>>.internal(
  UserBadgesNotifier.new,
  name: r'userBadgesNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userBadgesNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserBadgesNotifier = AutoDisposeAsyncNotifier<List<Badge>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
