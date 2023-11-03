#class-modifier 

---
## [Docs] Class modifiers | base
https://dart.dev/language/class-modifiers#base

To enforce inheritance of a class or mixin’s implementation, use the `base` modifier. A base class disallows implementation outside of its own library. This guarantees:
> 클래스 또는 믹스인 구현의 상속을 강제하려면, 기본 수정자를 사용하세요. 기본 클래스는 자체 라이브러리 외부의 구현을 허용하지 않는다. 이것은 보장한다:

- The base class constructor is called whenever an instance of a subtype of the class is created.
- All implemented private members exist in subtypes.
- A new implemented member in a `base` class does not break subtypes, since all subtypes inherit the new member.
    - This is true unless the subtype already declares a member with the same name and an incompatible signature.

> - 베이스 클래스 생성자는 클래스의 서브타입 인스턴스가 생성될 때마다 호출됩니다.
> - 구현된 모든 비공개 멤버는 서브타입에 존재합니다.
> - 모든 서브타입이 새 멤버를 상속하기 때문에 기본 클래스에서 새로 구현된 멤버는 서브타입을 손상시키지 않습니다.
> 	- 하위 유형이 이미 동일한 이름과 호환되지 않는 서명을 가진 멤버를 선언한 경우가 아니라면 이는 사실입니다.

You must mark any class which implements or extends a base class as `base`, `final`, or `sealed`. This prevents outside libraries from breaking the base class guarantees.
> 기본 클래스를 구현하거나 확장하는 모든 클래스를 기본, 최종 또는 봉인된 것으로 표시해야 합니다. 이렇게 하면 외부 라이브러리가 기본 클래스 보증을 위반하는 것을 방지할 수 있습니다.

```dart
// Library a.dart
base class Vehicle {
  void moveForward(int meters) {
    // ...
  }
}

base class A extends Vehicle {}  
  
base class B implements Vehicle {  
  @override  
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

// Can be extended
base class Car extends Vehicle {
  int passengers = 4;
  // ...
}

// ERROR: Cannot be implemented
// The class 'Vehicle' can't be implemented outside of its library because it's a base class.
base class MockVehicle implements Vehicle {
  @override
  void moveForward() {
    // ...
  }
}
```

---
## [Organize]
### 정의
- 라이브러리 내부 (`base class` 가 위치하는 파일)에서는 상속 및 구현 모두 가능
- 라이브러리 외부에서는 상속만 가능하고 구현 불가능
- `base class` 를 상속 받는 서브 클래스 `base`, `final`, `sealed` 중 하나로 표시해야함