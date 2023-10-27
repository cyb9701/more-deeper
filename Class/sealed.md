#class-modifier 

---
## [Docs] Class modifiers / sealed
https://dart.dev/language/class-modifiers#sealed

To create a known, enumerable set of subtypes, use the `sealed` modifier. This allows you to create a switch over those subtypes that is statically ensured to be [_exhaustive_](https://dart.dev/language/branches#exhaustiveness-checking).
> 알려진, 열거 가능한 하위 유형 집합을 만들려면 sealed 수정자를 사용합니다. 이를 통해 정적으로 완전한 하위 유형에 대한 스위치를 만들 수 있습니다.

The `sealed` modifier prevents a class from being extended or implemented outside its own library. Sealed classes are implicitly [abstract](https://dart.dev/language/class-modifiers#abstract).
> 봉인된 수정자는 클래스가 자체 라이브러리 외부로 확장되거나 구현되는 것을 방지합니다. 봉인된 클래스는 암시적으로 추상적입니다.

- They cannot be constructed themselves.
- They can have [factory constructors](https://dart.dev/language/constructors#factory-constructors).
- They can define constructors for their subclasses to use.

> - 자체 생성은 불가능합니다.
> - 팩토리 생성자를 가질 수 있습니다.
> - 서브클래스가 사용할 생성자를 정의할 수 있습니다.

Subclasses of sealed classes are, however, not implicitly abstract.
> 그러나 봉인된 클래스의 서브클래스는 암시적으로 추상적이지 않습니다.

The compiler is aware of any possible direct subtypes because they can only exist in the same library. This allows the compiler to alert you when a switch does not exhaustively handle all possible subtypes in its cases:
> 컴파일러는 동일한 라이브러리에만 존재할 수 있기 때문에 가능한 모든 직접 서브타입을 알고 있습니다. 따라서 컴파일러는 스위치가 가능한 모든 서브타입을 완전히 처리하지 못하는 경우 사용자에게 경고를 표시할 수 있습니다:

```dart
sealed class Vehicle {}

class Car extends Vehicle {}

class Truck implements Vehicle {}

class Bicycle extends Vehicle {}

// ERROR: Cannot be instantiated
Vehicle myVehicle = Vehicle();

// Subclasses can be instantiated
Vehicle myCar = Car();

String getVehicleSound(Vehicle vehicle) {
  // ERROR: The switch is missing the Bicycle subtype or a default case.
  return switch (vehicle) {
    Car() => 'vroom',
    Truck() => 'VROOOOMM',
  };
}
```

If you don’t want [exhaustive switching](https://dart.dev/language/branches#exhaustiveness-checking), or want to be able to add subtypes later without breaking the API, use the [`final`](https://dart.dev/language/class-modifiers#final)modifier. For a more in depth comparison, read [`sealed` versus `final`](https://dart.dev/language/class-modifiers-for-apis#sealed-versus-final).
> 완전한 전환을 원하지 않거나 나중에 API를 손상시키지 않고 하위 유형을 추가할 수 있으려면 최종 수정자를 사용하세요. 보다 자세한 비교는 봉인된 것과 최종적인 것을 읽어보세요.