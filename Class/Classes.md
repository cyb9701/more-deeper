#classes #objects

---
## Docs
https://dart.dev/language/classes

Dart is an object-oriented language with classes and mixin-based inheritance. Every object is an instance of a class, and all classes except `Null` descend from [`Object`](https://api.dart.dev/stable/dart-core/Object-class.html). _Mixin-based inheritance_ means that although every class (except for the [top class](https://dart.dev/null-safety/understanding-null-safety#top-and-bottom), `Object?`) has exactly one superclass, a class body can be reused in multiple class hierarchies. [Extension methods](https://dart.dev/language/extension-methods)are a way to add functionality to a class without changing the class or creating a subclass. [Class modifiers](https://dart.dev/language/class-modifiers) allow you to control how libraries can subtype a class.
> 다트는 클래스와 믹스인 기반 상속이 있는 객체 지향 언어이다. 모든 객체는 클래스의 인스턴스이며, Null을 제외한 모든 클래스는 객체에서 내려온다. 믹싱 기반 상속은 모든 클래스를 의미합니다 (상위 클래스를 제외하고, 객체?) 정확히 하나의 슈퍼클래스가 있으며, 클래스 본문은 여러 클래스 계층에서 재사용될 수 있다. 확장 방법은 클래스를 변경하거나 서브클래스를 만들지 않고도 클래스에 기능을 추가하는 방법입니다. 클래스 수정자를 사용하면 라이브러리가 클래스를 하위 유형으로 입력하는 방법을 제어할 수 있습니다.

### Using class members
Objects have _members_ consisting of functions and data (_methods_ and _instance variables_, respectively). When you call a method, you _invoke_ it on an object: the method has access to that object’s functions and data.
> 객체에는 함수와 데이터(각각 메서드와 인스턴스 변수)로 구성된 멤버가 있습니다. 메서드를 호출할 때, 객체에서 호출합니다: 메서드는 해당 객체의 함수와 데이터에 액세스할 수 있습니다.

Use a dot (`.`) to refer to an instance variable or method:
> 인스턴스 변수나 메소드를 참조하려면 점(.)을 사용하세요:

```dart
var p = Point(2, 2);

// Get the value of y.
assert(p.y == 2);

// Invoke distanceTo() on p.
double distance = p.distanceTo(Point(4, 4));
```

Use `?.` instead of `.` to avoid an exception when the leftmost operand is null:
> 가장 왼쪽 피연산자가 null일 때 예외를 피하려면 . 대신 ?.를 사용하세요:

```dart
// If p is non-null, set a variable equal to its y value.
var a = p?.y;
```

### Using constructors
You can create an object using a _constructor_. Constructor names can be either `_ClassName_` or `_ClassName_._identifier_`. For example, the following code creates `Point` objects using the `Point()` and `Point.fromJson()` constructors:
> 생성자를 사용하여 객체를 만들 수 있습니다. 생성자 이름은 ClassName 또는 ClassName.identifier일 수 있습니다. 예를 들어, 다음 코드는 Point() 및 Point.fromJson() 생성자를 사용하여 Point 객체를 만듭니다.

```dart
var p1 = Point(2, 2);
var p2 = Point.fromJson({'x': 1, 'y': 2});
```

The following code has the same effect, but uses the optional `new` keyword before the constructor name:
> 다음 코드는 같은 효과가 있지만, 생성자 이름 앞에 선택적 새 키워드를 사용합니다:

```dart
var p1 = new Point(2, 2);
var p2 = new Point.fromJson({'x': 1, 'y': 2});
```

Some classes provide [constant constructors](https://dart.dev/language/constructors#constant-constructors). To create a compile-time constant using a constant constructor, put the `const` keyword before the constructor name:
> 몇몇 클래스는 일정한 생성자를 제공한다. 상수 생성자를 사용하여 컴파일 타임 상수를 만들려면, 생성자 이름 앞에 const 키워드를 넣으세요:

```dart
var p = const ImmutablePoint(2, 2);
```

Constructing two identical compile-time constants results in a single, canonical instance:
> 두 개의 동일한 컴파일 시간 상수를 구성하면 단일 표준 인스턴스가 발생합니다.

```dart
var a = const ImmutablePoint(1, 1);
var b = const ImmutablePoint(1, 1);

assert(identical(a, b)); // They are the same instance!
```

Within a _constant context_, you can omit the `const` before a constructor or literal. For example, look at this code, which creates a const map:
> 일정한 컨텍스트 내에서, 생성자나 리터럴 앞에 const를 생략할 수 있습니다. 예를 들어, const 맵을 만드는 이 코드를 보세요:

```dart
// Lots of const keywords here.
const pointAndLine = const {
  'point': const [const ImmutablePoint(0, 0)],
  'line': const [const ImmutablePoint(1, 10), const ImmutablePoint(-2, 11)],
};
```

You can omit all but the first use of the `const` keyword:
> Const 키워드의 첫 번째 사용을 제외한 모든 것을 생략할 수 있습니다:

```dart
// Only one const, which establishes the constant context.
const pointAndLine = {
  'point': [ImmutablePoint(0, 0)],
  'line': [ImmutablePoint(1, 10), ImmutablePoint(-2, 11)],
};
```

If a constant constructor is outside of a constant context and is invoked without `const`, it creates a **non-constant object**:
> 상수 생성자가 상수 컨텍스트 외부에 있고 상수 없이 호출되는 경우, 비정수 객체를 생성합니다:

```dart
var a = const ImmutablePoint(1, 1); // Creates a constant
var b = ImmutablePoint(1, 1); // Does NOT create a constant

assert(!identical(a, b)); // NOT the same instance!
```

### Getting an object’s type
To get an object’s type at runtime, you can use the `Object` property `runtimeType`, which returns a [`Type`](https://api.dart.dev/stable/dart-core/Type-class.html) object.
> 런타임에 객체의 유형을 얻으려면, Type 객체를 반환하는 Object 속성 runtimeType을 사용할 수 있습니다.

```dart
print('The type of a is ${a.runtimeType}');
```

> [!WARNING] Warning
> Use a [type test operator](https://dart.dev/language/operators#type-test-operators) rather than `runtimeType` to test an object’s type. In production environments, the test `object is Type` is more stable than the test `object.runtimeType == Type`.
> > 객체의 유형을 테스트하려면 runtimeType 대신 유형 테스트 연산자를 사용하세요. 프로덕션 환경에서는 테스트 오브젝트.runtimeType == Type보다 테스트 오브젝트 Type이 더 안정적입니다.

Up to here, you’ve seen how to _use_ classes. The rest of this section shows how to _implement_ classes.
> 여기까지, 당신은 수업을 사용하는 방법을 보았습니다. 이 섹션의 나머지 부분은 수업을 구현하는 방법을 보여줍니다.

### Instance variables
Here’s how you declare instance variables:
> 인스턴스 변수를 선언하는 방법은 다음과 같습니다:

```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
  double z = 0; // Declare z, initially 0.
}
```

All uninitialized instance variables have the value `null`.
> 초기화되지 않은 모든 인스턴스 변수는 null 값을 갖는다.

All instance variables generate an implicit _getter_ method. Non-final instance variables and `late final` instance variables without initializers also generate an implicit _setter_ method. For details, check out [Getters and setters](https://dart.dev/language/methods#getters-and-setters).
> 모든 인스턴스 변수는 암시적 게터 메소드를 생성한다. 이니셜라이저가 없는 비최종 인스턴스 변수와 늦은 최종 인스턴스 변수도 암시적 세터 메소드를 생성합니다. 자세한 내용은 게터와 세터를 확인하세요.

If you initialize a non-`late` instance variable where it’s declared, the value is set when the instance is created, which is before the constructor and its initializer list execute. As a result, non-`late` instance variable initializers can’t access `this`.
> 선언된 늦은 인스턴스 변수를 초기화하면, 생성자와 이니셜라이저 목록이 실행되기 전에 인스턴스가 생성될 때 값이 설정됩니다. 결과적으로, 늦은 인스턴스가 아닌 변수 이니셜라이저는 이것에 접근할 수 없습니다.

```dart
class Point {
  double? x; // Declare instance variable x, initially null.
  double? y; // Declare y, initially null.
}

void main() {
  var point = Point();
  point.x = 4; // Use the setter method for x.
  assert(point.x == 4); // Use the getter method for x.
  assert(point.y == null); // Values default to null.
}
```

Instance variables can be `final`, in which case they must be set exactly once. Initialize `final`, non-`late` instance variables at declaration, using a constructor parameter, or using a constructor’s [initializer list](https://dart.dev/language/constructors#initializer-list):
> 인스턴스 변수는 최종적일 수 있으며, 이 경우 정확히 한 번 설정해야 합니다. 선언 시, 생성자 매개 변수를 사용하거나 생성자의 이니셜라이저 목록을 사용하여 최종, 늦은 인스턴스 변수를 초기화하십시오.

```dart
class ProfileMark {
  final String name;
  final DateTime start = DateTime.now();

  ProfileMark(this.name);
  ProfileMark.unnamed() : name = '';
}
```

If you need to assign the value of a `final` instance variable after the constructor body starts, you can use one of the following:
> 생성자 본문이 시작된 후 최종 인스턴스 변수의 값을 할당해야 하는 경우, 다음 중 하나를 사용할 수 있습니다.

- Use a [factory constructor](https://dart.dev/language/constructors#factory-constructors).
- Use `late final`, but [_be careful:_](https://dart.dev/effective-dart/design#avoid-public-late-final-fields-without-initializers) a `late final` without an initializer adds a setter to the API.

> - 공장 건설업자를 사용하세요.
> - 늦은 결승전을 사용하지만, 조심하세요: 이니셜라이저가 없는 늦은 결승전은 API에 세터를 추가합니다.

### Implicit interfaces
Every class implicitly defines an interface containing all the instance members of the class and of any interfaces it implements. If you want to create a class A that supports class B’s API without inheriting B’s implementation, class A should implement the B interface.
> 모든 클래스는 클래스와 구현하는 모든 인터페이스의 모든 인스턴스 멤버를 포함하는 인터페이스를 암시적으로 정의합니다. B의 구현을 상속받지 않고 클래스 B의 API를 지원하는 클래스 A를 만들고 싶다면, 클래스 A는 B 인터페이스를 구현해야 합니다.

A class implements one or more interfaces by declaring them in an `implements` clause and then providing the APIs required by the interfaces. For example:
> 클래스는 implements 절에 선언한 다음 인터페이스에 필요한 API를 제공함으로써 하나 이상의 인터페이스를 구현합니다. 예를 들어:

```dart
// A person. The implicit interface contains greet().  
// 사람. 암시적 인터페이스에는 Greeting()이 포함되어 있습니다.  
class Person {  
  // In the interface, but visible only in this library.  
  // // 인터페이스에 있지만 이 라이브러리에서만 볼 수 있습니다.  
  final String _name;  
  
  // Not in the interface, since this is a constructor.  
  // 생성자이므로 인터페이스에 없습니다.  
  Person(this._name);  
  
  // In the interface.  
  // 인터페이스에서.  
  String greet(String who) => 'Hello, $who. I am $_name.';  
}  
  
// An implementation of the Person interface.  
// Person 인터페이스의 구현입니다.  
class Impostor implements Person {  
  @override  
  // TODO: implement _name  
  String get _name => '';  
  
  // TODO: implement greet  
  @override  
  String greet(String who) => 'Hi $who. Do you know who I am?';  
}  
  
String greetBob(Person person) => person.greet('Bob');  
  
void main() {  
  print(greetBob(Person('Kathy')));  
  print(greetBob(Impostor()));  
}
```

Here’s an example of specifying that a class implements multiple interfaces:
> 다음은 클래스가 여러 인터페이스를 구현하도록 지정하는 예입니다:

```dart
class Point implements Comparable, Location {...}
```

### Class variables and methods
Use the `static` keyword to implement class-wide variables and methods.
> 정적 키워드를 사용하여 클래스 차원의 변수와 메소드를 구현하세요.

#### Static variables
Static variables (class variables) are useful for class-wide state and constants:
> 정적 변수(클래스 변수)는 클래스 전체 상태와 상수에 유용합니다:

```dart
class Queue {
  static const initialCapacity = 16;
  // ···
}

void main() {
  assert(Queue.initialCapacity == 16);
}
```

Static variables aren’t initialized until they’re used.
> 정적 변수는 사용될 때까지 초기화되지 않는다.


> [!NOTE] Note
> This page follows the [style guide recommendation](https://dart.dev/effective-dart/style#identifiers) of preferring `lowerCamelCase` for constant names.
> > 이 페이지는 상수 이름을 위해 lowerCamelCase를 선호하는 스타일 가이드 권장 사항을 따릅니다.

#### Static methods
Static methods (class methods) don’t operate on an instance, and thus don’t have access to `this`. They do, however, have access to static variables. As the following example shows, you invoke static methods directly on a class:
> 정적 메서드(클래스 메서드)는 인스턴스에서 작동하지 않으므로 이에 접근할 수 없습니다. 그러나, 그들은 정적 변수에 접근할 수 있다. 다음 예에서 볼 수 있듯이, 클래스에서 직접 정적 메서드를 호출합니다:

```dart
import 'dart:math';

class Point {
  double x, y;
  Point(this.x, this.y);

  static double distanceBetween(Point a, Point b) {
    var dx = a.x - b.x;
    var dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }
}

void main() {
  var a = Point(2, 2);
  var b = Point(4, 4);
  var distance = Point.distanceBetween(a, b);
  assert(2.8 < distance && distance < 2.9);
  print(distance);
}
```

> [!NOTE] Note
> Consider using top-level functions, instead of static methods, for common or widely used utilities and functionality.
> > 일반적이거나 널리 사용되는 유틸리티와 기능에 대해 정적 방법 대신 최상위 기능을 사용하는 것을 고려하십시오.

You can use static methods as compile-time constants. For example, you can pass a static method as a parameter to a constant constructor.
> 정적 메소드를 컴파일 타임 상수로 사용할 수 있습니다. 예를 들어, 정적 메서드를 상수 생성자에 매개 변수로 전달할 수 있습니다.
> 