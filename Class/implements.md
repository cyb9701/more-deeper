#class-modifier 

---
## [Docs] Classes / Implicit interfaces
https://dart.dev/language/classes#implicit-interfaces

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

---
## [Organize]
슈퍼 클래스를 구현한다는 것을 의미한다. 슈퍼 클래스에 정의되어 있는 모든 속성, 변수, 함수를 가져오지만 전부 `override`하여 구현해야한다.

```dart
abstract class Animal {
  void breathe() {
    print('breathe');
  }

  void move() {
    print('move');
  }
}

class Cat implements Animal {
  @override
  void breathe() {
    print('cat breathes');
  }

  @override
  void move() {
    print('cat moves');
  }
}

void main() {
  Cat cat = Cat();
  cat.breathe();
  // 결과: 'cat breathes'
  cat.move();
  // 결과: 'cat moves'
}
```