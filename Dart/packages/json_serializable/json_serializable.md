패키지 버전: 6.7.1

## [json_serializable](https://pub.dev/packages/json_serializable)

- Json 처리를 위한 Dart 빌드 시스템 빌더를 제공한다.
- 빌더는 [package:json_annotation](https://pub.dev/packages/json_annotation) 에 정의된 클래스로 주석이 달린 멤버를 찾을 때 코드를 생성한다.

## 예제

```dart
import 'package:json_annotation/json_annotation.dart';

part 'example.g.dart';

@JsonSerializable()
class Person {
  /// The generated code assumes these values exist in JSON.
  final String firstName, lastName;

  /// The generated code below handles if the corresponding JSON value doesn't
  /// exist or is empty.
  final DateTime? dateOfBirth;

  Person({required this.firstName, required this.lastName, this.dateOfBirth});

  /// Connect the generated [_$PersonFromJson] function to the `fromJson`
  /// factory.
  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  /// Connect the generated [_$PersonToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}
```

## 코드 생성기 실행

[package:build_runner](https://pub.dev/packages/build_runner)

- 코드 생성기를 통해서 `.g.dart` 파일을 생성한다.

```
dart run build_runner build
```

## [@JsonSerializable()](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonSerializable-class.html)

- 빌드 시 `toJson` 과 `fromJson` 을 생성한다.

### [createToJson](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonSerializable/createToJson.html)

- `toJson` 생성 여부를 설정할 수 있다.
- 기본값은 `true`이다.

### [fieldRename](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonSerializable/fieldRename.html)

- 클래스 필드 이름을 Json 맵 키로 변환 시 자동으로 변경해준다.

```dart
@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class Person {
  final int totalPrice;

  Person({
    required this.totalPrice,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      totalPrice: json['total_price'] as int,
    );
```

### [genericArgumentFactories](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonSerializable/genericArgumentFactories.html)

- 제네릭을 사용하여 직렬화를 할 경우 `true`하면 된다.
- `fromJson`에서 어떤 제네릭을 직렬화하는지 알려주는 함수를 추가해야 한다.

## [@JsonKey()](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonKey-class.html)

- 대상 필드에 주석을 추가할 때 속성을 설정한다.
- `JsonSerializable` 와 `JsonKey`의 설정과 중복되는 설정이 있다. 이럴 경우, `JsonSerializable` 보다 `JsonKey`의 속성이 더 높은 우선 순위를 가진다.

### [defaultValue](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonKey/defaultValue.html)

- `nullalble` 변수의 기본값을 설정 가능하다.

```dart
@JsonSerializable()
class Person {
  @JsonKey(
    defaultValue: 9999,
  )
  final int? price;

  Person({
    this.price,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      price: json['price'] as int? ?? 9999,
    );
```

### [fromJson](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonKey/fromJson.html)

- 함수를 통해서 Json 결과값을 디코딩할 수 있다.
- 보통 이미지 경로 등을 변환할 때 사용한다.
- 함수는 반드시 `static` 함수여야 한다.

```dart
class DataUtils {
  static String pathToUrl(String value) {
    return 'https://google.com$value';
  }
}
```

```dart
@JsonSerializable()
class Person {
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String imageUrl;

  Person({
    required this.imageUrl,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      imageUrl: DataUtils.pathToUrl(json['imageUrl'] as String),
    );
```

### [name](https://pub.dev/documentation/json_annotation/4.8.1/json_annotation/JsonKey/name.html)

- Json 맵의 키 이름을 변경할 수 있다.

```dart
@JsonSerializable()
class Person {
  @JsonKey(
    name: 'converted-name',
  )
  final String? imageUrl;

  Person({
    this.imageUrl,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      imageUrl: json['converted-name'] as String?,
    );
```

- `@JsonSerializable()`에서 `fieldRename`을 설정을 해도 `name`속성이 적용된다.

```dart
@JsonSerializable(
  fieldRename: FieldRename.pascal,
)
class Person {
  @JsonKey(
    name: 'converted-name',
  )
  final String? imageUrl;

  Person({
    this.imageUrl,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      imageUrl: json['converted-name'] as String?,
    );
```

## [열거형](https://pub.dev/packages/json_serializable#enums)

- 열거형 데이터로 맵핑이 가능하게 설정할 수 있다.
- `JsonValue`를 통해서 값을 지정할 수 있다.
- 또는 `JsonEnum` 어노테이션을 통해서도 설정이 가능하다.

```dart
enum StatusCode {
  @JsonValue(200)
  success,
  @JsonValue(301)
  movedPermanently,
  @JsonValue(302)
  found,
  @JsonValue(500)
  internalServerError,
}

@JsonEnum(valueField: 'code')
enum StatusCodeEnhanced {
  success(200),
  movedPermanently(301),
  found(302),
  internalServerError(500);

  final int code;

  const StatusCodeEnhanced(this.code);
}
```

```dart
@JsonSerializable()
class Person {
  final StatusCode statusCode;
  final StatusCodeEnhanced statusCodeEnhanced;

  Person({
    required this.statusCode,
    required this.statusCodeEnhanced,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
}
```

```dart
Person _$PersonFromJson(Map<String, dynamic> json) => Person(
      statusCode: $enumDecode(_$StatusCodeEnumMap, json['statusCode']),
      statusCodeEnhanced:
          $enumDecode(_$StatusCodeEnhancedEnumMap, json['statusCodeEnhanced']),
    );

const _$StatusCodeEnumMap = {
  StatusCode.success: 200,
  StatusCode.movedPermanently: 301,
  StatusCode.found: 302,
  StatusCode.internalServerError: 500,
};

const _$StatusCodeEnhancedEnumMap = {
  StatusCodeEnhanced.success: 200,
  StatusCodeEnhanced.movedPermanently: 301,
  StatusCodeEnhanced.found: 302,
  StatusCodeEnhanced.internalServerError: 500,
};

```
