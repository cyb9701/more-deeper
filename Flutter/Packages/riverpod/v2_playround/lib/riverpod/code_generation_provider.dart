import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'code_generation_provider.g.dart';

/// 사용하는 이유
///
/// 1) 어떤 provider를 사용할지 결정할 고민할 필요 없도록.
/// Provider, FutureProvider, StreamProvider(x).
/// StateNotifierProvider - 명시적으로 사용.

// final _testProvider = Provider<String>((ref) => 'Hello Code Generation');

@riverpod
String goState(GoStateRef ref) {
  return 'Hello Code Generation';
}

@riverpod
Future<int> goStateFuture(GoStateFutureRef ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return 10;
}

@Riverpod(keepAlive: true)
Future<int> goKeepAliveStateFuture(GoKeepAliveStateFutureRef ref) async {
  await Future.delayed(const Duration(seconds: 2));
  return 10;
}

/// 2) Parameter > Family 파라미터를 일반 함수처럼 사용할 수 있도록.
/// Parameter에서 여러가지 값을 넣고 싶을 경우.

// class Parameter {
//   final int number1;
//   final int number2;

//   Parameter({
//     required this.number1,
//     required this.number2,
//   });
// }

// final _testFamilyProvider =
//     Provider.family<int, Parameter>((ref, parameter) => parameter.number1 * parameter.number2);

@riverpod
int goStateMultiply(
  GoStateMultiplyRef ref, {
  required int number1,
  required int number2,
}) {
  return number1 * number2;
}

/// state notifier
@Riverpod(keepAlive: true)
class GoStateNotifier extends _$GoStateNotifier {
  // 초기 상태값 지정.
  @override
  int build() {
    return 10;
  }

  void increase() {
    state++;
  }

  void decrease() {
    state--;
  }
}
