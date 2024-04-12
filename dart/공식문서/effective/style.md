# 식별자(Identifiers)

## [사용하지 않는 콜백 매개 변수에 대해 \_, \_\_ 등을 사용하는 것을 선호합니다](https://dart.dev/effective-dart/style#prefer-using-_-__-etc-for-unused-callback-parameters)

때때로 콜백 함수의 유형 서명에는 매개 변수가 필요하지만, 콜백 구현은 매개 변수를 사용하지 않습니다.  
이 경우, 사용하지 않는 매개 변수의 이름을 짓는 것은 관용적인 것이다.  
함수에 사용되지 않는 매개 변수가 여러 개 있는 경우, 이름 충돌을 피하기 위해 추가 밑줄을 사용하십시오: **, \_** 등.

```dart
// good

futureOfVoid.then((_) {
  print('Operation complete.');
});
```

이 지침은 익명과 지역적인 기능만을 위한 것이다.  
이러한 함수는 일반적으로 사용되지 않는 매개 변수가 무엇을 나타내는지 명확한 맥락에서 즉시 사용됩니다.  
대조적으로, 최상위 함수와 메서드 선언에는 그 컨텍스트가 없으므로, 사용되지 않더라도 각 매개 변수가 무엇을 위한 것인지 명확하도록 매개 변수의 이름을 지정해야 합니다.

## [비공개가 아닌 식별자에 선행 밑줄을 사용하지 마세요](https://dart.dev/effective-dart/style#dont-use-a-leading-underscore-for-identifiers-that-arent-private)

다트는 식별자의 주요 밑줄을 사용하여 회원과 최상위 선언을 비공개로 표시합니다. 이것은 사용자가 주요 밑줄을 그러한 종류의 선언 중 하나와 연관시키도록 훈련시킨다. 그들은 "\_"를 보고 "개인"이라고 생각한다.

로컬 변수, 매개 변수, 로컬 함수 또는 라이브러리 접두사에 대한 "개인" 개념은 없습니다. 그 중 하나가 밑줄로 시작하는 이름을 가지고 있을 때, 그것은 독자에게 혼란스러운 신호를 보낸다. 그것을 피하려면, 그 이름에 선행 밑줄을 사용하지 마세요.

```dart
class MyWidget extends StatelessWidget {
  final int params;

  MyWidget({
    super.key,
    required this.params,
  });

  final int _member = 0;

  void _fun() {
    const innerVar = 0;
  }

  @override
  Widget build(BuildContext context) {
    return newMethod();
  }

  Placeholder newMethod() {
    return const Placeholder();
  }
}
```
