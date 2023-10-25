#inheritance #extends

---
## Docs
https://dart.dev/language#inheritance

Dart has single inheritance.
> 다트에는 단일 상속이 있습니다.

```dart
class Orbiter extends Spacecraft {
  double altitude;

  Orbiter(super.name, DateTime super.launchDate, this.altitude);
}
```

[Read more](https://dart.dev/language/extend) about extending classes, the optional `@override` annotation, and more.
> 클래스 확장, 선택적 @override 어노테이션 등에 대해 자세히 알아보세요.

> [!NOTE]
> [[Extends]]