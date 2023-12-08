#class 

---
## Docs
https://dart.dev/language/constructors

Declare a constructor by creating a function with the same name as its class (plus, optionally, an additional identifier as described in [Named constructors](https://dart.dev/language/constructors#named-constructors)).
> 클래스와 같은 이름의 함수를 생성하여 생성자를 선언합니다(선택 사항으로 명명된 생성자에서 설명한 대로 추가 식별자를 추가할 수 있습니다).

Use the most common constructor, the generative constructor, to create a new instance of a class, and [initializing formal parameters](https://dart.dev/language/constructors#initializing-formal-parameters) to instantiate any instance variables, if necessary:
> 가장 일반적인 생성자인 생성자를 사용하여 클래스의 새로운 인스턴스를 만들고, 필요한 경우 공식 매개 변수를 초기화하여 인스턴스 변수를 인스턴스화하십시오.

```dart
class Point {
  double x = 0;
  double y = 0;

  // Generative constructor with initializing formal parameters:
  Point(this.x, this.y);
}
```

The `this` keyword refers to the current instance.
> 이 키워드는 현재 인스턴스를 가리킨다.

> [!NOTE]
> Use `this` only when there is a name conflict. Otherwise, Dart style omits the `this`.
> > 이름 충돌이 있을 때만 이것을 사용하세요. 그렇지 않으면, 다트 스타일은 이것을 생략한다.

### Initializing formal parameters
Dart has _initializing formal parameters_ to simplify the common pattern of assigning a constructor argument to an instance variable. Use `this.propertyName` directly in the constructor declaration, and omit the body.
> 다트는 인스턴스 변수에 생성자 인수를 할당하는 일반적인 패턴을 단순화하기 위해 공식적인 매개 변수를 초기화했다. 생성자 선언에서 직접 this.propertyName을 사용하고 본문을 생략하세요.

Initializing parameters also allow you to initialize non-nullable or `final` instance variables, which both must be initialized or provided a default value:
> 매개 변수를 초기화하면 무효화 또는 최종 인스턴스 변수를 초기화할 수 있으며, 둘 다 초기화하거나 기본값을 제공해야 합니다.

```dart
class Point {
  final double x;
  final double y;

  Point(this.x, this.y);
  // Sets the x and y instance variables
  // before the constructor body runs.
}
```

The variables introduced by the initializing formals are implicitly final and only in scope of the [initializer list](https://dart.dev/language/constructors#initializer-list).
> 초기화 형식에 의해 도입된 변수는 암시적으로 최종적이며 이니셜라이저 목록의 범위 내에서만 가능합니다.

If you need to perform some logic that cannot be expressed in the initializer list, create a [factory constructor](https://dart.dev/language/constructors#factory-constructors) (or [static method](https://dart.dev/language/classes#static-methods)) with that logic and then pass the computed values to a normal constructor.
> 이니셜라이저 목록에서 표현할 수 없는 논리를 수행해야 하는 경우, 해당 논리로 공장 생성자(또는 정적 방법)를 만든 다음 계산된 값을 일반 생성자에게 전달하십시오.

### Default constructors
If you don’t declare a constructor, a default constructor is provided for you. The default constructor has no arguments and invokes the no-argument constructor in the superclass.
> 생성자를 선언하지 않으면, 기본 생성자가 제공됩니다. 기본 생성자는 인수가 없으며 슈퍼클래스에서 인수 없는 생성자를 호출합니다.

### Constructors aren’t inherited
Subclasses don’t inherit constructors from their superclass. A subclass that declares no constructors has only the default (no argument, no name) constructor.
> 서브클래스는 슈퍼클래스로부터 생성자를 상속받지 않는다. 생성자를 선언하지 않는 서브클래스에는 기본(인수 없음, 이름 없음) 생성자만 있습니다.

### Named constructors
Use a named constructor to implement multiple constructors for a class or to provide extra clarity:
> 명명된 생성자를 사용하여 클래스에 대한 여러 생성자를 구현하거나 추가 명확성을 제공하십시오:

```dart
const double xOrigin = 0;
const double yOrigin = 0;

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  // Named constructor
  Point.origin()
      : x = xOrigin,
        y = yOrigin;
}
```

Remember that constructors are not inherited, which means that a superclass’s named constructor is not inherited by a subclass. If you want a subclass to be created with a named constructor defined in the superclass, you must implement that constructor in the subclass.
> 생성자는 상속되지 않는다는 것을 기억하세요. 이는 슈퍼클래스의 명명된 생성자가 하위 클래스에 의해 상속되지 않는다는 것을 의미합니다. 슈퍼클래스에 정의된 명명된 생성자로 서브클래스를 만들고 싶다면, 서브클래스에 해당 생성자를 구현해야 합니다.

### Invoking a non-default superclass constructor
By default, a constructor in a subclass calls the superclass’s unnamed, no-argument constructor. The superclass’s constructor is called at the beginning of the constructor body. If an [initializer list](https://dart.dev/language/constructors#initializer-list) is also being used, it executes before the superclass is called. In summary, the order of execution is as follows:
> 기본적으로, 서브클래스의 생성자는 슈퍼클래스의 이름 없는, 주장이 없는 생성자를 호출한다. 슈퍼클래스의 생성자는 생성자 몸체의 시작 부분에서 불린다. 이니셜라이저 목록도 사용되고 있다면, 슈퍼클래스가 호출되기 전에 실행된다. 요약하자면, 실행 순서는 다음과 같다:

1. initializer list
2. superclass’s no-arg constructor
3. main class’s no-arg constructor

> 1. 초기화 목록
> 2. 슈퍼클래스의 노-아르그 생성자
> 3. 메인 클래스의 노 어그 생성자

If the superclass doesn’t have an unnamed, no-argument constructor, then you must manually call one of the constructors in the superclass. Specify the superclass constructor after a colon (`:`), just before the constructor body (if any).
> 슈퍼클래스에 이름 없는, 주장이 없는 생성자가 없다면, 슈퍼클래스의 생성자 중 하나를 수동으로 호출해야 합니다. 생성자 본문(있는 경우) 바로 앞에 콜론(:) 뒤에 슈퍼클래스 생성자를 지정하십시오.

Because the arguments to the superclass constructor are evaluated before invoking the constructor, an argument can be an expression such as a function call:
> 슈퍼클래스 생성자에 대한 인수는 생성자를 호출하기 전에 평가되기 때문에, 인수는 함수 호출과 같은 표현식일 수 있다:

```dart
class Employee extends Person {
  Employee() : super.fromJson(fetchDefaultData());
  // ···
}
```

> [!WARNING]
> Arguments to the superclass constructor don’t have access to `this`. For example, arguments can call static methods but not instance methods.
> > 슈퍼클래스 생성자에 대한 논쟁은 이것에 접근할 수 없다. 예를 들어, 인수는 정적 메소드를 호출할 수 있지만 인스턴스 메소드는 호출할 수 없다.

#### Super parameters
To avoid having to manually pass each parameter into the super invocation of a constructor, you can use super-initializer parameters to forward parameters to the specified or default superclass constructor. This feature can’t be used with redirecting constructors. Super-initializer parameters have similar syntax and semantics to [initializing formal parameters](https://dart.dev/language/constructors#initializing-formal-parameters):
> 각 매개 변수를 생성자의 슈퍼 호출에 수동으로 전달하지 않으려면, 슈퍼이니셜라이저 매개 변수를 사용하여 매개 변수를 지정된 또는 기본 슈퍼클래스 생성자에게 전달할 수 있습니다. 이 기능은 리디렉션 생성자와 함께 사용할 수 없습니다. 슈퍼이니셜라이저 매개 변수는 공식 매개 변수를 초기화하는 것과 유사한 구문과 의미를 가지고 있다:

```dart
class Vector2d {
  final double x;
  final double y;

  Vector2d(this.x, this.y);
}

class Vector3d extends Vector2d {
  final double z;

  // Forward the x and y parameters to the default super constructor like:
  // Vector3d(final double x, final double y, this.z) : super(x, y);
  Vector3d(super.x, super.y, this.z);
}
```

Super-initializer parameters cannot be positional if the super-constructor invocation already has positional arguments, but they can always be named:
> 슈퍼 생성자 호출에 이미 위치 인수가 있는 경우 슈퍼이니셜라이저 매개 변수는 위치적일 수 없지만, 항상 이름을 지정할 수 있습니다.

```dart
class Vector2d {
  // ...

  Vector2d.named({required this.x, required this.y});
}

class Vector3d extends Vector2d {
  // ...

  // Forward the y parameter to the named super constructor like:
  // Vector3d.yzPlane({required double y, required this.z})
  //       : super.named(x: 0, y: y);
  Vector3d.yzPlane({required super.y, required this.z}) : super.named(x: 0);
}
```

### Initializer list
Besides invoking a superclass constructor, you can also initialize instance variables before the constructor body runs. Separate initializers with commas.
> 슈퍼클래스 생성자를 호출하는 것 외에도, 생성자 본문이 실행되기 전에 인스턴스 변수를 초기화할 수도 있습니다. 쉼표로 이니셜을 분리하세요.

```dart
// Initializer list sets instance variables before
// the constructor body runs.
Point.fromJson(Map<String, double> json)
    : x = json['x']!,
      y = json['y']! {
  print('In Point.fromJson(): ($x, $y)');
}
```

> [!WARNING]
> The right-hand side of an initializer doesn’t have access to `this`.
> > 이니셜라이저의 오른쪽은 이것에 접근할 수 없습니다.

During development, you can validate inputs by using `assert` in the initializer list.
> 개발 중에, 이니셜라이저 목록에서 주장을 사용하여 입력을 검증할 수 있습니다.

```dart
Point.withAssert(this.x, this.y) : assert(x >= 0) {
  print('In Point.withAssert(): ($x, $y)');
}
```

## Redirecting constructors
Sometimes a constructor’s only purpose is to redirect to another constructor in the same class. A redirecting constructor’s body is empty, with the constructor call (using `this` instead of the class name) appearing after a colon (:).
> 때때로 생성자의 유일한 목적은 같은 클래스의 다른 생성자에게 리디렉션하는 것이다. 리디렉션 생성자의 본문은 비어 있으며, 생성자 호출(클래스 이름 대신 이것을 사용)은 콜론(:) 뒤에 나타납니다.

```dart
class Point {
  double x, y;

  // The main constructor for this class.
  Point(this.x, this.y);

  // Delegates to the main constructor.
  Point.alongXAxis(double x) : this(x, 0);
}
```

### Constant constructors
If your class produces objects that never change, you can make these objects compile-time constants. To do this, define a `const` constructor and make sure that all instance variables are `final`
> 클래스가 절대 변하지 않는 객체를 생성한다면, 이러한 객체를 컴파일 시간 상수로 만들 수 있습니다. 이렇게 하려면, const 생성자를 정의하고 모든 인스턴스 변수가 최종인지 확인하세요.

```dart
class ImmutablePoint {
  static const ImmutablePoint origin = ImmutablePoint(0, 0);

  final double x, y;

  const ImmutablePoint(this.x, this.y);
}
```

Constant constructors don’t always create constants. For details, see the section on [using constructors](https://dart.dev/language/classes#using-constructors).
> 상수 생성자가 항상 상수를 만드는 것은 아니다. 자세한 내용은 생성자 사용에 대한 섹션을 참조하십시오.

### Factory constructors
Use the `factory` keyword when implementing a constructor that doesn’t always create a new instance of its class. For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype. Another use case for factory constructors is initializing a final variable using logic that can’t be handled in the initializer list.
> 항상 클래스의 새 인스턴스를 만들지 않는 생성자를 구현할 때 공장 키워드를 사용하세요. 예를 들어, 공장 생성자는 캐시에서 인스턴스를 반환하거나 하위 유형의 인스턴스를 반환할 수 있습니다. 공장 생성자를 위한 또 다른 사용 사례는 이니셜라이저 목록에서 처리할 수 없는 논리를 사용하여 최종 변수를 초기화하는 것이다.

> [!TIP]
> Another way to handle late initialization of a final variable is to [use `late final` (carefully!)](https://dart.dev/effective-dart/design#avoid-public-late-final-fields-without-initializers).
> > 최종 변수의 늦은 초기화를 처리하는 또 다른 방법은 늦은 최종(조심히!)을 사용하는 것이다.

In the following example, the `Logger` factory constructor returns objects from a cache, and the `Logger.fromJson`factory constructor initializes a final variable from a JSON object.
> 다음 예에서 로거 팩토리 생성자는 캐시에서 객체를 반환하고 Logger.fromJson 팩토리 생성자는 JSON 객체에서 최종 변수를 초기화합니다.

```dart
class Logger {
  final String name;
  bool mute = false;

  // _cache is library-private, thanks to
  // the _ in front of its name.
  static final Map<String, Logger> _cache = <String, Logger>{};

  factory Logger(String name) {
    return _cache.putIfAbsent(name, () => Logger._internal(name));
  }

  factory Logger.fromJson(Map<String, Object> json) {
    return Logger(json['name'].toString());
  }

  Logger._internal(this.name);

  void log(String msg) {
    if (!mute) print(msg);
  }
}
```

> [!NOTE]
> Factory constructors have no access to `this`.
> > 공장 건설자들은 이것에 접근할 수 없다.


Invoke a factory constructor just like you would any other constructor:
> 다른 생성자처럼 공장 생성자를 호출하세요:

```dart
var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
```