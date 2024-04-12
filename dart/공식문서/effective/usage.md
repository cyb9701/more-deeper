# null

## [평등 작업에서 참 또는 거짓을 사용하지 마세요](https://dart.dev/effective-dart/usage#dont-use-true-or-false-in-equality-operations)

부울 리터럴에 대해 null할 수 없는 부울 표현식을 평가하기 위해 같음 연산자를 사용하는 것은 불필요하다.  
평등 연산자를 제거하고, 단항 부정 연산자를 사용하는 것은 항상 더 간단합니다! 필요하다면:

```dart
// good

if (nonNullableBool) { ... }
if (!nonNullableBool) { ... }
```

```dart
// bad

if (nonNullableBool == true) { ... }
if (nonNullableBool == false) { ... }
```

Nullable의 부울 표현식을 평가하려면, ??를 사용해야 합니다. 아니면 노골적인 것! = 널 체크.

```dart
// good

// If you want null to result in false:
if (nullableBool ?? false) { ... }

// If you want null to result in false
// and you want the variable to type promote:
if (nullableBool != null && nullableBool) { ... }
```

```dart
// bad

// Static error if null:
if (nullableBool) { ... }

// If you want null to be false:
if (nullableBool == true) { ... }
```

## [유형 승진을 활성화하기 위해 로컬 변수에 nullable 필드를 할당하는 것을 고려하십시오](https://dart.dev/effective-dart/usage#consider-assigning-a-nullable-field-to-a-local-variable-to-enable-type-promotion)

Nullable 변수가 null과 같지 않은지 확인하면 변수를 nullable 유형으로 승격합니다. 이를 통해 변수의 멤버에 액세스하여 null이 아닌 유형을 기대하는 함수에 전달할 수 있습니다.

그러나 유형 승진은 지역 변수, 매개 변수 및 개인 최종 필드에서만 지원됩니다. 조작에 열려 있는 값은 유형을 승진할 수 없습니다.

우리가 일반적으로 권장하는 바와 같이, 회원을 비공개 및 최종적으로 선언하는 것은 종종 이러한 제한을 우회하기에 충분하다. 하지만, 그것은 항상 선택 사항은 아니다.  
이를 해결할 수 있는 한 가지 패턴은 필드의 값을 지역 변수에 할당하는 것이다. 그 변수에 대한 Null 체크는 촉진될 것이므로, 당신은 그것을 null이 아닌 것으로 안전하게 취급할 수 있습니다.

```dart
// good

class UploadException {
  final Response? response;

  UploadException([this.response]);

  @override
  String toString() {
    final response = this.response;
    if (response != null) {
      return 'Could not complete upload to ${response.url} '
          '(error code ${response.errorCode}): ${response.reason}.';
    }

    return 'Could not upload (no response).';
  }
}
```

지역 변수에 할당하는 것은 사용하는 것보다 더 깨끗하고 안전할 수 있습니다! 값을 null이 아닌 것으로 취급해야 할 때마다:

```dart
// bad

class UploadException {
  final Response? response;

  UploadException([this.response]);

  @override
  String toString() {
    if (response != null) {
      return 'Could not complete upload to ${response!.url} '
          '(error code ${response!.errorCode}): ${response!.reason}.';
    }

    return 'Could not upload (no response).';
  }
}
```

# 컬렉션(Collections)

## [가능하면 컬렉션 리터럴을 사용하세요](https://dart.dev/effective-dart/usage#do-use-collection-literals-when-possible)

컬렉션 리터럴은 다른 컬렉션의 콘텐츠를 포함하고 콘텐츠를 구축하는 동안 제어 흐름을 수행하기 위해 스프레드 운영자에 대한 액세스를 제공하기 때문에 다트에서 특히 강력합니다.

```dart
// good

var arguments = [
  ...options,
  command,
  ...?modeFlags,
  for (var path in filePaths)
    if (path.endsWith('.dart')) path.replaceAll('.dart', '.js')
];
```

```dart
// bad

var arguments = <String>[];
arguments.addAll(options);
arguments.add(command);
if (modeFlags != null) arguments.addAll(modeFlags);
arguments.addAll(filePaths
    .where((path) => path.endsWith('.dart'))
    .map((path) => path.replaceAll('.dart', '.js')));
```

## [whereType()을 사용하여 유형별로 컬렉션을 필터링하세요](https://dart.dev/effective-dart/usage#do-use-wheretype-to-filter-a-collection-by-type)

객체의 혼합이 포함된 목록이 있고, 정수만 얻고 싶다고 가정해 봅시다. 당신은 다음과 같이 where()를 사용할 수 있습니다:

```dart
// bad

var objects = [1, 'a', 2, 'b', 3];
var ints = objects.where((e) => e is int);
```

이것은 장황하지만, 더 나쁜 것은, 당신이 원하는 유형이 아닌 이터러블을 반환합니다. 이 예에서, 필터링하는 유형이기 때문에 Iterable<int>를 원하더라도 Iterable<Object>를 반환합니다.

때때로 당신은 cast()를 추가하여 위의 오류를 "수정"하는 코드를 볼 수 있습니다:

```dart
// bad

var objects = [1, 'a', 2, 'b', 3];
var ints = objects.where((e) => e is int).cast<int>();
```

그것은 장황하고 두 개의 간접 레이어와 중복 런타임 검사와 함께 두 개의 래퍼를 만듭니다. 다행히도, 핵심 라이브러리에는 이 정확한 사용 사례에 대한 whereType() 메소드가 있습니다:

```dart
// good

var objects = [1, 'a', 2, 'b', 3];
var ints = objects.whereType<int>();
```

## [근처 작업이 수행될 때 cast()를 사용하지 마세요](https://dart.dev/effective-dart/usage#dont-use-cast-when-a-nearby-operation-will-do)

종종 이터러블이나 스트림을 다룰 때, 당신은 그것에 대해 몇 가지 변환을 수행합니다. 결국, 당신은 특정 유형의 인수를 가진 객체를 생성하고 싶습니다. Cast()를 호출하는 대신, 기존 변환 중 하나가 유형을 변경할 수 있는지 확인하세요.

이미 toList()를 호출하고 있다면, T가 원하는 결과 목록의 유형인 List<T>.from() 호출로 바꾸세요.

```dart
// good

var stuff = <dynamic>[1, 2];
var ints = List<int>.from(stuff);
```

```dart
// bad

var stuff = <dynamic>[1, 2];
var ints = stuff.toList().cast<int>();
```

Map()를 호출하는 경우, 원하는 유형의 이터러블을 생성할 수 있도록 명시적인 유형 인수를 제공하십시오. 유형 추론은 종종 map()에 전달한 함수에 따라 올바른 유형을 선택하지만, 때로는 명시적이어야 합니다.

```dart
// good

var stuff = <dynamic>[1, 2];
var reciprocals = stuff.map<double>((n) => 1 / n);
```

```dart
// bad

var stuff = <dynamic>[1, 2];
var reciprocals = stuff.map((n) => 1 / n).cast<double>();
```
