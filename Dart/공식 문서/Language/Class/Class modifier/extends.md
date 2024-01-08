#class #class-modifier

---
## [Docs] Inheritance
https://dart.dev/language#inheritance

Dart has single inheritance.
> 다트에는 단일 상속이 있습니다.

```dart
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}
```

[Read more](https://dart.dev/language/extend) about extending classes, the optional `@override` annotation, and more.
> 클래스 확장, 선택적 @override 어노테이션 등에 대해 자세히 알아보세요.

---
## [Docs] Extend a class
https://dart.dev/language/extend

Use`extends`to create a subclass, and`super`to refer to the superclass:
> 확장을 사용하여 서브클래스를 만들고, 슈퍼클래스를 참조하기 위해 슈퍼를 사용하세요:

```dart
class Television {
  void turnOn() {
    _illuminateDisplay();
    _activateIrSensor();
  }
// ···
}

class SmartTelevision extends Television {
  void turnOn() {
    super.turnOn();
    _bootNetworkInterface();
    _initializeMemory();
    _upgradeApps();
  }
// ···
}
```

For another usage of`extends`, see the discussion of [parameterized types](https://dart.dev/language/generics#restricting-the-parameterized-type)on the Generics page.
> 확장의 또 다른 사용법은 제네릭 페이지에서 매개 변수화된 유형에 대한 논의를 참조하십시오.

### Overriding members

Subclasses can override instance methods (including[operators](https://dart.dev/language/methods#operators)), getters,
and setters. You can use the`@override`annotation to indicate that you are intentionally overriding a member:
> 서브클래스는 인스턴스 메서드(연산자 포함), 게터 및 세터를 재정의할 수 있습니다. @Override 주석을 사용하여 의도적으로 회원을 재정의하고 있음을 나타낼 수 있습니다:

```dart
class Television {
  // ···
  set contrast(int value) {
    ...
  }
}

class SmartTelevision extends Television {
  @override
  set contrast(num value) {
    ...
  }
// ···
}
```

An overriding method declaration must match the method (or methods) that it overrides in several ways:
> 재정의 메서드 선언은 여러 가지 방법으로 재정의하는 메서드(또는 메서드)와 일치해야 합니다:

- The return type must be the same type as (or a subtype of) the overridden method’s return type.
- Argument types must be the same type as (or a supertype of) the overridden method’s argument types. In the preceding
  example, the`contrast`setter of`SmartTelevision`changes the argument type from`int`to a supertype,`num`.
- If the overridden method accepts_n_positional parameters, then the overriding method must also accept_n_positional
  parameters.
- A[generic method](https://dart.dev/language/generics#using-generic-methods)can’t override a non-generic one, and a
  non-generic method can’t override a generic one.

> - 반환 유형은 재정의된 메서드의 반환 유형과 동일한 유형(또는 하위 유형)이어야 합니다.
> - 인수 유형은 재정의된 메서드의 인수 유형과 동일한 유형(또는 슈퍼타입)이어야 합니다. 앞의 예에서, SmartTelevision의 콘트라스트 세터는 인수 유형을 int에서 슈퍼타입 num으로 변경합니다.
> - 재정의된 메서드가 n개의 위치 매개 변수를 받아들인다면, 재정의된 메서드는 n개의 위치 매개 변수도 받아들여야 한다.
> - 제네릭 메소드는 제네릭이 아닌 메소드를 재정의할 수 없으며, 제네릭 메소드는 제네릭 메소드를 재정의할 수 없다.

Sometimes you might want to narrow the type of a method parameter or an instance variable. This violates the normal
rules, and it’s similar to a downcast in that it can cause a type error at runtime. Still, narrowing the type is
possible if the code can guarantee that a type error won’t occur. In this case, you can use
the[`covariant` keyword](https://dart.dev/guides/language/sound-problems#the-covariant-keyword)in a parameter
declaration. For details, see the[Dart language specification](https://dart.dev/guides/language/spec).
> 때때로 메소드 매개 변수나 인스턴스 변수의 유형을 좁히고 싶을 수도 있습니다. 이것은 일반적인 규칙을 위반하며, 런타임에 유형 오류를 일으킬 수 있다는 점에서 다운캐스트와 유사합니다. 여전히, 코드가 유형 오류가
> 발생하지 않도록 보장할 수 있다면 유형을 좁힐 수 있습니다. 이 경우, 매개 변수 선언에서 공변 키워드를 사용할 수 있습니다. 자세한 내용은 다트 언어 사양을 참조하십시오.


> [!WARNING]
> If you override`==`, you should also override Object’s`hashCode`getter. For an example of overriding`==`and`hashCode`,
> see[Implementing map keys](https://dart.dev/guides/libraries/library-tour#implementing-map-keys).
>  > `==`를 재정의하면, 객체의 해시코드 게터도 재정의해야 합니다. ==와 해시코드를 재정의하는 예는 맵 키 구현을 참조하십시오.

### noSuchMethod()

To detect or react whenever code attempts to use a non-existent method or instance variable, you can
override`noSuchMethod()`:
> 코드가 존재하지 않는 방법이나 인스턴스 변수를 사용하려고 할 때마다 감지하거나 반응하려면 noSuchMethod()를 재정의할 수 있습니다.

```dart
class A {
  // Unless you override noSuchMethod, using a
  // non-existent member results in a NoSuchMethodError.
  @override
  void noSuchMethod(Invocation invocation) {
    print('You tried to use a non-existent member: '
        '${invocation.memberName}');
  }
}
```

You**can’t invoke**an unimplemented method unless**one**of the following is true:
> 다음 중 하나가 사실이 아니라면 구현되지 않은 메소드를 호출할 수 없습니다:

- The receiver has the static type`dynamic`.

- The receiver has a static type that defines the unimplemented method (abstract is OK), and the dynamic type of the
  receiver has an implementation of`noSuchMethod()`that’s different from the one in class`Object`.

> - 수신기는 정적 유형의 동적을 가지고 있다.
> - 수신기에는 구현되지 않은 메서드를 정의하는 정적 유형이 있으며(추상자는 괜찮습니다), 수신기의 동적 유형에는 클래스 Object의 것과 다른 noSuchMethod() 구현이 있습니다.


For more information, see the
informal[noSuchMethod forwarding specification.](https://github.com/dart-lang/language/blob/main/archive/feature-specifications/nosuchmethod-forwarding.md)
> 자세한 내용은 비공식적인 noSuchMethod 전달 사양을 참조하십시오.

---
## [Organize]

Dart에는 단일 상속이 가능하다.
상속은 클래스의 멤버를 물려주는 것을 의미한다.
이때 물려주는 쪽은 부모 클래스 혹은 Super Class 라고 하고 상속 받는 쪽을 자식 클래스 혹은 Sub Class 라고 한다.

```dart
class 부모 클래스명 {
	멤버 변수;
	멤버 함수(){}
}

class 자식 클래스명 extends 부모 클래스명 {
	@override
	멤버 함수(){}
}
```

자식 클래스는 슈퍼 클래스의 멤버 변수와 멤버 함수를 모두 상속 받는다.
따라서 자식 클래스에서 선언하지 않아도 사용이 가능하다.
또한 슈퍼 클래스를 상속 받게 되면 슈퍼 클래스의 멤버 함수를 `override` 하지 않아도 문제가 없다.

---
## [Example]

```dart
class Human {
  final String name;

  Human({required this.name});

  void sayHellow() {
    print('Hello my name is $name');
  }
}

class Player extends Human {
  Player({required super.name});
}

void main() {
  final player = Player(name: 'nico');
  player.sayHellow();
}

// print: Hello my name is nico
```

```dart
class Human {
  final String name;

  Human({required this.name});

  void sayHellow() {
    print('Hello my name is $name');
  }
}

class Player extends Human {
  Player({required super.name});

  @override
  void sayHellow() {
    print('I am player. $name');
  }
}

void main() {
  final player = Player(name: 'nico');
  player.sayHellow();
}

// print: I am player. nico
```

```dart
class Human {
  final String name;

  Human({required this.name});

  void sayHellow() {
    print('Hello my name is $name');
  }
}

class Player extends Human {
  Player({required super.name});

  @override
  void sayHellow() {
    super.sayHellow();
    print('I am player. $name');
  }
}

void main() {
  final player = Player(name: 'nico');
  player.sayHellow();
}

// print : 
// Hello my name is nico
//
// I am player. nico
```