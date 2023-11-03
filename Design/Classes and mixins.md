#design

---
## [Docs] AVOID defining a class that contains only static members
https://dart.dev/effective-dart/design#avoid-defining-a-class-that-contains-only-static-members

In Java and C#, every definition _must_ be inside a class, so it’s common to see “classes” that exist only as a place to stuff static members. Other classes are used as namespaces—a way to give a shared prefix to a bunch of members to relate them to each other or avoid a name collision.
> 자바와 C#에서, 모든 정의는 클래스 안에 있어야 하므로, 정적 멤버를 채우는 장소로만 존재하는 "클래스"를 보는 것이 일반적이다. 다른 클래스는 서로 연관시키거나 이름 충돌을 피하기 위해 많은 구성원들에게 공유 접두사를 제공하는 방법인 네임스페이스로 사용됩니다.

Dart has top-level functions, variables, and constants, so you don’t _need_ a class just to define something. If what you want is a namespace, a library is a better fit. Libraries support import prefixes and show/hide combinators. Those are powerful tools that let the consumer of your code handle name collisions in the way that works best for _them_.
> 다트에는 최상위 함수, 변수 및 상수가 있으므로, 무언가를 정의하기 위해 클래스가 필요하지 않습니다. 당신이 원하는 것이 네임스페이스라면, 도서관이 더 적합합니다. 라이브러리는 가져오기 접두사를 지원하고 콤비네이터를 표시/숨깁니다. 그것들은 당신의 코드 소비자가 그들에게 가장 적합한 방식으로 이름 충돌을 처리할 수 있는 강력한 도구입니다.

If a function or variable isn’t logically tied to a class, put it at the top level. If you’re worried about name collisions, give it a more precise name or move it to a separate library that can be imported with a prefix.
> 함수나 변수가 논리적으로 클래스에 연결되어 있지 않다면, 그것을 최상위에 두세요. 이름 충돌이 걱정된다면, 더 정확한 이름을 지정하거나 접두사로 가져올 수 있는 별도의 라이브러리로 옮기세요.

```dart
// good
DateTime mostRecent(List<DateTime> dates) {
  return dates.reduce((a, b) => a.isAfter(b) ? a : b);
}

const _favoriteMammal = 'weasel';
```

```dart
// bad
class DateUtils {
  static DateTime mostRecent(List<DateTime> dates) {
    return dates.reduce((a, b) => a.isAfter(b) ? a : b);
  }
}

class _Favorites {
  static const mammal = 'weasel';
}
```

In idiomatic Dart, classes define _kinds of objects_. A type that is never instantiated is a code smell.
> 관용적인 다트에서, 수업은 물체의 종류를 정의한다. 절대 인스턴스화되지 않는 유형은 코드 냄새이다.

However, this isn’t a hard rule. For example, with constants and enum-like types, it may be natural to group them in a class.
> 그러나, 이것은 어려운 규칙이 아니다. 예를 들어, 상수와 열거형과 같은 유형을 사용하면, 그것들을 클래스에서 그룹화하는 것이 자연스러울 수 있다.

```dart
// good
class Color {
  static const red = '#f00';
  static const green = '#0f0';
  static const blue = '#00f';
  static const black = '#000';
  static const white = '#fff';
}
```