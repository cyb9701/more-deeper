#class-modifier 

---
## [Docs] Class modifiers | abstract interface
https://dart.dev/language/class-modifiers#abstract-interface

The most common use for the `interface` modifier is to define a pure interface. [Combine](https://dart.dev/language/class-modifiers#combining-modifiers) the `interface` and [`abstract`](https://dart.dev/language/class-modifiers#abstract)modifiers for an `abstract interface class`.
> 인터페이스 수정자의 가장 일반적인 용도는 순수 인터페이스를 정의하는 것입니다. 추상 인터페이스 클래스의 인터페이스와 추상 수정자를 결합합니다.

Like an `interface` class, other libraries can implement, but cannot inherit, a pure interface. Like an `abstract` class, a pure interface can have abstract members.
> 인터페이스 클래스와 마찬가지로 다른 라이브러리에서는 순수 인터페이스를 구현할 수는 있지만 상속할 수는 없습니다. 추상 클래스와 마찬가지로 순수 인터페이스도 추상 멤버를 가질 수 있습니다.