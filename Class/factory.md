#class 

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