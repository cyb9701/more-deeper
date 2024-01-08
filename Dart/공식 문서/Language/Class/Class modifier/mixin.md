#class #class-modifier 

---
## [Docs] Mixins
https://dart.dev/language/mixins#class-mixin-or-mixin-class

Mixins are a way of defining code that can be reused in multiple class hierarchies. They are intended to provide member implementations en masse.
> 믹스인은 ==여러 클래스 계층 구조== 에서 재사용할 수 있는 코드를 정의하는 방법입니다. 믹스인은 멤버 구현을 일괄적으로 제공하기 위한 것입니다.

To use a mixin, use the `with` keyword followed by one or more mixin names. The following example shows two classes that use mixins:
> 믹스인을 사용하려면 with 키워드 뒤에 하나 이상의 믹스인 이름을 사용합니다. 다음 예제는 믹스인을 사용하는 두 개의 클래스를 보여줍니다:

```dart
class Musician extends Performer with Musical {
  // ···
}

class Maestro extends Person with Musical, Aggressive, Demented {
  Maestro(String maestroName) {
    name = maestroName;
    canConduct = true;
  }
}
```

To define a mixin, use the `mixin` declaration. In the rare case where you need to define both a mixin _and_ a class, you can use the [`mixin class` declaration](https://dart.dev/language/mixins#class-mixin-or-mixin-class) [[#`class`, `mixin`, or `mixin class`?]]. 
> 믹스인을 정의하려면 믹스인 선언을 사용합니다. 드물지만 믹스인과 클래스를 모두 정의해야 하는 경우 믹스인 클래스 선언을 사용할 수 있습니다.

Mixins and mixin classes cannot have an `extends` clause, and must not declare any generative constructors.
> 믹스인과 믹스인 클래스에는 extends 절을 사용할 수 없으며 생성 생성자를 선언해서는 안 됩니다.

For example:

```dart
mixin Musical {
  bool canPlayPiano = false;
  bool canCompose = false;
  bool canConduct = false;

  void entertainMe() {
    if (canPlayPiano) {
      print('Playing piano');
    } else if (canConduct) {
      print('Waving hands');
    } else {
      print('Humming to self');
    }
  }
}
```

Sometimes you might want to restrict the types that can use a mixin. For example, the mixin might depend on being able to invoke a method that the mixin doesn’t define. As the following example shows, you can restrict a mixin’s use by using the `on` keyword to specify the required superclass:
> 때로는 믹스인을 사용할 수 있는 유형을 제한하고 싶을 수도 있습니다. 예를 들어, 믹스인이 정의하지 않은 메서드를 호출할 수 있는지 여부에 따라 믹스인이 달라질 수 있습니다. 다음 예제에서 볼 수 있듯이, on 키워드를 사용하여 필요한 슈퍼클래스를 지정함으로써 믹스인의 사용을 제한할 수 있습니다:

```dart
class Musician {
  // ...
}
mixin MusicalPerformer on Musician {
  // ...
}
class SingerDancer extends Musician with MusicalPerformer {
  // ...
}

// X - Error.
class FootballPalyer extends Player with MusicalPerformer {
  // ...
}
```

In the preceding code, only classes that extend or implement the `Musician` class can use the mixin `MusicalPerformer`. Because `SingerDancer` extends `Musician`, `SingerDancer` can mix in `MusicalPerformer`.
> 앞의 코드에서는 Musician 클래스를 확장하거나 구현하는 클래스만 믹스인 MusicalPerformer를 사용할 수 있습니다. SingerDancer는 Musician을 확장하기 때문에 SingerDancer는 MusicalPerformer에서 믹싱할 수 있습니다.

### `class`, `mixin`, or `mixin class`?
A `mixin` declaration defines a mixin. A `class` declaration defines a [class](https://dart.dev/language/classes). A `mixin class` declaration defines a class that is usable as both a regular class and a mixin, with the same name and the same type.
> 믹스인 선언은 믹스인을 정의합니다. 클래스 선언은 클래스를 정의합니다. 믹스인 클래스 선언은 이름과 유형이 같은 일반 클래스와 믹스인 모두로 사용할 수 있는 클래스를 정의합니다.

Any restrictions that apply to classes or mixins also apply to mixin classes:
> 클래스 또는 믹스인에 적용되는 모든 제한 사항은 믹스인 클래스에도 적용됩니다:

- Mixins can’t have `extends` or `with` clauses, so neither can a `mixin class`.
- Classes can’t have an `on` clause, so neither can a `mixin class`.

> - 믹스인에는 확장자나 절이 있을 수 없으므로 믹스인 클래스도 마찬가지입니다.
> - 클래스에는 on 절이 있을 수 없으므로 믹스인 클래스에도 절이 있을 수 없습니다.

#### `abstract mixin class`
You can achieve similar behavior to the `on` directive for a mixin class. Make the mixin class `abstract` and define the abstract methods its behavior depends on:
> 믹스인 클래스에 대해 on 지시어와 유사한 동작을 구현할 수 있습니다. 믹스인 클래스를 추상화하고 그 동작이 의존하는 추상 메서드를 정의합니다:

```dart
abstract mixin class Musician {
  // No 'on' clause, but an abstract method that other types must define if 
  // they want to use (mix in or extend) Musician: 
  void playInstrument(String instrumentName);

  void playPiano() {
    playInstrument('Piano');
  }
  void playFlute() {
    playInstrument('Flute');
  }
}

class Virtuoso with Musician { // Use Musician as a mixin
  @override
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName beautifully');
  }  
} 

class Novice extends Musician { // Use Musician as a class
  @override
  void playInstrument(String instrumentName) {
    print('Plays the $instrumentName poorly');
  }  
} 
```

By declaring the `Musician` mixin as abstract, you force any type that uses it to define the abstract method upon which its behavior depends.
> 뮤지션 믹스인을 추상적으로 선언하면 이를 사용하는 모든 유형이 해당 동작이 의존하는 추상 메서드를 정의하도록 강제합니다.

This is similar to how the `on` directive ensures a mixin has access to any interfaces it depends on by specifying the superclass of that interface.
> 이는 on 지시어가 해당 인터페이스의 슈퍼클래스를 지정하여 믹스인이 의존하는 모든 인터페이스에 접근할 수 있도록 하는 것과 유사합니다.

---
## [Organize]

### 언제 사용할까?
https://paulaner80.tistory.com/entry/Dart-mixin-이란-1

<img width="820" alt="mixin" src="https://github.com/cyb9701/more-deeper/assets/59527787/b4b444d9-f3aa-4eb8-ae99-2edacc5558c4">

`Animal`이라는 슈퍼클래스가 있습니다. `Mammal`, `Bird`, `Fish`가 그 클래스를 상속합니다. 가장 마지막에는 콘크리트 클래스들이 있습니다. 작은 사각형은 행동을 나타냅니다. 
예를 들어, 파란색 사각형은이 동작을하는 클래스의 인스턴스가 수영 할 수 있음을 나타냅니다. 어떤 동물들은 공통적 인 행동을 공유합니다. 

한 클래스가 하나 이상의 수퍼 클래스를 가질 수 있다면 쉽게 할 수 있습니다. 
3개의 클래스(`Walker`, `Swimmer`, `Flyer`)를 만든 후 콘크리트클래스에게 이 클래스를 적절히 상속시켜주기 만하면 됩니다. 그러나 Dart에서는 모든 클래스에는(`Object` 제외) 하나의 슈퍼 클래스만 있습니다.

`Walker` 클래스를 상속하는 대신 인터페이스 인 것처럼 구현할 수 있지만 여러 클래스에서 동작을 구현해야하므로 좋은 해결책은 아닙니다. (구현하는 모든 `Class`에서 동작을 모두 `override` 해야한다)
여러 클래스 계층에서 클래스의 코드를 재사용 할 수있는 방법이 필요합니다.
