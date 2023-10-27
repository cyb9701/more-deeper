#class-modifier 

---
## [Docs] Class modifiers
https://dart.dev/language/class-modifiers

Class modifiers control how a class or mixin can be used, both [from within its own library](https://dart.dev/language/class-modifiers#abstract), and from outside of the library where it’s defined.
> 클래스 수정자는 클래스 또는 믹스인이 자체 라이브러리 내부와 정의된 라이브러리 외부에서 사용되는 방식을 제어합니다.

Modifier keywords come before a class or mixin declaration. For example, writing `abstract class` defines an abstract class. The full set of modifiers that can appear before a class declaration include:
> 수정자 키워드는 클래스 또는 믹스인 선언 앞에옵니다. 예를 들어, 추상 클래스를 작성하면 추상 클래스가 정의됩니다. 클래스 선언 앞에 나타날 수 있는 전체 수정자 집합은 다음과 같습니다:

- `abstract`
- `base`
- `final`
- `interface`
- `sealed`
- [[mixin]]

Only the `base` modifier can appear before a mixin declaration. The modifiers do not apply to other declarations like `enum`, `typedef`, or `extension`.
> 기본 수정자만 믹스인 선언 앞에 나타날 수 있습니다. 이 수정자는 열거형, typedef 또는 extension과 같은 다른 선언에는 적용되지 않습니다.

When deciding whether to use class modifiers, consider the intended uses of the class, and what behaviors the class needs to be able to rely on.
> 클래스 수정자를 사용할지 여부를 결정할 때는 클래스의 의도된 용도와 클래스가 의존할 수 있어야 하는 동작을 고려하세요.

> [!NOTE]
> If you maintain a library, read the [Class modifiers for API maintainers](https://dart.dev/language/class-modifiers-for-apis) page for guidance on how to navigate these changes for your libraries.
> > 라이브러리를 유지 관리하는 경우 API 유지 관리자를 위한 클래스 수정자 페이지에서 라이브러리에 대한 이러한 변경 사항을 탐색하는 방법에 대한 지침을 확인하세요.

### No modifier
To allow unrestricted permission to construct or subtype from any library, use a `class` or `mixin` declaration without a modifier. By default, you can:
> 라이브러리에서 구성하거나 하위 유형화할 수 있는 권한을 제한 없이 허용하려면 수정자 없이 클래스 또는 믹스인 선언을 사용합니다. 기본적으로 가능합니다:

- [Construct](https://dart.dev/language/constructors) new instances of a class.
- [Extend](https://dart.dev/language/extend) a class to create a new subtype.
- [Implement](https://dart.dev/language/classes#implicit-interfaces) a class or mixin’s interface.
- [Mix in](https://dart.dev/language/mixins) a mixin or mixin class.

> - 클래스의 새 인스턴스를 생성합니다.
> - 클래스를 확장하여 새 하위 유형을 생성합니다.
> - 클래스 또는 믹스인의 인터페이스를 구현합니다.
> - 믹스인 또는 믹스인 클래스에서 믹스합니다.

### [[abstract]]
### [[base]]
### [[interface]]
#### [[abstract interface]]
### [[final]]
### [[sealed]]
### Combining modifiers

You can combine some modifiers for layered restrictions. A class declaration can be, in order:
> 계층 제한을 위해 몇 가지 수정자를 결합할 수 있습니다. 클래스 선언은 순서대로 사용할 수 있습니다:

1. (Optional) `abstract`, describing whether the class can contain abstract members and prevents instantiation.
2. (Optional) One of `base`, `interface`, `final` or `sealed`, describing restrictions on other libraries subtyping the class.
3. (Optional) `mixin`, describing whether the declaration can be mixed in.
4. The `class` keyword itself.

> 1. (선택 사항) 추상, 클래스가 추상 멤버를 포함할 수 있고 인스턴스화를 방지하는지 여부를 설명합니다.
> 2. (선택 사항) 베이스, 인터페이스, 파이널, 밀봉 중 하나로, 클래스를 서브타입화하는 다른 라이브러리에 대한 제한을 설명합니다.
> 3. (선택 사항) mixin, 선언을 혼합할 수 있는지 여부를 설명합니다.
> 4. 클래스 키워드 자체.

You can’t combine some modifiers because they are contradictory, redundant, or otherwise mutually exclusive:
> 일부 수식어는 모순되거나 중복되거나 상호 배타적이기 때문에 결합할 수 없습니다:

- `abstract` with `sealed`. A [sealed](https://dart.dev/language/class-modifiers#sealed) class is always implicitly [abstract](https://dart.dev/language/class-modifiers#abstract).
- `interface`, `final` or `sealed` with `mixin`. These access modifiers prevent [mixing in](https://dart.dev/language/mixins).

> - 봉인된 추상화. 봉인된 수업은 항상 암묵적으로 추상적이다.
> - 인터페이스, 최종 또는 믹스인으로 밀봉. 이러한 접근 수정자는 혼합을 방지한다.

See the [Class modifiers reference](https://dart.dev/language/modifier-reference) for complete guidance.
> 전체 지침은 클래스 수정자 참조를 참조하세요.