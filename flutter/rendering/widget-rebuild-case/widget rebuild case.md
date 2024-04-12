## 자식 위젯은 언제 재빌드가 될까?

- 부모 위젯에서 setState 할 경우 자식 위젯들이 재빌드되는 경우가 다르다.
- 자식 위젯이 stateless, stateful 위젯으로 구현돼있는 건 중요하지 않다.
- 자식 위젯이 부모 위젯으로부터 특정 값을 전달 받는지, 안받는지에 따라서 재빌드가 결정된다.
  - 자식 위젯이 부모로부터 데이터를 전달는 경우에는 부모에서 setState를 실행하면 자식 위젯으로 재빌드된다.
  - 반대로 부모로부터 데이터를 전달받지 않는 위젯은 부모에서 setSatet를 실행해도 재빌드되지 않는다.