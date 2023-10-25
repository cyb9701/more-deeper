#classes #objects 

---
## Docs
https://dart.dev/language/methods

### Instance methods
Instance methods on objects can access instance variables and `this`. The `distanceTo()` method in the following sample is an example of an instance method:
> 객체의 인스턴스 메서드는 인스턴스 변수와 이 변수에 접근할 수 있습니다. 다음 샘플의 distanceTo() 메서드는 인스턴스 메서드의 예시입니다:

```dart
import 'dart:math';

class Point {
  final double x;
  final double y;

  Point(this.x, this.y);

  double distanceTo(Point other) {
    var dx = x - other.x;
    var dy = y - other.y;
    return sqrt(dx * dx + dy * dy);
  }
}
```

### Getters and setters
Getters and setters are special methods that provide read and write access to an object’s properties. Recall that each instance variable has an implicit getter, plus a setter if appropriate. You can create additional properties by implementing getters and setters, using the `get` and `set` keywords:
> 게터와 세터는 객체의 프로퍼티에 대한 읽기 및 쓰기 액세스를 제공하는 특수 메서드입니다. 각 인스턴스 변수에는 암시적 게터와 적절한 경우 설정자가 있다는 것을 기억하세요. get 및 set 키워드를 사용하여 게터와 세터를 구현하여 추가 프로퍼티를 만들 수 있습니다:

```dart
class Rectangle {
  double left, top, width, height;

  Rectangle(this.left, this.top, this.width, this.height);

  // Define two calculated properties: right and bottom.
  double get right => left + width;
  set right(double value) => left = value - width;
  double get bottom => top + height;
  set bottom(double value) => top = value - height;
}

void main() {
  var rect = Rectangle(3, 4, 20, 15);
  assert(rect.left == 3);
  rect.right = 12;
  assert(rect.left == -8);
}
```

With getters and setters, you can start with instance variables, later wrapping them with methods, all without changing client code.
> 게터와 세터를 사용하면 클라이언트 코드를 변경하지 않고도 인스턴스 변수로 시작하여 나중에 메서드로 래핑할 수 있습니다.

### Abstract methods
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