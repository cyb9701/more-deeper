import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProviderLogger extends ProviderObserver {
  @override
  void didUpdateProvider(
    ProviderBase<Object?> provider,
    Object? previousValue,
    Object? newValue,

    // flutter에서는 신경쓰지 않아도 된다.
    ProviderContainer container,
  ) {
    debugPrint(
      '[Provider Updated]\nprovider: $provider\nprevious: $previousValue\nnew value: $newValue\n------',
    );
    super.didUpdateProvider(provider, previousValue, newValue, container);
  }

  @override
  void didAddProvider(
    ProviderBase<Object?> provider,
    Object? value,
    ProviderContainer container,
  ) {
    debugPrint(
      '[Provider Add]\nprovider: $provider\nvalue: $value\n------',
    );
    super.didAddProvider(provider, value, container);
  }

  @override
  void didDisposeProvider(
    ProviderBase<Object?> provider,
    ProviderContainer container,
  ) {
    debugPrint(
      '[Provider Dispose]\nprovider: $provider\n------',
    );
    super.didDisposeProvider(provider, container);
  }
}
