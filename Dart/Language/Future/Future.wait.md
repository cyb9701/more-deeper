`wait<T> static method`
#async #method

---
## Docs
https://api.flutter.dev/flutter/dart-async/Future/wait.html

```dart
Future<List<T>> wait<T>(
	Iterable<Future<T>> futures,{
		bool eagerError = false,
		void cleanUp(T successValue)?,
	}
)
```

Waits for multiple futures to complete and collects their results.
>여러 future가 완료되기를 기다리고 결과를 수집합니다.

Returns a future which will complete once all the provided futures have completed, either with their results, or with an error if any of the provided futures fail.
>제공된 모든 future가 완료되면 완료될 future를 결과와 함께 반환하거나 제공된 future 중 하나라도 실패할 경우 오류와 함께 반환합니다.

The value of the returned future will be a list of all the values that were produced in the order that the futures are provided by iterating `futures`.
>반환된 퓨처의 값은 퓨처를 반복하여 퓨처가 제공되는 순서대로 생성된 모든 값의 목록이 됩니다.

If any future completes with an error, then the returned future completes with that error. If further futures also complete with errors, those errors are discarded.
>퓨처가 오류로 완료되면 반환된 퓨처도 해당 오류로 완료됩니다. 추가 future도 오류로 완료되면 해당 오류는 삭제됩니다.

If `eagerError` is true, the returned future completes with an error immediately on the first error from one of the futures. Otherwise all futures must complete before the returned future is completed (still with the first error; the remaining errors are silently dropped).
>eagerError가 true인 경우, 반환된 future는 future 중 하나의 첫 번째 오류 발생 즉시 오류와 함께 완료됩니다. 그렇지 않으면 반환된 future가 완료되기 전에 모든 future가 완료되어야 합니다(여전히 첫 번째 오류가 있고 나머지 오류는 자동으로 삭제됩니다).

In the case of an error, `cleanUp` (if provided), is invoked on any non-null result of successful futures. This makes it possible to `cleanUp` resources that would otherwise be lost (since the returned future does not provide access to these values). The `cleanUp` function is unused if there is no error.
>오류가 발생한 경우 성공적인 future의 null이 아닌 결과에 대해 cleanUp(제공된 경우)이 호출됩니다. 이는 손실될 수 있는 리소스를 정리하는 것을 가능하게 합니다(반환된 future는 이러한 값에 대한 액세스를 제공하지 않기 때문입니다). 오류가 없으면 cleanUp 기능은 사용되지 않습니다.

The call to `cleanUp` should not throw. If it does, the error will be an uncaught asynchronous error.
>cleanUp 호출이 발생하면 안 됩니다. 그렇다면 오류는 포착되지 않은 비동기 오류가 됩니다.

Example:
```dart
void main() async { 
	var value = await Future.wait([delayedNumber(), delayedString()]); 
	print(value); // [2, result] 
}

Future<int> delayedNumber() async {
	await Future.delayed(const Duration(seconds: 2));
	return 2;
}

Future<String> delayedString() async {
	await Future.delayed(const Duration(seconds: 2));
	return 'result'; 
}
```

---
## Use
여러개의 Future 함수를 실행을 할 때 중간에 오류가 발생해도 그 다음 Future 함수를 실행시키고 싶을 때 사용한다.
즉, 병렬 함수가 중간에 오류가 발생해도 완료되게 하는 방법이다.

Example:
```dart
Future.wait([
	Future.delayed(Duration(seconds: 1), () => 1),
	Future.delayed(Duration(seconds: 2), () => 2),
	Future.delayed(Duration(seconds: 3), () => throw 'Error'),
	Future.delayed(Duration(seconds: 4), () => 4),
	Future.delayed(Duration(seconds: 5), () => 5),
]).then((results) {
	print(results); // [1, 2, null, 4, 5]
});
```

단, Future 함수에서 반환하는 값을 동기 처리를 할 경우에는 사용이 불가능하다.
배열안에 있는 모든 Future 함수가 종료되야지 결과값을 반환하기 때문이다.
이럴 경우 `Future.wait()` 을 사용하는 것 보다 오류가 발생할만한 함수안에서 `try-catch` 를 이용해서 예외 처리를 하는게 더 효과적이다.