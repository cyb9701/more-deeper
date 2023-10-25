#class #modifier #abstract #base #interface #final #sealed 

---
## Docs
https://dart.dev/language/class-modifiers

Class modifiers control how a class or mixin can be used, both [from within its own library](https://dart.dev/language/class-modifiers#abstract), and from outside of the library where it’s defined.
> 클래스 수정자는 클래스 또는 믹스인이 자체 라이브러리 내부와 정의된 라이브러리 외부에서 사용되는 방식을 제어합니다.

Modifier keywords come before a class or mixin declaration. For example, writing `abstract class` defines an abstract class. The full set of modifiers that can appear before a class declaration include:
> 수정자 키워드는 클래스 또는 믹스인 선언 앞에옵니다. 예를 들어, 추상 클래스를 작성하면 추상 클래스가 정의됩니다. 클래스 선언 앞에 나타날 수 있는 전체 수정자 집합은 다음과 같습니다:

- `abstract`
- `base`
- `final`
- `interface`
- `sealed`
- [`mixin`](https://dart.dev/language/mixins#class-mixin-or-mixin-class)

Only the `base` modifier can appear before a mixin declaration. The modifiers do not apply to other declarations like `enum`, `typedef`, or `extension`.
> 기본 수정자만 믹스인 선언 앞에 나타날 수 있습니다. 이 수정자는 열거형, typedef 또는 extension과 같은 다른 선언에는 적용되지 않습니다.

When deciding whether to use class modifiers, consider the intended uses of the class, and what behaviors the class needs to be able to rely on.
> 클래스 수정자를 사용할지 여부를 결정할 때는 클래스의 의도된 용도와 클래스가 의존할 수 있어야 하는 동작을 고려하세요.

> [!NOTE]
> If you maintain a library, read the [Class modifiers for API maintainers](https://dart.dev/language/class-modifiers-for-apis) page for guidance on how to navigate these changes for your libraries.
> > 라이브러리를 유지 관리하는 경우 API 유지 관리자를 위한 클래스 수정자 페이지에서 라이브러리에 대한 이러한 변경 사항을 탐색하는 방법에 대한 지침을 확인하세요.

### No modifier
To allow unrestricted permission to construct or subtype from any library, use a `class` or `mixin` declaration without a modifier. By default, you can:
> 라이브러리에서 구성하거나 하위 유형화할 수 있는 권한을 제한 없이 허용하려면 수정자 없이 클래스 또는 믹스인 선언을 사용합니다. 기본적으로 가능합니다:

- [Construct](https://dart.dev/language/constructors) new instances of a class.
- [Extend](https://dart.dev/language/extend) a class to create a new subtype.
- [Implement](https://dart.dev/language/classes#implicit-interfaces) a class or mixin’s interface.
- [Mix in](https://dart.dev/language/mixins) a mixin or mixin class.

> - 클래스의 새 인스턴스를 생성합니다.
> - 클래스를 확장하여 새 하위 유형을 생성합니다.
> - 클래스 또는 믹스인의 인터페이스를 구현합니다.
> - 믹스인 또는 믹스인 클래스에서 믹스합니다.

### abstract
To define a class that doesn’t require a full, concrete implementation of its entire interface, use the `abstract` modifier.
> 전체 인터페이스의 구체적인 구현이 필요하지 않은 클래스를 정의하려면 추상 수정자를 사용하세요.

Abstract classes cannot be constructed from any library, whether its own or an outside library. Abstract classes often have [[Methods#Abstract methods]].
> 추상 클래스는 자체 라이브러리든 외부 라이브러리든 어떤 라이브러리에서도 생성할 수 없습니다. 추상 클래스는 종종 추상 메서드를 갖습니다.

```dart
// Library a.dart
abstract class Vehicle {
  void moveForward(int meters);
}
```

```dart
// Library b.dart
import 'a.dart';

// Error: Cannot be constructed
Vehicle myVehicle = Vehicle();

// Can be extended
class Car extends Vehicle {
  int passengers = 4;
  // ···
}

// Can be implemented
class MockVehicle implements Vehicle {
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

If you want your abstract class to appear to be instantiable, define a [factory constructor](https://dart.dev/language/constructors#factory-constructors).
> 추상 클래스를 인스턴스화할 수 있는 것처럼 보이게 하려면 팩토리 생성자를 정의하세요.

### base
To enforce inheritance of a class or mixin’s implementation, use the `base` modifier. A base class disallows implementation outside of its own library. This guarantees:
> 클래스 또는 믹스인 구현의 상속을 강제하려면 베이스 수정자를 사용합니다. 베이스 클래스는 자체 라이브러리 외부의 구현을 허용하지 않습니다. 이렇게 하면 보장됩니다:

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
base class MockVehicle implements Vehicle {
  @override
  void moveForward() {
    // ...
  }
}
```

### interface
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

#### abstract interface
The most common use for the `interface` modifier is to define a pure interface. [Combine](https://dart.dev/language/class-modifiers#combining-modifiers) the `interface` and [`abstract`](https://dart.dev/language/class-modifiers#abstract)modifiers for an `abstract interface class`.
> 인터페이스 수정자의 가장 일반적인 용도는 순수 인터페이스를 정의하는 것입니다. 추상 인터페이스 클래스의 인터페이스와 추상 수정자를 결합합니다.

Like an `interface` class, other libraries can implement, but cannot inherit, a pure interface. Like an `abstract` class, a pure interface can have abstract members.
> 인터페이스 클래스와 마찬가지로 다른 라이브러리에서는 순수 인터페이스를 구현할 수는 있지만 상속할 수는 없습니다. 추상 클래스와 마찬가지로 순수 인터페이스도 추상 멤버를 가질 수 있습니다.

### final
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
class Car extends Vehicle {
  int passengers = 4;
  // ...
}

class MockVehicle implements Vehicle {
  // ERROR: Cannot be implemented
  @override
  void moveForward(int meters) {
    // ...
  }
}
```

### sealed
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

### Combining modifiers

You can combine some modifiers for layered restrictions. A class declaration can be, in order:
> 계층 제한을 위해 몇 가지 수정자를 결합할 수 있습니다. 클래스 선언은 순서대로 사용할 수 있습니다:

1. (Optional) `abstract`, describing whether the class can contain abstract members and prevents instantiation.
2. (Optional) One of `base`, `interface`, `final` or `sealed`, describing restrictions on other libraries subtyping the class.
3. (Optional) `mixin`, describing whether the declaration can be mixed in.
4. The `class` keyword itself.

> 1. (선택 사항) 추상, 클래스가 추상 멤버를 포함할 수 있고 인스턴스화를 방지하는지 여부를 설명합니다.
> 2. (선택 사항) 베이스, 인터페이스, 파이널, 밀봉 중 하나로, 클래스를 서브타입화하는 다른 라이브러리에 대한 제한을 설명합니다.
> 3. (선택 사항) mixin, 선언을 혼합할 수 있는지 여부를 설명합니다.
> 4. 클래스 키워드 자체.

You can’t combine some modifiers because they are contradictory, redundant, or otherwise mutually exclusive:
> 일부 수식어는 모순되거나 중복되거나 상호 배타적이기 때문에 결합할 수 없습니다:

- `abstract` with `sealed`. A [sealed](https://dart.dev/language/class-modifiers#sealed) class is always implicitly [abstract](https://dart.dev/language/class-modifiers#abstract).
- `interface`, `final` or `sealed` with `mixin`. These access modifiers prevent [mixing in](https://dart.dev/language/mixins).

> - 봉인된 추상화. 봉인된 수업은 항상 암묵적으로 추상적이다.
> - 인터페이스, 최종 또는 믹스인으로 밀봉. 이러한 접근 수정자는 혼합을 방지한다.

See the [Class modifiers reference](https://dart.dev/language/modifier-reference) for complete guidance.
> 전체 지침은 클래스 수정자 참조를 참조하세요.