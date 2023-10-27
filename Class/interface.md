#class-modifier 

---
## [Docs] Class modifiers / interface
https://dart.dev/language/class-modifiers#interface

To define an interface, use the `interface` modifier. Libraries outside of the interface’s own defining library can implement the interface, but not extend it. This guarantees:
> 인터페이스를 정의하려면 인터페이스 수정자를 사용합니다. 인터페이스 자체 정의 라이브러리 외부의 라이브러리는 인터페이스를 구현할 수는 있지만 확장할 수는 없습니다. 이렇게 하면 보장됩니다:

- When one of the class’s instance methods calls another instance method on `this`, it will always invoke a known implementation of the method from the same library.
- Other libraries can’t override methods that the interface class’s own methods might later call in unexpected ways. This reduces the [fragile base class problem](https://en.wikipedia.org/wiki/Fragile_base_class).

> - 클래스의 인스턴스 메서드 중 하나가 다른 인스턴스 메서드를 호출하면 항상 동일한 라이브러리에서 알려진 메서드 구현을 호출합니다.
> - 다른 라이브러리는 인터페이스 클래스의 자체 메서드가 나중에 예기치 않은 방식으로 호출할 수 있는 메서드를 재정의할 수 없습니다. 이렇게 하면 취약한 베이스 클래스 문제가 줄어듭니다.

```dart
// Library a.dart
interface class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}
```

```dart
// Library b.dart
import 'a.dart';

// Can be constructed
Vehicle myVehicle = Vehicle();

// ERROR: Cannot be inherited
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// Can be implemented
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

---
## [Organize]
### 정의
- 라이브러리 내부 (`interface class` 가 위치하는 파일)에서는 상속 및 구현 모두 가능
- 라이브러리 외부에서는 구현만 가능하고 상속 불가능