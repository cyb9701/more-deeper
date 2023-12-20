## SOLID란?
- SOLID란 객체 지향 프로그래밍 및 설계의 다섯가지 기본 원칙을 말한다.
- 시간이 지나도 유지 보수와 확장이 쉬운 시스템을 만들고자 할 때 이 원칙들을 함께 적용할 수 있다.

## S
> 단일 책임 원칙 (Single responsibility principle)

한 클래스는 하나의 책임만 가져야 한다.

## O
> 개방-폐쇄 원칙 (Open/closed principle)

소프트웨어 요소는 확장에는 열려 있으나 변경에는 닫혀 있어야 한다
## L
> 리스코프 치환 원칙 (Liskov substitution principle)

프로그램의 객체는 프로그램의 정확성을 깨뜨리지 않으면서 하위 타입의 인스턴스로 바꿀 수 있어야 한다.
## I
> 인터페이스 분리 원칙 (Interface segregation principle)

특정 클라이언트를 위한 인터페이스 여러 개가 범용 인터페이스 하나보다 낫다

## D
> 의존관계 역전 원칙 (Dependency inversion principle)

프로그래머는 추상화에 의존해야지, 구체화에 의존하면 안된다.
의존성 주입은 이 원칙을 따르는 방법 중 하나다