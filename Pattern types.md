#pattern

---
## Docs
https://dart.dev/language/pattern-types

This page is a reference for the different kinds of patterns. For an overview of how patterns work, where you can use them in Dart, and common use cases, visit the main [Patterns](https://dart.dev/language/patterns) page.
> 이 페이지는 다양한 종류의 패턴에 대한 참고 자료입니다. 패턴의 작동 방식, 다트에서 사용할 수 있는 곳, 일반적인 사용 사례에 대한 개요를 보려면 기본 패턴 페이지를 방문하십시오.

##### Pattern precedence
> ##### 패턴 우선 순위

Similar to [operator precedence](https://dart.dev/language/operators#operator-precedence-example), pattern evaluation adheres to precedence rules. You can use [parenthesized patterns](https://dart.dev/language/pattern-types#parenthesized) to evaluate lower-precedence patterns first.
> 연산자 우선 순위와 마찬가지로, 패턴 평가는 우선 순위 규칙을 준수합니다. 괄호로 된 패턴을 사용하여 우선 순위가 낮은 패턴을 먼저 평가할 수 있습니다.

This document lists the pattern types in ascending order of precedence:
> 이 문서는 패턴 유형을 오름차순으로 나열합니다:

- [Logical-or](https://dart.dev/language/pattern-types#logical-or) patterns are lower-precedence than [logical-and](https://dart.dev/language/pattern-types#logical-and), logical-and patterns are lower-precedence than [relational](https://dart.dev/language/pattern-types#relational) patterns, and so on.
- Post-fix unary patterns ([cast](https://dart.dev/language/pattern-types#cast), [null-check](https://dart.dev/language/pattern-types#null-check), and [null-assert](https://dart.dev/language/pattern-types#null-assert)) share the same level of precedence.
- The remaining primary patterns share the highest precedence. Collection-type ([record](https://dart.dev/language/pattern-types#record), [list](https://dart.dev/language/pattern-types#list), and [map](https://dart.dev/language/pattern-types#map)) and [Object](https://dart.dev/language/pattern-types#object)patterns encompass other data, so are evaluated first as outer-patterns.

> - 논리 또는 패턴은 논리보다 우선 순위가 낮고, 논리 및 패턴은 관계형 패턴보다 우선 순위가 낮다.
> - 포스트픽스 uniary 패턴(cast, null-check 및 null-assert)은 동일한 수준의 우선 순위를 공유합니다.
> - 나머지 주요 패턴은 가장 높은 우선 순위를 공유한다. 컬렉션 유형(기록, 목록 및 지도)과 객체 패턴은 다른 데이터를 포함하므로 먼저 외부 패턴으로 평가됩니다.

### Logical-or
`subpattern1 || subpattern2`

A logical-or pattern separates subpatterns by `||` and matches if any of the branches match. Branches are evaluated left-to-right. Once a branch matches, the rest are not evaluated.
> 논리 또는 패턴은 ||로 하위 패턴을 분리하고 분기 중 하나라도 일치하면 일치합니다. 가지는 왼쪽에서 오른쪽으로 평가된다. 브랜치가 일치하면, 나머지는 평가되지 않는다.

```dart
var isPrimary = switch (color) {
  Color.red || Color.yellow || Color.blue => true,
  _ => false
};
```

Subpatterns in a logical-or pattern can bind variables, but the branches must define the same set of variables, because only one branch will be evaluated when the pattern matches.
> 논리 또는 패턴의 하위 패턴은 변수를 바인딩할 수 있지만, 패턴이 일치할 때 하나의 분기만 평가되기 때문에 분기는 동일한 변수 세트를 정의해야 합니다.

### Logical-and

^e21410

`subpattern1 && subpattern2`

A pair of patterns separated by `&&` matches only if both subpatterns match. If the left branch does not match, the right branch is not evaluated.
> &&로 구분된 한 쌍의 패턴은 두 하위 패턴이 일치하는 경우에만 일치합니다. 왼쪽 분기가 일치하지 않으면, 오른쪽 분기는 평가되지 않습니다.

Subpatterns in a logical-and pattern can bind variables, but the variables in each subpattern must not overlap, because they will both be bound if the pattern matches:
> 논리 및 패턴의 하위 패턴은 변수를 바인딩할 수 있지만, 패턴이 일치하면 둘 다 바인딩되기 때문에 각 하위 패턴의 변수가 겹쳐서는 안 됩니다.

```dart
switch ((1, 2)) {
  // Error, both subpatterns attempt to bind 'b'.
  case (var a, var b) && (var b, var c): // ...
}
```

### Relational
`== expression`
`< expression`

Relational patterns compare the matched value to a given constant using any of the equality or relational operators: `==`, `!=`, `<`, `>`, `<=`, and `>=`.
> 관계형 패턴은 같음 또는 관계형 연산자를 사용하여 일치하는 값을 주어진 상수와 비교합니다: ==, ! =, <, >, <=, 그리고 >=.

The pattern matches when calling the appropriate operator on the matched value with the constant as an argument returns `true`.
> 인수로 상수와 일치하는 값에 대한 적절한 연산자를 호출할 때 패턴이 일치합니다.

Relational patterns are useful for matching on numeric ranges, especially when combined with the [[Pattern types#Logical-and]]
> 관계형 패턴은 특히 논리 및 패턴과 결합할 때 숫자 범위를 일치시키는 데 유용합니다.

```dart
String asciiCharType(int char) {
  const space = 32;
  const zero = 48;
  const nine = 57;

  return switch (char) {
    < space => 'control',
    == space => 'space',
    > space && < zero => 'punctuation',
    >= zero && <= nine => 'digit',
    _ => ''
  };
}
```


### Cast
`foo as String`

A cast pattern lets you insert a [type cast](https://dart.dev/language/operators#type-test-operators) in the middle of destructuring, before passing the value to another subpattern:
> 캐스트 패턴을 사용하면 값을 다른 하위 패턴으로 전달하기 전에 구조화 중간에 유형 캐스트를 삽입할 수 있습니다.

```dart
(num, Object) record = (1, 's');
var (i as int, s as String) = record;
```

Cast patterns will [throw](https://dart.dev/language/error-handling#throw) if the value doesn’t have the stated type. Like the [null-assert pattern](https://dart.dev/language/pattern-types#null-assert), this lets you forcibly assert the expected type of some destructured value.
> 값에 명시된 유형이 없으면 캐스트 패턴이 던져질 것이다. Null-assert 패턴과 마찬가지로, 이것은 일부 비정형 값의 예상 유형을 강제로 주장할 수 있게 해준다.

### Null-check
`subpattern?`

Null-check patterns match first if the value is not null, and then match the inner pattern against that same value. They let you bind a variable whose type is the non-nullable base type of the nullable value being matched.
> Null-check 패턴은 값이 null이 아닌 경우 먼저 일치한 다음, 동일한 값에 대한 내부 패턴을 일치시킵니다. 그들은 일치하는 nullable 값의 nullable 기본 유형인 변수를 바인딩할 수 있습니다.

To treat `null` values as match failures without throwing, use the null-check pattern.
> Null 값을 던지지 않고 일치 실패로 취급하려면, null-check 패턴을 사용하세요.

```dart
String? maybeString = 'nullable with base type String';
switch (maybeString) {
  case var s?:
  // 's' has type non-nullable String here.
}
```

To match when the value _is_ null, use the [[Pattern types#Constant]] `null`.
> 값이 null일 때 일치하려면, 상수 패턴 null을 사용하세요.

### Null-assert
`subpattern!`

Null-assert patterns match first if the object is not null, then on the value. They permit non-null values to flow through, but [throw](https://dart.dev/language/error-handling#throw) if the matched value is null.
> Null-assert 패턴은 객체가 null이 아닌 경우 먼저 일치합니다. 그들은 null이 아닌 값이 흐르도록 허용하지만, 일치하는 값이 null이면 던진다.

To ensure `null` values are not silently treated as match failures, use a null-assert pattern while matching:
> Null 값이 일치 실패로 자동으로 취급되지 않도록 하려면, 일치시키는 동안 null-assert 패턴을 사용하세요:

```dart
List<String?> row = ['user', null];
switch (row) {
  case ['user', var name!]: // ...
  // 'name' is a non-nullable string here.
}
```

To eliminate `null` values from variable declaration patterns, use the null-assert pattern:
> 변수 선언 패턴에서 null 값을 제거하려면, null-assert 패턴을 사용하세요:

```dart
(int?, int?) position = (2, 3);

var (x!, y!) = position;
```

To match when the value _is_ null, use the [[Pattern types#Constant]] `null`.
> 값이 null일 때 일치하려면, 상수 패턴 null을 사용하세요.

### Constant
`123, null, 'string', math.pi, SomeClass.constant, const Thing(1, 2), const (1 + 2)`

Constant patterns match when the value is equal to the constant:
> 상수 패턴은 값이 상수와 같을 때 일치한다:

```dart
switch (number) {
  // Matches if 1 == number.
  case 1: // ...
}
```

You can use simple literals and references to named constants directly as constant patterns:
> 명명된 상수에 대한 간단한 리터럴과 참조를 상수 패턴으로 직접 사용할 수 있습니다:

- Number literals (`123`, `45.56`)
- Boolean literals (`true`)
- String literals (`'string'`)
- Named constants (`someConstant`, `math.pi`, `double.infinity`)
- Constant constructors (`const Point(0, 0)`)
- Constant collection literals (`const []`, `const {1, 2}`)

> - 숫자 리터럴 (123, 45.56)
> - 부울 문자 (진실)
> - 문자열 리터럴 ('문자열')
> - 명명된 상수 (someConstant, math.pi, double.infinity)
> - 상수 생성자 (상수점(0, 0))
> - 상수 수집 리터럴 (const [], const {1, 2})

More complex constant expressions must be parenthesized and prefixed with `const` (`const (1 + 2)`):
> 더 복잡한 상수 표현식은 괄호로 묶고 const(const (1 + 2))로 접두사를 붙여야 합니다:

```dart
// List or map pattern:
case [a, b]: // ...

// List or map literal:
case const [a, b]: // ...
```

### Variable
`var bar, String str, final int _`

Variable patterns bind new variables to values that have been matched or destructured. They usually occur as part of a [destructuring pattern](https://dart.dev/language/patterns#destructuring) to capture a destructured value.
> 변수 패턴은 새로운 변수를 일치하거나 구조화되지 않은 값에 바인딩합니다. 그것들은 보통 비구조화된 가치를 포착하기 위한 해체 패턴의 일부로 발생한다.

The variables are in scope in a region of code that is only reachable when the pattern has matched.
> 변수는 패턴이 일치했을 때만 도달할 수 있는 코드 영역의 범위에 있다.

```dart
switch ((1, 2)) {
  // 'var a' and 'var b' are variable patterns that bind to 1 and 2, respectively.
  case (var a, var b): // ...
  // 'a' and 'b' are in scope in the case body.
}
```

A _typed_ variable pattern only matches if the matched value has the declared type, and fails otherwise:
> 형식화된 변수 패턴은 일치하는 값에 선언된 유형이 있는 경우에만 일치하며, 그렇지 않으면 실패합니다:

```dart
switch ((1, 2)) {
  // Does not match.
  case (int a, String b): // ...
}
```

You can use a [[Pattern types#Wildcard]] as a variable pattern.
> 와일드카드 패턴을 가변 패턴으로 사용할 수 있습니다.

### Identifier
`foo, _`

Identifier patterns may behave like a [constant pattern](https://dart.dev/language/pattern-types#constant) or like a [variable pattern](https://dart.dev/language/pattern-types#variable), depending on the context where they appear:
> 식별자 패턴은 나타나는 상황에 따라 일정한 패턴이나 변수 패턴처럼 행동할 수 있습니다.

- [Declaration](https://dart.dev/language/patterns#variable-declaration) context: declares a new variable with identifier name: `var (a, b) = (1, 2);`

> - 선언 컨텍스트: 식별자 이름을 가진 새로운 변수를 선언합니다: var (a, b) = (1, 2);


- [Assignment](https://dart.dev/language/patterns#variable-assignment) context: assigns to existing variable with identifier name: `(a, b) = (3, 4);`

> - 할당 컨텍스트: 식별자 이름으로 기존 변수에 할당합니다: (a, b) = (3, 4);


- [Matching](https://dart.dev/language/patterns#matching) context: treated as a named constant pattern (unless its name is `_`):

> - 일치하는 문맥: 명명된 상수 패턴으로 취급됨 (이름이 _가 없는 한):

```dart
const c = 1;
switch (2) {
  case c:
    print('match $c');
  default:
    print('no match'); // Prints "no match".
}
```

- [Wildcard](https://dart.dev/language/pattern-types#wildcard) identifier in any context: matches any value and discards it: `case [_, var y, _]: print('The middle element is $y');`

> - 모든 컨텍스트에서 와일드카드 식별자: 모든 값과 일치하고 폐기합니다: case [ _ , var y, _]: print('중간 요소는 $y');

### Parenthesized
`(subpattern)`

Like parenthesized expressions, parentheses in a pattern let you control [pattern precedence](https://dart.dev/language/pattern-types#pattern-precedence) and insert a lower-precedence pattern where a higher precedence one is expected
> 괄호로 묶인 표현식과 마찬가지로, 패턴의 괄호를 사용하면 패턴 우선 순위를 제어하고 더 높은 우선 순위가 예상되는 낮은 우선 순위 패턴을 삽입할 수 있습니다.

For example, imagine the boolean constants `x`, `y`, and `z` are equal to `true`, `true`, and `false`, respectively:
> 예를 들어, 부울 상수 x, y, z가 각각 true, true, false와 같다고 상상해 보세요:

```dart
// ...
x || y && z => 'matches true',
(x || y) && z => 'matches false',
// ...
```

In the first case, the logical-and pattern `y && z` evaluates first because logical-and patterns have higher precedence than logical-or. In the next case, the logical-or pattern is parenthesized. It evaluates first, which results in a different match.
> 첫 번째 경우, 논리 및 패턴 y && z는 논리 및 패턴이 논리적 또는보다 우선 순위가 높기 때문에 먼저 평가됩니다. 다음 경우, 논리 또는 패턴은 괄호로 묶인다. 그것은 먼저 평가되며, 이는 다른 일치를 초래한다.

### List
`[subpattern1, subpattern2]`

A list pattern matches values that implement [`List`](https://dart.dev/language/collections#lists), and then recursively matches its subpatterns against the list’s elements to destructure them by position:
> 목록 패턴은 List를 구현하는 값과 일치한 다음 하위 패턴을 목록의 요소와 재귀적으로 일치시켜 위치에 따라 재구성합니다.

```dart
const a = 'a';
const b = 'b';
switch (obj) {
  // List pattern [a, b] matches obj first if obj is a list with two fields,
  // then if its fields match the constant subpatterns 'a' and 'b'.
  case [a, b]:
    print('$a, $b');
}
```

List patterns require that the number of elements in the pattern match the entire list. You can, however, use a [rest element](https://dart.dev/language/pattern-types#rest-element)as a place holder to account for any number of elements in a list.
> 목록 패턴은 패턴의 요소 수가 전체 목록과 일치해야 합니다. 그러나, 목록에서 원하는 수의 요소를 설명하기 위해 나머지 요소를 장소 보유자로 사용할 수 있습니다.

#### Rest element
List patterns can contain _one_ rest element (`...`) which allows matching lists of arbitrary lengths.
> 목록 패턴은 임의의 길이의 목록을 일치시킬 수 있는 하나의 나머지 요소(...)를 포함할 수 있습니다.

```dart
var [a, b, ..., c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 6 7".
print('$a $b $c $d');
```

A rest element can also have a subpattern that collects elements that don’t match the other subpatterns in the list, into a new list:
> 나머지 요소는 또한 목록의 다른 하위 패턴과 일치하지 않는 요소를 새 목록으로 수집하는 하위 패턴을 가질 수 있습니다.

```dart
var [a, b, ...rest, c, d] = [1, 2, 3, 4, 5, 6, 7];
// Prints "1 2 [3, 4, 5] 6 7".
print('$a $b $rest $c $d');
```

### Map
`{"key": subpattern1, someConst: subpattern2}`

Map patterns match values that implement [`Map`](https://dart.dev/language/collections#maps), and then recursively match its subpatterns against the map’s keys to destructure them.
> 맵 패턴은 맵을 구현하는 값과 일치한 다음, 하위 패턴을 맵의 키와 재귀적으로 일치시켜 해체합니다.

Map patterns don’t require the pattern to match the entire map. A map pattern ignores any keys that the map contains that aren’t matched by the pattern.
> 지도 패턴은 전체 지도와 일치하는 패턴을 필요로 하지 않는다. 지도 패턴은 지도에 포함된 패턴과 일치하지 않는 모든 키를 무시합니다.

### Record
`(subpattern1, subpattern2)`
`(x: subpattern1, y: subpattern2)`

Record patterns match a [[Records]] object and destructure its fields. If the value isn’t a record with the same [shape](https://dart.dev/language/records#record-types) as the pattern, the match fails. Otherwise, the field subpatterns are matched against the corresponding fields in the record.
> 기록 패턴은 기록 객체와 일치하고 필드를 해체한다. 값이 패턴과 같은 모양의 레코드가 아니라면, 일치는 실패한다. 그렇지 않으면, 필드 하위 패턴은 레코드의 해당 필드와 일치합니다.

Record patterns require that the pattern match the entire record. To destructure a record with _named_ fields using a pattern, include the field names in the pattern:
> 기록 패턴은 패턴이 전체 기록과 일치해야 한다. 패턴을 사용하여 명명된 필드로 레코드를 해체하려면, 패턴에 필드 이름을 포함하세요:

```dart
var (myString: foo, myNumber: bar) = (myString: 'string', myNumber: 1);
```

The getter name can be omitted and inferred from the [variable pattern](https://dart.dev/language/pattern-types#variable) or [identifier pattern](https://dart.dev/language/pattern-types#identifier) in the field subpattern. These pairs of patterns are each equivalent:
> 게터 이름은 필드 하위 패턴의 변수 패턴 또는 식별자 패턴에서 생략하고 추론할 수 있습니다. 이 패턴 쌍은 각각 동등하다:

```dart
// Record pattern with variable subpatterns:
var (untyped: untyped, typed: int typed) = record;
var (:untyped, :int typed) = record;

switch (record) {
  case (untyped: var untyped, typed: int typed): // ...
  case (:var untyped, :int typed): // ...
}

// Record pattern wih null-check and null-assert subpatterns:
switch (record) {
  case (checked: var checked?, asserted: var asserted!): // ...
  case (:var checked?, :var asserted!): // ...
}

// Record pattern wih cast subpattern:
var (untyped: untyped as int, typed: typed as String) = record;
var (:untyped as int, :typed as String) = record;
```

```dart
({dynamic untyped1, int typed2}) record = (untyped1: 'a', typed2: 1);  
var (untyped1: untyped, typed2: int typed) = record;
```

### Object
`SomeClass(x: subpattern1, y: subpattern2)`

Object patterns check the matched value against a given named type to destructure data using getters on the object’s properties. They are [refuted](https://dart.dev/resources/glossary#refutable-pattern) if the value doesn’t have the same type.
> 객체 패턴은 주어진 명명된 유형과 일치하는 값을 확인하여 객체의 속성에 대한 게터를 사용하여 데이터를 해체합니다. 값이 같은 유형을 가지고 있지 않다면 그들은 반박된다.

```dart
switch (shape) {
  // Matches if shape is of type Rect, and then against the properties of Rect.
  case Rect(width: var w, height: var h): // ...
}
```

The getter name can be omitted and inferred from the [variable pattern](https://dart.dev/language/pattern-types#variable) or [identifier pattern](https://dart.dev/language/pattern-types#identifier) in the field subpattern:
> Getter 이름은 필드 하위 패턴의 변수 패턴 또는 식별자 패턴에서 생략하고 추론할 수 있습니다.

```dart
// Binds new variables x and y to the values of Point's x and y properties.
var Point(:x, :y) = Point(1, 2);
```

Object patterns don’t require the pattern to match the entire object. If an object has extra fields that the pattern doesn’t destructure, it can still match.
> 객체 패턴은 패턴이 전체 객체와 일치할 필요가 없다. 객체에 패턴이 해체되지 않는 추가 필드가 있다면, 여전히 일치할 수 있다.

### Wildcard
`_`

A pattern named `_` is a wildcard, either a [variable pattern](https://dart.dev/language/pattern-types#variable) or [identifier pattern](https://dart.dev/language/pattern-types#identifier), that doesn’t bind or assign to any variable.
> _라는 이름의 패턴은 어떤 변수에도 바인딩하거나 할당하지 않는 변수 패턴 또는 식별자 패턴인 와일드카드입니다.

It’s useful as a placeholder in places where you need a subpattern in order to destructure later positional values:
> 나중에 위치 값을 해체하기 위해 하위 패턴이 필요한 곳에서 자리 표시자로 유용합니다.

```dart
var list = [1, 2, 3];
var [_, two, _] = list;
```

A wildcard name with a type annotation is useful when you want to test a value’s type but not bind the value to a name:
> 유형 주석이 있는 와일드카드 이름은 값의 유형을 테스트하지만 값을 이름에 바인딩하지 않을 때 유용합니다.

```dart
switch (record) {
  case (int _, String _):
    print('First field is int and second is String.');
}
```