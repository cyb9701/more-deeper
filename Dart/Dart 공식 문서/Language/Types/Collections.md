#types 

---
## Docs
https://dart.dev/language/collections

Dart has built-in support for list, set, and map [collections](https://dart.dev/guides/libraries/library-tour#collections). To learn more about configuring the types collections contain, check out [Generics](https://dart.dev/language/generics).
> 다트는 목록, 세트 및 지도 컬렉션에 대한 지원이 내장되어 있다. 컬렉션에 포함된 유형을 구성하는 방법에 대해 자세히 알아보려면, 제네릭을 확인하세요.

### Operators
#### Spread operators
Dart supports the **spread operator** (`...`) and the **null-aware spread operator** (`...?`) in list, map, and set literals. Spread operators provide a concise way to insert multiple values into a collection.
> Dart는 목록, 맵 및 집합 리터럴에서 스프레드 연산자(...)와 널 인식 스프레드 연산자(...?)를 지원합니다. 스프레드 연산자는 컬렉션에 여러 값을 삽입하는 간결한 방법을 제공합니다.

For example, you can use the spread operator (`...`) to insert all the values of a list into another list:
> 예를 들어 스프레드 연산자(...)를 사용하여 목록의 모든 값을 다른 목록에 삽입할 수 있습니다:

```dart
var list = [1, 2, 3];
var list2 = [0, ...list];
assert(list2.length == 4);
```

If the expression to the right of the spread operator might be null, you can avoid exceptions by using a null-aware spread operator (`...?`):
> 스프레드 연산자 오른쪽에 있는 표현식이 널일 수 있는 경우 널 인식 스프레드 연산자(...?)를 사용하여 예외를 피할 수 있습니다:

```dart
var list2 = [0, ...?list];
assert(list2.length == 1);
```

For more details and examples of using the spread operator, see the [spread operator proposal.](https://github.com/dart-lang/language/blob/main/accepted/2.3/spread-collections/feature-specification.md)
> 스프레드 운영자 사용에 대한 자세한 내용과 예시는 스프레드 운영자 제안을 참조하십시오.

#### Control-flow operators
Dart offers **collection if** and **collection for** for use in list, map, and set literals. You can use these operators to build collections using conditionals (`if`) and repetition (`for`).
> 예술은 목록, 지도 및 세트 리터럴에 사용할 수 있는 컬렉션과 컬렉션을 제공합니다. 이 연산자를 사용하여 조건(if)과 반복(for)을 사용하여 컬렉션을 만들 수 있습니다.

Here’s an example of using **collection if** to create a list with three or four items in it:
> 다음은 세 개 또는 네 개의 항목이 있는 목록을 만드는 경우 컬렉션을 사용하는 예입니다:

```dart
var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
```

Dart also supports [if-case](https://dart.dev/language/branches#if-case) inside collection literals:
> 다트는 또한 컬렉션 리터럴 내부의 if-case를 지원합니다:

```dart
var nav = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
```

Here’s an example of using **collection for** to manipulate the items of a list before adding them to another list:
> 다음은 다른 목록에 추가하기 전에 목록의 항목을 조작하기 위해 컬렉션을 사용하는 예입니다:

```dart
var listOfInts = [1, 2, 3];
var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
assert(listOfStrings[1] == '#1');
```

For more details and examples of using collection `if` and `for`, see the [control flow collections proposal.](https://github.com/dart-lang/language/blob/main/accepted/2.3/control-flow-collections/feature-specification.md)
> 컬렉션 사용에 대한 자세한 내용과 예시는 제어 흐름 컬렉션 제안을 참조하십시오.