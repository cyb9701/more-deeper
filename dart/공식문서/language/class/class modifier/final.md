#class-modifier 

---
## [Docs] Class modifiers | final
https://dart.dev/language/class-modifiers#final

To close the type hierarchy, use the `final` modifier. This prevents subtyping from a class outside of the current library. Disallowing both inheritance and implementation prevents subtyping entirely. This guarantees:
> 유형 계층 구조를 닫으려면 마지막 수정자를 사용합니다. 이렇게 하면 현재 라이브러리 외부의 클래스에서 하위 유형화를 방지할 수 있습니다. 상속과 구현을 모두 허용하지 않으면 하위 유형화를 완전히 방지할 수 있습니다. 이렇게 하면 보장됩니다:

- You can safely add incremental changes to the API.
- You can call instance methods knowing that they haven’t been overwritten in a third-party subclass.

> - API에 점진적인 변경 사항을 안전하게 추가할 수 있습니다.
> - 인스턴스 메서드가 타사 서브클래스에서 덮어쓰지 않았다는 것을 알고 호출할 수 있습니다.

Final classes can be extended or implemented within the same library. The `final` modifier encompasses the effects of `base`, and therefore any subclasses must also be marked `base`, `final`, or `sealed`.
> 최종 클래스는 동일한 라이브러리 내에서 확장하거나 구현할 수 있습니다. 최종 수정자는 기본의 효과를 포함하므로 모든 하위 클래스에도 기본, 최종 또는 밀봉으로 표시해야 합니다.

```dart
// Library a.dart
final class Vehicle {
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
// The class 'Vehicle' can't be extended outside of its library because it's a final class.
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

class MockVehicle implements Vehicle {
  // ERROR: Cannot be implemented
  // The class 'Vehicle' can't be implemented outside of its library because it's a final class. 
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

---
## [Organize]

### 정의
- 라이브러리 내부 (`final class` 가 위치하는 파일)에서는 상속 및 구현 모두 가능
- 라이브러리 외부에서는 상속과 구현 모두 불가능
- 라이브러리 내부에서의 하위 클래스는 `base`, `final`, `sealed` 을 사용해야 한다