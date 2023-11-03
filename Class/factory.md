#class #constructor 

---
## [Docs] Constructors | Factory constructors
https://dart.dev/language/constructors#factory-constructors

Use the `factory` keyword when implementing a constructor that doesn’t always create a new instance of its class. For example, a factory constructor might return an instance from a cache, or it might return an instance of a subtype. Another use case for factory constructors is initializing a final variable using logic that can’t be handled in the initializer list.
> 항상 해당 클래스의 새 인스턴스를 생성하지 않는 생성자를 구현할 때는 팩토리 키워드를 사용합니다. 예를 들어 팩토리 생성자는 캐시에서 인스턴스를 반환하거나 하위 유형의 인스턴스를 반환할 수 있습니다. 팩토리 생성자의 또 다른 사용 사례는 이니셜라이저 목록에서 처리할 수 없는 로직을 사용하여 최종 변수를 초기화하는 것입니다.

> [!UPDATE] Tip
> Another way to handle late initialization of a final variable is to [use `late final` (carefully!)](https://dart.dev/effective-dart/design#avoid-public-late-final-fields-without-initializers).
> > 최종 변수의 늦은 초기화를 처리하는 또 다른 방법은 (신중하게!) 늦은 최종을 사용하는 것입니다.

In the following example, the `Logger` factory constructor returns objects from a cache, and the `Logger.fromJson`factory constructor initializes a final variable from a JSON object.
> 다음 예제에서는 Logger 팩토리 생성자가 캐시에서 객체를 반환하고 Logger.fromJson 팩토리 생성자가 JSON 객체에서 최종 변수를 초기화합니다.

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

> [!INFO] Note
> Factory constructors have no access to `this`.
> > 팩토리 생성자는 이 기능에 액세스할 수 없습니다.


Invoke a factory constructor just like you would any other constructor:
> 다른 생성자와 마찬가지로 팩토리 생성자를 호출합니다:

```dart
var logger = Logger('UI');
logger.log('Button clicked');

var logMap = {'name': 'UI'};
var loggerJson = Logger.fromJson(logMap);
```

---
## [Organize]
https://another-light.tistory.com/77

매번 인스턴스를 새로 생성하여 비용이 많이 드는 (generative) constructor와 달리 factory에는 몇 가지 특징이 있다.

- 기존에 이미 생성된 인스턴스가 있다면 return 하여 재사용한다.
- ==하나의 클래스에서 하나의 인스턴스만 생성한다(싱글톤 패턴).==
- 서브 클래스 인스턴스를 리턴할 때 사용할 수 있다.
- Factory constructors 에서는 this 에 접근할 수 없다.

factory는 '클래스와 같은 타입의 인스턴스' 또는 '메서드를 구현하는 인스턴스'를 리턴하기만 하면 된다. 이렇게 생성된 인스턴스는 **기존에 생성된 인스턴스가 아니라면 새롭게 생성되고, 기존 인스턴스가 있다면 기존 것을 리턴**한다.

---
## [QA]
Q. factory 대신에 static 을 사용해도 되는거 아닌가요? factory는 인스턴스를 생성하지만 static은 인스턴스를 생성하지 않기 때문에 더 좋은 코드가 아닌가요?

```dart
class Book {
  final String title;

  Book({this.title});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
    );
  }
}
```

```dart
class Book {
  final String title;

  Book({this.title});

  static Book fromJson(Map<String, dynamic> json) {
    return Book(
      title: json['title'],
    );
  }
}
```

A. 네, factory 메서드 대신 static 메서드를 사용하여 인스턴스를 생성하는 것은 가능합니다.

factory 메서드와 static 메서드는 모두 클래스의 메서드를 정의하는 방법 중 하나입니다. factory 메서드는 인스턴스를 생성하고 반환하는 특별한 종류의 메서드이며, static 메서드는 인스턴스를 생성하지 않고 클래스 수준에서 호출되는 메서드입니다.

factory 메서드는 인스턴스를 생성하기 전에 추가적인 로직을 수행하거나 캐싱된 인스턴스를 반환하는 등의 유연한 인스턴스 생성 방식을 제공합니다. 반면에 static 메서드는 단순히 클래스 수준에서 호출되는 메서드로, 인스턴스를 생성하지 않습니다.

따라서 factory 메서드와 static 메서드를 사용하는 것은 상황에 따라 달라집니다. 만약 인스턴스 생성에 특별한 로직이 필요하지 않고 단순히 인스턴스를 생성하고 반환하는 용도라면, static 메서드를 사용하는 것이 더 간결하고 직관적일 수 있습니다.

위의 예시 코드에서 factory 메서드를 static 메서드로 변경한다면, 동일한 결과를 얻을 수 있습니다. 따라서 factory 메서드와 static 메서드 중 선택하여 사용하셔도 됩니다.