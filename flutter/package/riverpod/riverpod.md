## [riverpod](https://pub.dev/packages/flutter_riverpod)

- v2.4.10
- 상태관리 툴이다.

## v2.0

https://riverpod.dev/ko/docs/migration/from_state_notifier

### 권장 Provier

- Provider
- NotifierProvider
- AsyncNotifierProvider
- FutureProvider
- StreamProvider

### 새로운 문법 비교

- 신규
  - `NotifierProvider` & `Notifier`
  - `AsyncNotifierProvider` & `AsyncNotifier`
    - `AsyncNotifierProvider`는 메서드가 있는 `FutureProvider`로 쉽게 볼 수 있다.
- 사용하지 않음
  - `StateProvider`
  - `StateNotifierProvider` & `StateNotifier`

```dart
// 변경 전.

final counterNotifierProvider = StateNotifierProvider<CounterNotifier, int>((ref) {
  return CounterNotifier();
});

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier() : super(0);

  void increment() => state++;
  void decrement() => state++;
}
```

```dart
// 변경 후.

final counterNotifierProvider = NotifierProvider<CounterNotifier, int>(CounterNotifier.new);

class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void increment() => state++;
  void decrement() => state++;
}
```

### 명시적인 .family 및 .autoDispose 수정사항

- Notifier에는 자체 .family 및 .autoDispose 대응 항목이 있다.
- 신규
  - `FamilyNotifier`
  - `AutoDisposeNotifier`
  - `AutoDisposeFamilyNotifier`
  - `FamilyAsyncNotifier`
  - `AutoDisposeAsyncNotifier`
  - `AutoDisposeFamilyAsyncNotifier`

```dart
// 변경 전.

final bugsEncounteredNotifierProvider =
    StateNotifierProvider.family.autoDispose<BugsEncounteredNotifier, int, String>((ref, id) {
  return BugsEncounteredNotifier(ref: ref, featureId: id);
});

class BugsEncounteredNotifier extends StateNotifier<AsyncValue<int>> {
  BugsEncounteredNotifier({
    required this.ref,
    required this.featureId,
  }) : super(const AsyncData(99));
  final String featureId;
  final Ref ref;

  Future<void> fix(int amount) async {
    state = await AsyncValue.guard(() async {
      final old = state.requireValue;
      final result = await ref.read(taskTrackerProvider).fix(id: featureId, fixed: amount);
      return max(old - result, 0);
    });
  }
}
```

```dart
// 변경 후.

final bugsEncounteredNotifierProvider =
    AsyncNotifierProvider.family.autoDispose<BugsEncounteredNotifier, int, String>(
  BugsEncounteredNotifier.new,
);

class BugsEncounteredNotifier extends AutoDisposeFamilyAsyncNotifier<int, String> {
  @override
  FutureOr<int> build(String featureId) {
    return 99;
  }

  Future<void> fix(int amount) async {
    final old = await future;
    final result = await ref.read(taskTrackerProvider).fix(id: this.arg, fixed: amount);
    state = AsyncData(max(old - result, 0));
  }
}
```

- (Async)Notifier의 .family 매개변수는 this.arg(또는 코드생성을 사용하는 경우 this.paramName)를 통해 사용할 수 있다.

### 라이프사이클에 따라 동작 방식이 다르다

```dart
// 변경 전.

final myNotifierProvider = StateNotifierProvider<MyNotifier, int>((ref) {
  // 6 provider 정의
  final period = ref.watch(durationProvider); // 7 리액티브 종속성 로직
  return MyNotifier(ref, period); // 8 `ref`로 연결(pipe down)
});

class MyNotifier extends StateNotifier<int> {
  MyNotifier(this.ref, this.period) : super(0) {
    // 1 초기화로직
    _timer = Timer.periodic(period, (t) => update()); // 2 초기화시 부가작업
  }
  final Duration period;
  final Ref ref;
  late final Timer _timer;

  Future<void> update() async {
    await ref.read(repositoryProvider).update(state + 1); // 3 변이(mutation)
    if (mounted) state++; // 4 마운트된 속성 확인
  }

  @override
  void dispose() {
    _timer.cancel(); // 5 커스텀 폐기(dispose) 로직
    super.dispose();
  }
}
```

- `durationProvider`가 업데이트되면 `MyNotifier`를 `dispose`(인스턴스가 다시 인스턴스화되고 내부 상태 초기화)한다.

#### 이전의 dispose vs ref.onDispose

- 새로운 Notifier에서는 `build()` 메서드 안에서 `dispose`를 정의할 수 있다.
- 초기화와 폐기를 한 곳에서 읽기 및 작성을 하면 된다.

```dart
@override
int build() {
  // Just read/write the code here, in one place
  final period = ref.watch(durationProvider);
  final timer = Timer.periodic(period, (t) => update());
  ref.onDispose(timer.cancel);

  return 0;
}
```

## v1.0

### Provider의 종류

- 각각 다른 타입을 반환해주고 사용 목적이 다르다
- 모든 Provider는 글로벌하게 선언된다
- 종류
  - Provider
  - StateProvider
  - StateNotifierProvider
  - FutureProvider
  - StreamProvider
  - ChangeNotifierProvider (사용 안함 - Provider 마이그레이션 용도)

### Provider

- 가장 기본 베이스가되는 Provider
- 아무 타입이나 반환 가능
- Service, 계산한 값등을 반환할때 사용
- 반환값을 캐싱할때 유용하게 사용된다
  - 빌드 횟수 최소화 가능
- 여러 Provider의 값들을 묶어서 한번에 반환값을 만들어낼 수 있다

### StateProvider

- UI에서 “직접적으로” 데이터를 변경할 수 있도록 하고싶을때 사용
- 단순한 형태의 데이터만 관리 (int, double, String등)
- Map, List등 복잡한 형태의 데이터는 다루지 않음
- 복잡한 로직이 필요한경우 사용하지 않음
  - number++ 정도의 간단한 로직으로만 한정

### StateNotifierProvider

- StateProvider와 마찬가지로 UI에서 “직접적으로” 데이터를 변경할 수 있도록 하고싶을 때 사용
- 복잡한 형태의 데이터 관리가능 (클래스의 메소드를 이용한 상태관리)
- StateNotifier를 상속한 클래스를 반환

### FutureProvider

- Future 타입만 반환가능
- API 요청의 결과를 반환할때 자주 사용
- 복잡한 로직 또는 사용자의 특정 행동뒤에 Future를 재실행하는 기능이 없음
  - 필요할경우 StateNotifierProvider 사용

### StreamProvider

- Stream 타입만 반환가능
- API 요청의 결과를 Stream으로 반환할때 자주 사용
  - Socket등

### 비교차트

| Provider 종류             | 반환값                         | 사용 예제                |
| ------------------------- | ------------------------------ | ------------------------ |
| **Provider**              | 아무 타입                      | 데이터 캐싱              |
| **StateProvider**         | 아무 타입                      | 간단한 상태값 관리       |
| **StateNotifierProvider** | StateNotifier를 상속한 값 반환 | 복잡한 상태값 관리       |
| **FutureProvider**        | Future 타입                    | API 요청의 Future 결과값 |
| **StreamProvider**        | Stream 타입                    | API 요청의 Stream 결과값 |

### read vs watch

- ref.watch는 반환값의 업데이트가 있을때 지속적으로 build 함수를 다시 실행해준다.
- ref.watch는 필수적으로 UI관련 코드에만 사용한다.
- ref.read는 실행되는순간 단 한번만 provider 값을 가져온다.
- ref.read는 onPressed 콜백처럼 특정 액션 뒤에 실행되는 함수 내부에서 사용된다.
