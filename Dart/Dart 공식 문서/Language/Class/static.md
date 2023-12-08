#class 

---
## [Docs] Classes | Class variables and methods
https://dart.dev/language/classes#class-variables-and-methods

Use the `static` keyword to implement class-wide variables and methods.
> 클래스 전체 변수와 메서드를 구현하려면 정적 키워드를 사용합니다.

### Static variables

Static variables (class variables) are useful for class-wide state and constants:
> 정적 변수(클래스 변수)는 클래스 전체의 상태 및 상수에 유용합니다:

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
> 정적 변수는 사용될 때까지 초기화되지 않습니다.

> [!NOTE] Note
> This page follows the [style guide recommendation](https://dart.dev/effective-dart/style#identifiers) of preferring `lowerCamelCase` for constant names.
> > 이 페이지는 상수 이름에 lowerCamelCase를 선호한다는 스타일 가이드 권장 사항을 따릅니다.

### Static methods

Static methods (class methods) don’t operate on an instance, and thus don’t have access to `this`. They do, however, have access to static variables. As the following example shows, you invoke static methods directly on a class:
> 정적 메서드(클래스 메서드)는 인스턴스에서 작동하지 않으므로 이에 액세스할 수 없습니다. 하지만 정적 변수에는 액세스할 수 있습니다. 다음 예제에서 볼 수 있듯이 클래스에서 직접 정적 메서드를 호출합니다:

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
> Consider using top-level functions, instead of static methods, for common or widely used utilities and functionality. [[Classes and mixins#[Docs] AVOID defining a class that contains only static members]]
> > 일반적이거나 널리 사용되는 유틸리티 및 기능에 정적 메서드 대신 최상위 함수를 사용하는 것을 고려하세요.

You can use static methods as compile-time constants. For example, you can pass a static method as a parameter to a constant constructor.
> 정적 메서드를 컴파일 타임 상수로 사용할 수 있습니다. 예를 들어 정적 메서드를 상수 생성자에 매개변수로 전달할 수 있습니다.

---
## [Organize]
https://velog.io/@letluvrule/Dart-언어-오답노트-25.-static#static의-특징-및-장점

### 특징 & 장점
1. **메모리 효율성**: 모든 인스턴스가 `static` 변수를 공유하기 때문에, 각 인스턴스마다 별도로 메모리를 할당할 필요가 없습니다. 이는 메모리 사용을 줄이는 데 도움이 됩니다.
2. **인스턴스 생성 없이 접근 가능**: `static` 메소드나 변수는 인스턴스를 생성하지 않고도 클래스 이름을 통해 직접 접근할 수 있습니다.
3. **공유 데이터**: `static` 변수는 모든 인스턴스에 의해 공유되므로, 한 곳에서 값을 변경하면 모든 인스턴스에 영향을 미칩니다.

### 주의
- `static` 변수나 메소드는 인스턴스 변수나 메소드와 독립적이므로, `static` 메소드 내에서는 `this`키워드를 사용할 수 없습니다.
- `static` 변수나 메소드는 프로그램 실행 시점에 메모리에 로드되며, 프로그램이 종료될 때까지 메모리에 남아 있습니다. 따라서 과도한 `static` 사용은 메모리 낭비를 초래할 수 있습니다.