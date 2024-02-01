## [IntrinsicHeight class](https://api.flutter.dev/flutter/widgets/IntrinsicHeight-class.html)

자식의 고유 높이에 맞게 자식 크기를 조정하는 위젯입니다.

예를 들어, 이 클래스는 무제한 높이를 사용할 수 있고 자녀가 더 적당한 높이로 크기를 조정하기 위해 무한히 확장하려고
시도하려는 경우에 유용합니다.

이 위젯이 자식에게 전달하는 제약 조건은 부모의 제약 조건을 따르므로 제약 조건이 자식의 최대 고유 높이를 충족할 만큼
크지 않으면 자식은 그렇지 않은 경우보다 높이가 낮아집니다.
마찬가지로, 최소 높이 제한이 아이의 최대 고유 키보다 크면 아이에게는 그렇지 않은 경우보다 더 많은 키가 부여됩니다.

이 클래스는 최종 레이아웃 단계 전에 예측적 레이아웃 단계를 추가하기 때문에 상대적으로 비용이 많이 듭니다.
가능하면 사용을 자제하세요. 최악의 경우 이 위젯은 트리 깊이가 O(N²)인 레이아웃을 초래할 수 있습니다.

## AS-IS

Column에서 spaceBetween이 적용해도 Container의 높이를 전체로 차지하고 있지 않는다.

```dart
class UnUsedIntrinsicHeight extends StatelessWidget {
  const UnUsedIntrinsicHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 120,
            height: 120,
            color: Colors.red,
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.blue,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('1'),
                Text('2'),
                Text('3'),
              ],
            ),
          ),
        )
      ],
    );
  }
}
```

## TO-BE

```dart
class UsedIntrinsicHeight extends StatelessWidget {
  const UsedIntrinsicHeight({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 120,
              height: 120,
              color: Colors.red,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.blue,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('1'),
                  Text('2'),
                  Text('3'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
```
