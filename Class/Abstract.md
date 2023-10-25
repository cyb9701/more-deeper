## [Docs] Abstract methods
https://dart.dev/language/methods#abstract-methods

Instance, getter, and setter methods can be abstract, defining an interface but leaving its implementation up to other classes. Abstract methods can only exist in [[Class modifiers#abstract]] or [mixins](https://dart.dev/language/mixins).
> 인스턴스, 게터 및 세터 메서드는 추상적일 수 있으며, 인터페이스를 정의하지만 그 구현은 다른 클래스에 맡길 수 있습니다. 추상 메서드는 추상 클래스나 믹스인에만 존재할 수 있습니다.

To make a method abstract, use a semicolon (;) instead of a method body:
> 메서드를 추상화하려면 메서드 본문 대신 세미콜론(;)을 사용합니다:

```dart
abstract class Doer {
  // Define instance variables and methods...

  void doSomething(); // Define an abstract method.
}

class EffectiveDoer extends Doer {
  void doSomething() {
    // Provide an implementation, so the method is not abstract here...
  }
}
```