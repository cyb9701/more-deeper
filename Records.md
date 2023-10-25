#types

sdfsdfsdfds

---

## Docs

https://dart.dev/language/records

Records are an anonymous, immutable, aggregate type. Like
other[collection types](https://dart.dev/language/collections), they let you bundle multiple objects into a single
object. Unlike other collection types, records are fixed-sized, heterogeneous, and typed.
> 레코드는 익명의 불변의 집계 유형입니다. 다른 컬렉션 유형과 마찬가지로 여러 개체를 하나의 개체로 묶을 수 있습니다. 다른 컬렉션 유형과 달리 레코드는 고정 크기, 이질적이며 유형이 지정됩니다.

Records are real values; you can store them in variables, nest them, pass them to and from functions, and store them in
data structures such as lists, maps, and sets.
> 레코드는 실제 값이므로 변수에 저장하고, 중첩하고, 함수와 주고받을 수 있으며, 목록, 맵, 집합과 같은 데이터 구조에 저장할 수 있습니다.

### Record syntax

_Records expressions_are comma-delimited lists of named or positional fields, enclosed in parentheses:
> 레코드 표현식은 괄호로 묶인 이름 또는 위치 필드의 쉼표로 구분된 목록입니다:

```dart

var record = ('first', a: 2, b: true, 'last');
```

_Record type annotations_are comma-delimited lists of types enclosed in parentheses. You can use record type annotations
to define return types and parameter types. For example, the following`(int, int)`statements are record type
annotations:
> 레코드 유형 어노테이션은 괄호로 묶인 쉼표로 구분된 유형 목록입니다. 레코드 타입 어노테이션을 사용하여 반환 타입과 매개변수 타입을 정의할 수 있습니다. 예를 들어 다음 `(int, int)` 문은 레코드 유형
> 어노테이션입니다:

```dart
(int, int) swap((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
```

Fields in record expressions and type annotations mirror
how[parameters and arguments](https://dart.dev/language/functions#parameters)work in functions. Positional fields go
directly inside the parentheses:
> 레코드 표현식과 유형 주석의 필드는 함수에서 매개변수와 인수가 작동하는 방식을 반영합니다. 위치 필드는 괄호 안에 바로 들어갑니다:

```dart
// Record type annotation in a variable declaration:
(String, int) record;

// Initialize it with a record expression:
record = ('A string
'
,
123
);
```

In a record type annotation, named fields go inside a curly brace-delimited section of type-and-name pairs, after all
positional fields. In a record expression, the names go before each field value with a colon after:
> 레코드 유형 주석에서 명명된 필드는 모든 위치 필드 다음에 중괄호로 구분된 유형 및 이름 쌍의 섹션 안에 들어갑니다. 레코드 표현식에서 이름은 각 필드 값 앞에 오고 콜론은 뒤에옵니다:

```dart
// Record type annotation in a variable declaration:
({int a, bool b}) record;

// Initialize it with a record expression:
record = (
a
:
123
,
b
:
true
);
```

The names of named fields in a record type are part of
the[record’s type definition](https://dart.dev/language/records#record-types), or its_shape_. Two records with named
fields with different names have different types:
> 레코드 유형에서 명명된 필드의 이름은 레코드 유형 정의의 일부 또는 그 모양입니다. 이름이 다른 명명된 필드가 있는 두 레코드의 유형은 서로 다릅니다:

```dart

({int a, int b}) recordAB = (a: 1, b: 2);
({int x, int y}) recordXY = (x: 3, y: 4);

// Compile error! These records don't have the same type.
// recordAB = recordXY;
```

In a record type annotation, you can also name the_positional_fields, but these names are purely for documentation and
don’t affect the record’s type:
> 레코드 유형 주석에서 위치 필드에 이름을 지정할 수도 있지만 이러한 이름은 순전히 문서화용이며 레코드 유형에는 영향을 미치지 않습니다:

```dart

(int a, int b) recordAB = (1, 2);
(int x, int y) recordXY = (3, 4);

recordAB = recordXY; // OK.
```

This is similar to how positional parameters in a function declaration or function typedef can have names but those
names don’t affect the signature of the function.
> 이는 함수 선언의 위치 매개변수나 함수 typedef에 이름을 가질 수 있지만 해당 이름이 함수의 서명에 영향을 미치지 않는 것과 유사합니다.

For more information and examples, check out[Record types](https://dart.dev/language/records#record-types)
and[Record equality](https://dart.dev/language/records#record-equality).
> 자세한 내용과 예제는 레코드 타입 및 레코드 동일성을 확인하세요.

### Record fields

Record fields are accessible through built-in getters. Records are immutable, so fields do not have setters.
> 레코드 필드는 내장된 게터를 통해 액세스할 수 있습니다. 레코드는 변경할 수 없으므로 필드에는 설정자가 없습니다.

Named fields expose getters of the same name. Positional fields expose getters of the name`$<position>`, skipping named
fields:
> 명명된 필드는 같은 이름의 게터를 노출합니다. 위치 필드는 명명된 필드를 건너뛰고 $<포지션>이라는 이름의 게터를 표시합니다:

```dart

var record = ('first', a: 2, b: true, 'last');

print
(
record.$1); // Prints 'first'
print(record.a); // Prints 2
print(record.b); // Prints true
print(record
.
$2
); // Prints 'last'
```

To streamline record field access even more, check out the page on[[Patterns#Destructuring multiple returns]].
> 레코드 필드 액세스를 더욱 간소화하려면 패턴 페이지를 확인하세요.

### Record types

There is no type declaration for individual record types. Records are structurally typed based on the types of their
fields. A record’s_shape_(the set of its fields, the fields’ types, and their names, if any) uniquely determines the
type of a record.
> 개별 레코드 유형에 대한 유형 선언은 없습니다. 레코드는 필드 유형에 따라 구조적으로 유형이 지정됩니다. 레코드의 모양(필드 집합, 필드 유형 및 이름(있는 경우)이 레코드의 유형을 고유하게 결정합니다.

Each field in a record has its own type. Field types can differ within the same record. The type system is aware of each
field’s type wherever it is accessed from the record:
> 레코드의 각 필드에는 고유한 유형이 있습니다. 필드 유형은 동일한 레코드 내에서 다를 수 있습니다. 유형 시스템은 레코드에서 액세스하는 모든 위치에서 각 필드의 유형을 인식합니다:

```dart

(num, Object) pair = (42, 'a');

var first = pair.$1; // Static type `num`, runtime type `int`.
var second = pair.$2; // Static type `Object`, runtime type `String`.
```

Consider two unrelated libraries that create records with the same set of fields. The type system understands that those
records are the same type even though the libraries are not coupled to each other.
> 동일한 필드 집합을 가진 레코드를 생성하는 서로 관련이 없는 두 개의 라이브러리를 생각해 보겠습니다. 유형 시스템은 라이브러리가 서로 결합되어 있지 않더라도 해당 레코드가 동일한 유형임을 이해합니다.

### Record equality

Two records are equal if they have the same_shape_(set of fields), and their corresponding fields have the same values.
Since named field_order_is not part of a record’s shape, the order of named fields does not affect equality.
> 두 레코드의 모양(필드 집합)이 같고 해당 필드의 값이 같으면 두 레코드는 동일합니다. 명명된 필드 순서는 레코드 모양의 일부가 아니므로 명명된 필드의 순서는 동일성에 영향을 미치지 않습니다.

For example:

```dart

(int x, int y, int z) point = (1, 2, 3);
(int r, int g, int b) color = (1, 2, 3);

print
(
point
==
color
); // Prints 'true'.
```

```dart

({int x, int y, int z}) point = (x: 1, y: 2, z: 3);
({int r, int g, int b}) color = (r: 1, g: 2, b: 3);

print
(
point
==
color
); // Prints 'false'. Lint: Equals on unrelated types.
```

Records automatically define`hashCode`and`==`methods based on the structure of their fields.
> 레코드는 필드의 구조를 기반으로 `해시코드`와 `==` 메서드를 자동으로 정의합니다.

### Multiple returns

Records allow functions to return multiple values bundled together. To retrieve record values from a return, destructure
the values into local variables
using[pattern matching](https://dart.dev/language/patterns#destructuring-multiple-returns).
> 레코드를 사용하면 함수가 여러 값을 함께 묶어서 반환할 수 있습니다. 반환값에서 레코드 값을 검색하려면 패턴 매칭을 사용하여 값을 로컬 변수로 분해합니다.

```dart
// Returns multiple values in a record:
(String, int) userInfo(Map<String, dynamic> json) {
  return (json['name'] as String, json['age'] as int);
}

final json = <String, dynamic>{
  'name': 'Dash',
  'age': 10,
  'color': 'blue',
};

// Destructures using a record pattern:
var
(name, age) = userInfo(json);

/* Equivalent to:
  var info = userInfo(json);
  var name = info.$1;
  var age  = info.$2;
*/
```

You can return multiple values from a function without records, but other methods come with downsides. For example,
creating a class is much more verbose, and using other collection types like`List`or`Map`loses type safety.
> 레코드 없이 함수에서 여러 값을 반환할 수 있지만 다른 방법에는 단점이 있습니다. 예를 들어 클래스를 만들면 훨씬 더 장황하고, List나 Map과 같은 다른 컬렉션 유형을 사용하면 유형 안전성이 떨어집니다.

> [!NOTE] Note
> Records’ multiple-return and heterogeneous-type characteristics enable parallelization of futures of different types,
> which you can read about in
> the [Library tour](https://dart.dev/guides/libraries/library-tour#handling-errors-for-multiple-futures).
>
> 레코드의 다중 반환 및 이질적 유형 특성을 통해 다양한 유형의 선물을 병렬화할 수 있으며, 라이브러리 둘러보기에서 이에 대해 자세히 알아볼 수 있습니다.