#types 

---
## Docs
https://dart.dev/language/generics

If you look at the API documentation for the basic array type, [`List`](https://api.dart.dev/stable/dart-core/List-class.html), you’ll see that the type is actually `List<E>`. The <…> notation marks List as a _generic_ (or _parameterized_) type—a type that has formal type parameters. [By convention](https://dart.dev/effective-dart/design#do-follow-existing-mnemonic-conventions-when-naming-type-parameters), most type variables have single-letter names, such as E, T, S, K, and V.
> 기본 배열 유형인 List에 대한 API 문서를 보면, 그 유형이 실제로 List<E>라는 것을 알 수 있습니다. <...> 표기법은 목록을 공식적인 유형 매개 변수가 있는 유형인 일반(또는 매개 변수화된) 유형으로 표시합니다. 관례에 따라, 대부분의 유형 변수는 E, T, S, K, V와 같은 단일 문자 이름을 가지고 있다.

### Why use generics?
Generics are often required for type safety, but they have more benefits than just allowing your code to run:
> 제네릭은 종종 유형 안전을 위해 필요하지만, 코드를 실행하는 것보다 더 많은 이점이 있습니다:

- Properly specifying generic types results in better generated code.
- You can use generics to reduce code duplication.

> - 일반 유형을 적절하게 지정하면 코드가 더 잘 생성됩니다.
> - 코드 중복을 줄이기 위해 일반을 사용할 수 있습니다. 

If you intend for a list to contain only strings, you can declare it as `List<String>` (read that as “list of string”). That way you, your fellow programmers, and your tools can detect that assigning a non-string to the list is probably a mistake. Here’s an example:
> 목록에 문자열만 포함하려는 경우, List<String>로 선언할 수 있습니다("문자열 목록"로 읽으십시오). 그렇게 하면 당신, 당신의 동료 프로그래머, 그리고 당신의 도구는 목록에 문자열을 할당하는 것이 아마도 실수라는 것을 감지할 수 있습니다. 여기 예시가 있습니다:

```dart
// static analysis: error/warning
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
names.add(42); // Error
```

Another reason for using generics is to reduce code duplication. Generics let you share a single interface and implementation between many types, while still taking advantage of static analysis. For example, say you create an interface for caching an object:
> 제네릭을 사용하는 또 다른 이유는 코드 중복을 줄이기 위해서이다. 제네릭을 사용하면 정적 분석을 활용하면서 여러 유형 간에 단일 인터페이스와 구현을 공유할 수 있습니다. 예를 들어, 객체를 캐싱하기 위한 인터페이스를 만든다고 가정해 봅시다:

```dart
abstract class ObjectCache {
  Object getByKey(String key);
  void setByKey(String key, Object value);
}
```

You discover that you want a string-specific version of this interface, so you create another interface:
> 이 인터페이스의 문자열별 버전을 원한다는 것을 알게 되므로, 다른 인터페이스를 만드세요:

```dart
abstract class StringCache {
  String getByKey(String key);
  void setByKey(String key, String value);
}
```

Later, you decide you want a number-specific version of this interface… You get the idea.
> 나중에, 당신은 이 인터페이스의 숫자별 버전을 원한다고 결정합니다... 당신은 아이디어를 얻을 수 있습니다.

Generic types can save you the trouble of creating all these interfaces. Instead, you can create a single interface that takes a type parameter:
> 일반 유형은 이러한 모든 인터페이스를 만드는 데 어려움을 덜어줄 수 있습니다. 대신, 유형 매개 변수를 취하는 단일 인터페이스를 만들 수 있습니다:

```dart
abstract class Cache<T> {
  T getByKey(String key);
  void setByKey(String key, T value);
}
```

In this code, T is the stand-in type. It’s a placeholder that you can think of as a type that a developer will define later.
> 이 코드에서, T는 스탠드인 유형이다. 개발자가 나중에 정의할 유형으로 생각할 수 있는 자리 표시자입니다.

### Using collection literals
List, set, and map literals can be parameterized. Parameterized literals are just like the literals you’ve already seen, except that you add `<_type_>` (for lists and sets) or `<_keyType_, _valueType_>` (for maps) before the opening bracket. Here is an example of using typed literals:
> 목록, 설정 및 지도 리터럴을 매개 변수화할 수 있습니다. 매개변수화된 리터럴은 오프닝 괄호 앞에 <type>(목록 및 세트의 경우) 또는 <keyType, valueType>(지도의 경우)을 추가하는 것을 제외하고는 이미 본 리터럴과 같습니다. 다음은 입력된 리터럴을 사용하는 예입니다:

```dart
var names = <String>['Seth', 'Kathy', 'Lars'];
var uniqueNames = <String>{'Seth', 'Kathy', 'Lars'};
var pages = <String, String>{
  'index.html': 'Homepage',
  'robots.txt': 'Hints for web robots',
  'humans.txt': 'We are people, not machines'
};
```

### Using parameterized types with constructors
To specify one or more types when using a constructor, put the types in angle brackets (`<...>`) just after the class name. For example:
> 생성자를 사용할 때 하나 이상의 유형을 지정하려면, 클래스 이름 바로 뒤에 괄호(<...>)에 유형을 넣으십시오. 예를 들어:

```dart
var nameSet = Set<String>.from(names);
```

The following code creates a map that has integer keys and values of type View:
> 다음 코드는 뷰 유형의 정수 키와 값이 있는 지도를 만듭니다:

```dart
var views = Map<int, View>();
```

### Generic collections and the types they contain
Dart generic types are _reified_, which means that they carry their type information around at runtime. For example, you can test the type of a collection:
> 다트 일반 유형은 재구성되며, 이는 런타임에 유형 정보를 가지고 다닌다는 것을 의미합니다. 예를 들어, 컬렉션의 유형을 테스트할 수 있습니다:

```dart
var names = <String>[];
names.addAll(['Seth', 'Kathy', 'Lars']);
print(names is List<String>); // true
```


> [!NOTE]
> In contrast, generics in Java use _erasure_, which means that generic type parameters are removed at runtime. In Java, you can test whether an object is a List, but you can’t test whether it’s a `List<String>`.
> > 대조적으로, 자바의 제네릭은 삭제를 사용하며, 이는 제네릭 유형 매개 변수가 런타임에 제거된다는 것을 의미합니다. 자바에서는 객체가 목록인지 테스트할 수 있지만, List<String>인지 테스트할 수는 없습니다.

### Restricting the parameterized type
When implementing a generic type, you might want to limit the types that can be provided as arguments, so that the argument must be a subtype of a particular type. You can do this using `extends`.
> 일반 유형을 구현할 때, 인수로 제공할 수 있는 유형을 제한하여 인수가 특정 유형의 하위 유형이어야 합니다. 확장을 사용하여 이것을 할 수 있습니다.

A common use case is ensuring that a type is non-nullable by making it a subtype of `Object` (instead of the default, [`Object?`](https://dart.dev/null-safety/understanding-null-safety#top-and-bottom)).
> 일반적인 사용 사례는 유형을 객체의 하위 유형으로 만들어 무효화할 수 없도록 하는 것입니다(기본 객체 대신?).

```dart
class Foo<T extends Object> {
  // Any type provided to Foo for T must be non-nullable.
}
```

You can use `extends` with other types besides `Object`. Here’s an example of extending `SomeBaseClass`, so that members of `SomeBaseClass` can be called on objects of type `T`:
> 객체 이외의 다른 유형과 함께 확장을 사용할 수 있습니다. 다음은 SomeBaseClass의 구성원이 T 유형의 객체에서 호출될 수 있도록 SomeBaseClass를 확장하는 예입니다.

```dart
class Foo<T extends SomeBaseClass> {
  // Implementation goes here...
  String toString() => "Instance of 'Foo<$T>'";
}

class Extender extends SomeBaseClass {...}
```

It’s OK to use `SomeBaseClass` or any of its subtypes as the generic argument:
> SomeBaseClass 또는 그 하위 유형을 일반적인 인수로 사용하는 것은 괜찮습니다:

```dart
var someBaseClassFoo = Foo<SomeBaseClass>();
var extenderFoo = Foo<Extender>();
```

It’s also OK to specify no generic argument:
> 일반적인 인수를 지정하지 않아도 괜찮습니다:

```dart
var foo = Foo();
print(foo); // Instance of 'Foo<SomeBaseClass>'
```

Specifying any non-`SomeBaseClass` type results in an error:
> SomeBaseClass가 아닌 유형을 지정하면 오류가 발생합니다:

```dart
// static analysis: error/warning
var foo = Foo<Object>();
```

### Using generic methods
Methods and functions also allow type arguments:
> 방법과 함수는 또한 유형 인수를 허용합니다:

```dart
T first<T>(List<T> ts) {
  // Do some initial work or error checking, then...
  T tmp = ts[0];
  // Do some additional checking or processing...
  return tmp;
}
```

Here the generic type parameter on `first` (`<T>`) allows you to use the type argument `T` in several places:
> 여기서 첫 번째(<T>)의 일반 유형 매개 변수를 사용하면 여러 곳에서 유형 인수 T를 사용할 수 있습니다:

- In the function’s return type (`T`).
- In the type of an argument (`List<T>`).
- In the type of a local variable (`T tmp`).

> - 함수의 반환 유형(T)에서.
> - 인수 유형 (List<T>).
> - 지역 변수(T tmp)의 유형.

---
## Example
### 적용 전
```dart
class Product {
  int price;
  int amount;
  String title;
  String description;
  ProductType type;

  HomeApplicance? homeApplicance;
  Clothing? clothing;
  DailyNecessity? dailyNecessity;

  Product({
    required this.price,
    required this.amount,
    required this.title,
    required this.description,
    required this.type,
  });

  setProductMoreInfoWithHomeAppliances(HomeApplicance _homeAppliances) {
    homeApplicance = _homeAppliances;
  }

  setProductMoreInfoWithClothing(Clothing _clothing) {
    clothing = _clothing;
  }

  setProductMoreInfoWithDailyNecessity(DailyNecessity _dailyNecessity) {
    dailyNecessity = _dailyNecessity;
  }

	dynamic get moreInfo {
    switch (type) {
      case ProductType.HomeAppliances:
        return homeApplicance;
      case ProductType.Clothing:
        return clothing;
      case ProductType.DailyNecessity:
        return dailyNecessity;
    }
  }
}

//api 통해서 상품 호출
var homeApplianceProduct = Product(
  price: 1000,
  amount: 100,
  title: 'TV',
  description: 'TV 설명',
  type: ProductType.HomeAppliances,
);

homeApplianceProduct.setProductMoreInfoWithHomeAppliances(
    HomeApplicance(option1: '옵션1', option2: '옵션2'));

//화면
print((homeApplianceProduct.moreInfo as HomeApplicance).option1);
```

### 적용 후
```dart
class Product<T> {
  int price;
  int amount;
  String title;
  String description;
  ProductType type;

  T? _moreInfo;

  Product({
    required this.price,
    required this.amount,
    required this.title,
    required this.description,
    required this.type,
  });

  setProductMoreInfo(T moreInfo) {
    _moreInfo = moreInfo;
  }

  T? get moreInfo => _moreInfo;
}

var homeApplianceProduct = Product<HomeApplicance>(
  price: 1000,
  amount: 100,
  title: 'TV',
  description: 'TV 설명',
  type: ProductType.HomeAppliances,
);

homeApplianceProduct
    .setProductMoreInfo(HomeApplicance(option1: '옵션1', option2: '옵션2'));

//화면
print(homeApplianceProduct.moreInfo!.option1);
```