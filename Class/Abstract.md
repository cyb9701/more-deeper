#abstract #extends #implements

---
## [Docs] abstract
https://dart.dev/language/class-modifiers#abstract

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

---
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

---
## [Example]
```dart
abstract class Person {  
  eat();  
    
  walk();  
  
  void sleep() {  
    print('Person must sleep');  
  }  
}  
  
class Developer extends Person {  
  // Must override.  
  @override  
  void eat() {  
    print('Developer eat a meal');  
  }  
  
  // Must override.  
  @override  
  void walk() {  
   print('Walk');  
  }  
}  
  
void main() {   
  // Person person = Person();  // Error. 
  Person person = Developer();  
  person.eat(); // print.   
  person.sleep();  
}
```