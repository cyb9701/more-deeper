#syntax-basics #override #deprecated

---
## Docs
https://dart.dev/language/metadata

Use metadata to give additional information about your code. A metadata annotation begins with the character `@`, followed by either a reference to a compile-time constant (such as `deprecated`) or a call to a constant constructor.
>메타데이터를 사용하여 코드에 대한 추가 정보를 제공하세요. 메타데이터 주석은 @ 문자로 시작하며, 그 뒤에 컴파일 타임 상수에 대한 참조(예: 사용 중단됨) 또는 상수 생성자에 대한 호출이 이어집니다.

Four annotations are available to all Dart code: [`@Deprecated`](https://api.dart.dev/stable/dart-core/deprecated-constant.html), [`@deprecated`](https://api.dart.dev/stable/dart-core/deprecated-constant.html), [`@override`](https://api.dart.dev/stable/dart-core/override-constant.html), and [`@pragma`](https://api.dart.dev/stable/dart-core/pragma-class.html). For examples of using `@override`, see [Extending a class](https://dart.dev/language/extend). Here’s an example of using the `@Deprecated` annotation:
>모든 Dart 코드에는 네 가지 어노테이션을 사용할 수 있습니다: 사용 중단됨, `@deprecated`, `@override` 및 `@pragma`. 오버라이드 사용 예는 클래스 확장하기를 참조하세요. 다음은 `@Deprecated` 어노테이션 사용 예제입니다:

```dart
class Television {
  /// Use [turnOn] to turn the power on instead.
  @Deprecated('Use turnOn instead')
  void activate() {
    turnOn();
  }

  /// Turns the TV's power on.
  void turnOn() {...}
  // ···
}
```

You can use `@deprecated` if you don’t want to specify a message. However, we [recommend](https://dart.dev/tools/linter-rules/provide_deprecation_message) always specifying a message with `@Deprecated`.
>메시지를 지정하지 않으려면 `@deprecated`를 사용할 수 있습니다. 그러나, 우리는 항상 `@Deprecated`로 메시지를 지정하는 것이 좋습니다.

You can define your own metadata annotations. Here’s an example of defining a `@Todo` annotation that takes two arguments:
>자신만의 메타데이터 주석을 정의할 수 있습니다. 다음은 두 개의 인수를 취하는 `@Todo` 주석을 정의하는 예입니다:

```dart
class Todo {
  final String who;
  final String what;

  const Todo(this.who, this.what);
}
```

And here’s an example of using that `@Todo` annotation:
>다음은 `@Todo` 어노테이션을 사용하는 예입니다:

```dart
@Todo('Dash', 'Implement this function')
void doSomething() {
  print('Do something');
}
```

Metadata can appear before a library, class, typedef, type parameter, constructor, factory, function, field, parameter, or variable declaration and before an import or export directive.
>메타데이터는 라이브러리, 클래스, typedef, 유형 매개 변수, 생성자, 공장, 함수, 필드, 매개 변수 또는 변수 선언과 가져오기 또는 내보내기 지시문 앞에 나타날 수 있습니다.

---
## Use
![[metadata-1.png]]
![[metadata-2.png]]