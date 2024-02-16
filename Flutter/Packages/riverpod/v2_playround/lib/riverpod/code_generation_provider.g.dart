// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'code_generation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$goStateHash() => r'dde25961b0b362445087e256271a270999e2581c';

/// 사용하는 이유
///
/// 1) 어떤 provider를 사용할지 결정할 고민할 필요 없도록.
///
/// Copied from [goState].
@ProviderFor(goState)
final goStateProvider = AutoDisposeProvider<String>.internal(
  goState,
  name: r'goStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$goStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GoStateRef = AutoDisposeProviderRef<String>;
String _$goStateFutureHash() => r'caeed8dc81fe337b8a5a43c4f3499bc27561558e';

/// See also [goStateFuture].
@ProviderFor(goStateFuture)
final goStateFutureProvider = AutoDisposeFutureProvider<int>.internal(
  goStateFuture,
  name: r'goStateFutureProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goStateFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GoStateFutureRef = AutoDisposeFutureProviderRef<int>;
String _$goKeepAliveStateFutureHash() => r'302c8780eedcfe7217722b9d4ca1dd25cbd32b78';

/// See also [goKeepAliveStateFuture].
@ProviderFor(goKeepAliveStateFuture)
final goKeepAliveStateFutureProvider = FutureProvider<int>.internal(
  goKeepAliveStateFuture,
  name: r'goKeepAliveStateFutureProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goKeepAliveStateFutureHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GoKeepAliveStateFutureRef = FutureProviderRef<int>;
String _$goStateMultiplyHash() => r'a2c7d2e32f62ec16872b1de8ff2ba158d5ea9aac';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
/// Parameter에서 여러가지 값을 넣고 싶을 경우.
///
/// Copied from [goStateMultiply].
@ProviderFor(goStateMultiply)
const goStateMultiplyProvider = GoStateMultiplyFamily();

/// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
/// Parameter에서 여러가지 값을 넣고 싶을 경우.
///
/// Copied from [goStateMultiply].
class GoStateMultiplyFamily extends Family<int> {
  /// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
  /// Parameter에서 여러가지 값을 넣고 싶을 경우.
  ///
  /// Copied from [goStateMultiply].
  const GoStateMultiplyFamily();

  /// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
  /// Parameter에서 여러가지 값을 넣고 싶을 경우.
  ///
  /// Copied from [goStateMultiply].
  GoStateMultiplyProvider call({
    required int number1,
    required int number2,
  }) {
    return GoStateMultiplyProvider(
      number1: number1,
      number2: number2,
    );
  }

  @override
  GoStateMultiplyProvider getProviderOverride(
    covariant GoStateMultiplyProvider provider,
  ) {
    return call(
      number1: provider.number1,
      number2: provider.number2,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies => _allTransitiveDependencies;

  @override
  String? get name => r'goStateMultiplyProvider';
}

/// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
/// Parameter에서 여러가지 값을 넣고 싶을 경우.
///
/// Copied from [goStateMultiply].
class GoStateMultiplyProvider extends AutoDisposeProvider<int> {
  /// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
  /// Parameter에서 여러가지 값을 넣고 싶을 경우.
  ///
  /// Copied from [goStateMultiply].
  GoStateMultiplyProvider({
    required int number1,
    required int number2,
  }) : this._internal(
          (ref) => goStateMultiply(
            ref as GoStateMultiplyRef,
            number1: number1,
            number2: number2,
          ),
          from: goStateMultiplyProvider,
          name: r'goStateMultiplyProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product') ? null : _$goStateMultiplyHash,
          dependencies: GoStateMultiplyFamily._dependencies,
          allTransitiveDependencies: GoStateMultiplyFamily._allTransitiveDependencies,
          number1: number1,
          number2: number2,
        );

  GoStateMultiplyProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number1,
    required this.number2,
  }) : super.internal();

  final int number1;
  final int number2;

  @override
  Override overrideWith(
    int Function(GoStateMultiplyRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GoStateMultiplyProvider._internal(
        (ref) => create(ref as GoStateMultiplyRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number1: number1,
        number2: number2,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<int> createElement() {
    return _GoStateMultiplyProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GoStateMultiplyProvider && other.number1 == number1 && other.number2 == number2;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number1.hashCode);
    hash = _SystemHash.combine(hash, number2.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin GoStateMultiplyRef on AutoDisposeProviderRef<int> {
  /// The parameter `number1` of this provider.
  int get number1;

  /// The parameter `number2` of this provider.
  int get number2;
}

class _GoStateMultiplyProviderElement extends AutoDisposeProviderElement<int>
    with GoStateMultiplyRef {
  _GoStateMultiplyProviderElement(super.provider);

  @override
  int get number1 => (origin as GoStateMultiplyProvider).number1;
  @override
  int get number2 => (origin as GoStateMultiplyProvider).number2;
}

String _$goStateNotifierHash() => r'19f2b7721b49ed4d56a4209b55df58e42022d6b7';

/// state notifier
///
/// Copied from [GoStateNotifier].
@ProviderFor(GoStateNotifier)
final goStateNotifierProvider = NotifierProvider<GoStateNotifier, int>.internal(
  GoStateNotifier.new,
  name: r'goStateNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$goStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GoStateNotifier = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
