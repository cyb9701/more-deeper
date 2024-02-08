## part

part는 package를 좀 . 더보기 쉽게 여러 파일로 분할할 때 사용하는 키워드이다.

## 왜 사용할까?

package를 작성할 때 코드의 길이가 너무 길어서 코드를 읽는데 어려움을 겪을 때가 있다.
이를 해결하기 위해서, package를 여러 파일로 분할하여 저장할 때 part를 사용한다.

part 키워드는 하나의 Library의 코드를 여러 파일로 분할해서 저장할 때 사용할 수 있다.

## 적용 전

```dart
// custom_library.dart

void a(){
  print('a');
}

void b(){
  print('b');
}

void c(){
  print('c');
}
```

## 적용 후

```dart
// custom_library.dart

part 'part_one.dart';
part 'part_two.dart';

void a(){
  print('a');
}
```

```dart
// part_one.dart

part of 'custom_library.dart';

void b(){
  print('b');
}
```

```dart
// part_two.dart

part of 'custom_library.dart';

void c(){
  print('c');
}
```
