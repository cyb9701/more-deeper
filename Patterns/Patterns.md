---

---
#pattern

---

## Docs

https://dart.dev/language/patterns
Patterns are a syntactic category in the Dart language, like statements and expressions. A pattern represents the shape
of a set of values that it may match against actual values.
> 패턴은 문장 및 표현식과 같은 Dart 언어의 구문 범주입니다. 패턴은 실제 값과 일치할 수 있는 값 집합의 모양을 나타냅니다.

This page describes:
> 이 페이지에서 설명합니다:

- What patterns do.
- Where patterns are allowed in Dart code.
- What the common use cases for patterns are.

> - 패턴이 하는 일.
> - Dart 코드에서 패턴이 허용되는 경우.
> - 패턴의 일반적인 사용 사례.

To learn about the different kinds of patterns, visit the[[Pattern types]]page.
> 다양한 종류의 패턴에 대해 알아보려면 패턴 유형 페이지를 방문하세요.

### What patterns do

In general, a pattern may**match**a value,**destructure**a value, or both, depending on the context and shape of the
pattern.
> 일반적으로 패턴은 패턴의 컨텍스트와 형태에 따라 값과 일치하거나, 값을 파괴하거나, 또는 둘 다일 수 있습니다.

First,_pattern matching_allows you to check whether a given value:
> 먼저 패턴 매칭을 사용하면 주어진 값이 일치하는지 확인할 수 있습니다:

- Has a certain shape.
- Is a certain constant.
- Is equal to something else.
- Has a certain type.

> - 특정 모양을 가졌는지.
> - 특정 상수인지.
> - 다른 값과 동일한지.
> - 특정 유형이 있다.

Then,_pattern destructuring_provides you with a convenient declarative syntax to break that value into its constituent
parts. The same pattern can also let you bind variables to some or all of those parts in the process.
> 그런 다음 패턴 파괴를 통해 해당 값을 구성 요소로 분해하는 편리한 선언적 구문을 사용할 수 있습니다. 또한 동일한 패턴을 사용하여 프로세스에서 해당 부분의 일부 또는 전체에 변수를 바인딩할 수 있습니다.

#### Matching

A pattern always tests against a value to determine if the value has the form you expect. In other words, you are
checking if the value_matches_the pattern.
> 패턴은 항상 값에 대해 테스트하여 값이 예상한 형식인지 확인합니다. 즉, 값이 패턴과 일치하는지 확인하는 것입니다.

What constitutes a match depends on[what kind of pattern](https://dart.dev/language/pattern-types)you are using. For
example, a constant pattern matches if the value is equal to the pattern’s constant:
> 일치 여부는 사용 중인 패턴의 종류에 따라 달라집니다. 예를 들어 상수 패턴은 값이 패턴의 상수와 같으면 일치합니다:

```dart
switch (number) {
// Constant pattern matches if 1 == number.
case 1:
print('one');
}
```

Many patterns make use of subpatterns, sometimes called_outer_and_inner_patterns, respectively. Patterns match
recursively on their subpatterns. For example, the individual fields of
any[collection-type](https://dart.dev/language/collections)pattern could
be[variable patterns](https://dart.dev/language/pattern-types#variable)
or[constant patterns](https://dart.dev/language/pattern-types#constant):
> 많은 패턴은 각각 외부 패턴과 내부 패턴이라고도 하는 하위 패턴을 사용합니다. 패턴은 하위 패턴에서 재귀적으로 일치합니다. 예를 들어 컬렉션 유형 패턴의 개별 필드는 가변 패턴 또는 상수 패턴일 수 있습니다:

```dart

const a = 'a';
const b = 'b';switch (
obj) {
// List pattern [a, b] matches obj first if obj is a list with two fields,
// then if its fields match the constant subpatterns 'a' and 'b'.
case [a, b]:
print('$a, $b');
}
```

To ignore parts of a matched value, you can use a[wildcard pattern](https://dart.dev/language/pattern-types#wildcard)as
a placeholder. In the case of list patterns, you can use
a[rest element](https://dart.dev/language/pattern-types#rest-element).
> 일치하는 값의 일부를 무시하려면 와일드카드 패턴을 자리 표시자로 사용할 수 있습니다. 목록 패턴의 경우 나머지 요소를 사용할 수 있습니다.

#### Destructuring

When an object and pattern match, the pattern can then access the object’s data and extract it in parts. In other words,
the pattern_destructures_the object:
> 객체와 패턴이 일치하면 패턴은 객체의 데이터에 액세스하여 부분적으로 추출할 수 있습니다. 즉, 패턴은 객체를 파괴합니다:

```dart

var numList = [1, 2, 3];
// List pattern [a, b, c] destructures the three elements from numList...
var [a, b, c] = numList;
// ...and assigns them to new variables.
print(a
+
b
+
c
);
```

You can nest[any kind of pattern](https://dart.dev/language/pattern-types)inside a destructuring pattern. For example,
this case pattern matches and destructures a two-element list whose first element is`'a'`or`'b'`:
> 구조 파괴 패턴 안에 모든 종류의 패턴을 중첩할 수 있습니다. 예를 들어, 이 대소문자 패턴은 첫 번째 요소가 'a' 또는 'b'인 두 요소 목록을 일치시키고 파괴합니다:

```dart
switch (list) {
case ['a' || 'b', var c]:
print(c);
}
```

### Places patterns can appear

You can use patterns in several places in the Dart language:
> Dart 언어의 여러 위치에서 패턴을 사용할 수 있습니다:

- Local variable[declarations](https://dart.dev/language/patterns#variable-declaration)
  and[assignments](https://dart.dev/language/patterns#variable-assignment)
- [for and for-in loops](https://dart.dev/language/loops#for-loops)
- [if-case](https://dart.dev/language/branches#if-case)
  and[switch-case](https://dart.dev/language/branches#switch-statements)
- Control flow in[collection literals](https://dart.dev/language/collections#control-flow-operators)

> - 지역 변수 선언 및 할당
> - for 및 for-in 루프
> - if-케이스 및 switch-케이스
> - 컬렉션 리터럴의 제어 흐름

This section describes common use cases for matching and destructuring with patterns.
> 이 섹션에서는 패턴을 사용하여 일치 및 파괴하는 일반적인 사용 사례에 대해 설명합니다.

#### Variable declaration

You can use a_pattern variable declaration_anywhere Dart allows local variable declaration. The pattern matches against
the value on the right of the declaration. Once matched, it destructures the value and binds it to new local variables:
> Dart에서 로컬 변수 선언을 허용하는 모든 곳에서 패턴 변수 선언을 사용할 수 있습니다. 패턴은 선언의 오른쪽에 있는 값과 일치합니다. 일치하면 값을 파괴하고 새로운 지역 변수에 바인딩합니다:

```dart
// Declares new variables a, b, and c.
var
(a, [b, c]) = ('str', [1, 2]);
```

A pattern variable declaration must start with either`var`or`final`, followed by a pattern.
> 패턴 변수 선언은 var 또는 final로 시작하고 그 뒤에 패턴이 와야 합니다.

#### Variable assignment

A_variable assignment pattern_falls on the left side of an assignment. First, it destructures the matched object. Then
it assigns the values to_existing_variables, instead of binding new ones.
> 변수 할당 패턴은 할당의 왼쪽에 있습니다. 먼저 일치하는 객체를 파괴합니다. 그런 다음 새 변수를 바인딩하는 대신 기존 변수에 값을 할당합니다.

Use a variable assignment pattern to swap the values of two variables without declaring a third temporary one:
> 변수 할당 패턴을 사용하면 세 번째 임시 변수를 선언하지 않고 두 변수의 값을 바꿀 수 있습니다:

```dart
var
(a, b) = ('left', 'right');
(b, a) = (a, b); // Swap.
print('$
a
 
$
b
'
); // Prints "right left".
```

#### Switch statements and expressions

Every case clause contains a pattern. This applies
to[switch statements](https://dart.dev/language/branches#switch-statements)
and[expressions](https://dart.dev/language/branches#switch-expressions), as well
as[if-case statements](https://dart.dev/language/branches#if-case). You can
use[any kind of pattern](https://dart.dev/language/pattern-types)in a case.
> 모든 사례 절에는 패턴이 포함되어 있다. 이것은 if-case 문뿐만 아니라 스위치 문과 표현에도 적용된다. 케이스에 모든 종류의 패턴을 사용할 수 있습니다.

_Case patterns_are[refutable](https://dart.dev/resources/glossary#refutable-pattern). They allow control flow to either:
> 케이스 패턴은 반박이 가능합니다. 어느 쪽으로도 제어 흐름을 허용합니다:

- Match and destructure the object being switched on.
- Continue execution if the object doesn’t match.

> - 켜지는 객체를 일치시키고 파괴합니다.
> - 객체가 일치하지 않으면 실행을 계속합니다.

The values that a pattern destructures in a case become local variables. Their scope is only within the body of that
case.
> 패턴이 케이스에서 파괴하는 값은 로컬 변수가 됩니다. 그 범위는 해당 케이스의 본문 내에만 있습니다.

```dart
switch (obj) {
// Matches if 1 == obj.
case 1:
print('one');

// Matches if the value of obj is between the
// constant values of 'first' and 'last'.
case >= first && <= last:
print('in range');

// Matches if obj is a record with two fields,
// then assigns the fields to 'a' and 'b'.
case (var a, var b):
print('a = $a, b = $b');

default:
}
```

[Logical-or patterns](https://dart.dev/language/pattern-types#logical-or)are useful for having multiple cases share a
body in switch expressions or statements:
> 논리 또는 패턴은 스위치 표현식이나 문에서 여러 개의 케이스가 본문을 공유할 때 유용합니다:

```dart

var isPrimary = switch (color) {
  Color.red || Color.yellow || Color.blue => true,
  _ => false
};
```

Switch statements can have multiple cases share a body without using logical-or patterns, but they are still uniquely
useful for allowing multiple cases to share a guard:
> 스위치 문은 논리 또는 패턴을 사용하지 않고도 여러 케이스가 본문을 공유할 수 있지만, 여러 케이스가 가드를 공유할 수 있도록 하는 데는 여전히 고유하게 유용합니다:

```dart
switch (shape) {
case Square(size: var s) || Circle(size: var s) when s > 0:
print('Non-empty symmetric shape');
}
```

#### For and for-in loops

You can use patterns in[for and for-in loops](https://dart.dev/language/loops#for-loops)to iterate-over and destructure
values in a collection.
> for 및 for-in 루프에서 패턴을 사용하여 컬렉션의 값을 반복하고 파괴할 수 있습니다.

This example uses[object destructuring](https://dart.dev/language/pattern-types#object)in a for-in loop to destructure
the[`MapEntry`](https://api.dart.dev/stable/dart-core/MapEntry-class.html)objects that a`<Map>.entries`call returns:
> 이 예제에서는 for-in 루프에서 객체 구조조정을 사용하여 <Map>.entries 호출이 반환하는 MapEntry 객체를 구조조정합니다:

```dart

Map<String, int> hist = {
  'a': 23,
  'b': 100,
};

for (
var MapEntry(key: key, value: count) in hist.entries) {
print('$key occurred $count times');
}
```

The object pattern checks that`hist.entries`has the named type`MapEntry`, and then recurses into the named field
subpatterns`key`and`value`. It calls the`key`getter and`value`getter on the`MapEntry`in each iteration, and binds the
results to local variables`key`and`count`, respectively.
> 객체 패턴은 hist.entries에 명명된 유형 MapEntry가 있는지 확인한 다음 명명된 필드 하위 패턴인 키와 값으로 재귀합니다. 각 반복에서 MapEntry의 키 가져 오기 및 값 가져 오기를 호출하고
> 결과를 각각 로컬 변수 key 및 count에 바인딩합니다.

Binding the result of a getter call to a variable of the same name is a common use case, so object patterns can also
infer the getter name from the[variable subpattern](https://dart.dev/language/pattern-types#variable). This allows you
to simplify the variable pattern from something redundant like`key: key`to just`:key`:
> 게터 호출의 결과를 같은 이름의 변수에 바인딩하는 것은 일반적인 사용 사례이므로 객체 패턴은 변수 하위 패턴에서 게터 이름을 유추할 수도 있습니다. 이를 통해 키: 키와 같이 중복되는 변수 패턴을 단지 :키로
> 단순화할 수 있습니다:

```dart
for (var MapEntry(:key, value: count) in hist.entries) {
print('$key occurred $count times');
}
```

### Uses cases for patterns

The[previous section](https://dart.dev/language/patterns#places-patterns-can-appear)describes_how_patterns fit into
other Dart code constructs. You saw some interesting uses cases as examples,
like[swapping](https://dart.dev/language/patterns#variable-assignment)the values of two variables,
or[destructuring key-value pairs](https://dart.dev/language/patterns#for-and-for-in-loops)in a map. This section
describes even more use cases, answering:
> 이전 섹션에서는 패턴이 다른 Dart 코드 구성에 어떻게 적용되는지 설명했습니다. 두 변수의 값을 바꾸거나 맵에서 키-값 쌍을 파괴하는 것과 같은 흥미로운 사용 사례를 예로 살펴보았습니다. 이 섹션에서는 더 많은
> 사용 사례에 대해 설명합니다:

- When and why_you might want to use patterns.
- What kinds of problems they solve.
- Which idioms they best suit.

> - 패턴을 사용해야 할 때와 이유
> - 어떤 종류의 문제를 해결할 수 있는지
> - 어떤 관용구가 가장 적합한지.

#### Destructuring multiple returns

^ba6b35

[Records](https://dart.dev/language/records)allow aggregating and returning multiple values from a single function call.
Patterns add the ability to destructure a record’s fields directly into local variables, inline with the function call
> 레코드를 사용하면 단일 함수 호출에서 여러 값을 집계하고 반환할 수 있습니다. 패턴은 함수 호출과 인라인으로 레코드의 필드를 로컬 변수로 직접 분해하는 기능을 추가합니다.

Instead of individually declaring new local variables for each record field, like this:
> 다음과 같이 각 레코드 필드에 대해 새로운 로컬 변수를 개별적으로 선언하는 대신 사용할 수 있습니다:

```dart

var info = userInfo(json);
var name = info.$1;
var age = info.$2;
```

You can destructure the fields of a record that a function returns into local variables using
a[variable declaration](https://dart.dev/language/patterns#variable-declaration)
or[assigment pattern](https://dart.dev/language/patterns#variable-assignment), and a record pattern as its subpattern:
> 변수 선언 또는 assigment 패턴을 사용하여 함수가 로컬 변수로 반환하는 레코드 필드와 레코드 패턴을 하위 패턴으로 재구성할 수 있습니다.

```dart
var
(name, age) = userInfo(json);
```

#### Destructuring class instances

[Object patterns](https://dart.dev/language/pattern-types#object)match against named object types, allowing you to
destructure their data using the getters the object’s class already exposes.
> 객체 패턴은 명명된 객체 유형과 일치하여 객체의 클래스가 이미 노출된 게터를 사용하여 데이터를 해체할 수 있습니다.

To destructure an instance of a class, use the named type, followed by the properties to destructure enclosed in
parentheses:
> 클래스의 인스턴스를 해체하려면, 명명된 유형을 사용하고, 괄호로 둘러싸인 속성을 해체하세요:

```dart

final Foo myFoo = Foo(one: 'one', two: 2);
var Foo
(:one, :two) = myFoo;
print('one 
$
one
, two 
$
two
'
);
```

#### Algebraic data types

Object destructuring and switch cases are conducive to writing code in
an[algebraic data type](https://en.wikipedia.org/wiki/Algebraic_data_type)style. Use this method when:
> 객체 비구조화 및 스위치 사례는 대수적 데이터 유형 스타일로 코드를 작성하는 데 도움이 된다. 다음과 같은 경우 이 방법을 사용하세요:

- You have a family of related types.
- You have an operation that needs specific behavior for each type.
- You want to group that behavior in one place instead of spreading it across all the different type definitions.

> - 당신은 관련 유형의 가족이 있습니다.
> - 각 유형에 대한 특정 행동이 필요한 작업이 있습니다.
> - 당신은 그 행동을 모든 다른 유형 정의에 퍼뜨리는 대신 한 곳에서 그룹화하고 싶습니다.

Instead of implementing the operation as an instance method for every type, keep the operation’s variations in a single
function that switches over the subtypes:
> 모든 유형에 대한 인스턴스 방법으로 작업을 구현하는 대신, 하위 유형을 전환하는 단일 함수에서 작업의 변형을 유지하십시오.

```dart
sealed class Shape {}

class Square implements Shape {
  final double length;

  Square(this.length);
}

class Circle implements Shape {
  final double radius;

  Circle(this.radius);
}

double calculateArea(Shape shape) =>
    switch (shape) {
      Square(length: var l) => l * l,
      Circle(radius: var r) => math.pi * r * r
    };
```

#### Validating incoming JSON

[Map](https://dart.dev/language/pattern-types#map)and[list](https://dart.dev/language/pattern-types#list)patterns work
well for destructuring key-value pairs in JSON data:
> 지도와 목록 패턴은 JSON 데이터에서 키-값 쌍을 해체하는 데 잘 작동합니다:

```dart

var json = {
  'user': ['Lily', 13]
};
var {'user': [name, age]} = json;
```

If you know that the JSON data has the structure you expect, the previous example is realistic. But data typically comes
from an external source, like over the network. You need to validate it first to confirm its structure.
> JSON 데이터가 당신이 기대하는 구조를 가지고 있다는 것을 알고 있다면, 이전 예는 현실적입니다. 하지만 데이터는 일반적으로 네트워크와 같은 외부 소스에서 나온다. 당신은 그것의 구조를 확인하기 위해 먼저
> 그것을 검증해야 합니다.

Without patterns, validation is verbose:
> 패턴이 없다면, 검증은 상세하다:

```dart
if (json is Map<String, Object?> &&
json.length == 1 &&
json.containsKey('user')) {
var user = json['user'];
if (user is List<Object> &&
user.length == 2 &&
user[0] is String &&
user[1] is int) {
var name = user[0] as String;
var age = user[1] as int;
print('User $name is $age years old.');
}
}
```

A single[case pattern](https://dart.dev/language/patterns#switch-statements-and-expressions)can achieve the same
validation. Single cases work best as[if-case](https://dart.dev/language/branches#if-case)statements. Patterns provide a
more declarative, and much less verbose method of validating JSON:
> 단일 케이스 패턴은 동일한 검증을 달성할 수 있다. 단일 사례는 if-case 진술로 가장 잘 작동한다. 패턴은 JSON을 검증하는 더 선언적이고 훨씬 덜 장황한 방법을 제공한다:

```dart
if (json case {'user': [String name, int age]}) {
print('User $name is $age years old.');
}
```

This case pattern simultaneously validates that:
> 이 사례 패턴은 동시에 다음을 검증한다:

- `json`is a map, because it must first match the outer[map pattern](https://dart.dev/language/pattern-types#map)to
  proceed.
    - And, since it’s a map, it also confirms`json`is not null.
- `json`contains a key`user`.
- The key`user`pairs with a list of two values.
- The types of the list values are`String`and`int`.
- The new local variables to hold the values are`String`and`int`.

> - Json은 지도입니다. 왜냐하면 진행하려면 먼저 외부 지도 패턴과 일치해야 하기 때문입니다.
    >
- 그리고, 그것이 지도이기 때문에, 그것은 또한 json이 null이 아니라는 것을 확인한다.
> - 제이슨에는 주요 사용자가 포함되어 있다.
> - 주요 사용자는 두 값의 목록과 짝을 이룬다.
> - 목록 값의 유형은 문자열과 int이다.
>- 값을 유지하는 새로운 지역 변수는 String과 int이다.

---

## [[Pattern types]]