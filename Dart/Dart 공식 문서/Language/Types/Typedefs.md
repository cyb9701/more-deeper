#types 

---
## Docs
https://dart.dev/language/typedefs

A type alias—often called a _typedef_ because it’s declared with the keyword `typedef`—is a concise way to refer to a type. Here’s an example of declaring and using a type alias named `IntList`:
> 키워드 typedef로 선언되기 때문에 종종 typedef라고 불리는 유형 별칭은 유형을 참조하는 간결한 방법입니다. 다음은 IntList라는 유형 별칭을 선언하고 사용하는 예입니다:

```dart
typedef IntList = List<int>;
IntList il = [1, 2, 3];
```

A type alias can have type parameters:
> 유형 별칭은 유형 매개 변수를 가질 수 있습니다:

```dart
typedef ListMapper<X> = Map<X, List<X>>;
Map<String, List<String>> m1 = {}; // Verbose.
ListMapper<String> m2 = {}; // Same thing but shorter and clearer.
```

We recommend using [inline function types](https://dart.dev/effective-dart/design#prefer-inline-function-types-over-typedefs) instead of typedefs for functions, in most situations. However, function typedefs can still be useful:
> 대부분의 상황에서 함수에 typedef 대신 인라인 함수 유형을 사용하는 것이 좋습니다. 그러나, 함수 typedefs는 여전히 유용할 수 있다:

```dart
typedef Compare<T> = int Function(T a, T b);

int sort(int a, int b) => a - b;

void main() {
  assert(sort is Compare<int>); // True!
}
```