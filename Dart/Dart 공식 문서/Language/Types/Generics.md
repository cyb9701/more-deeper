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