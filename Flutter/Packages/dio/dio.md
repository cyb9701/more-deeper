패키지 버전: 5.4.0

## [dio](https://pub.dev/packages/dio)

- http 네트워킹 패키지이다.
- 다양한 기능을 지원한다.
  - 전역 구성.
  - 인터셉터.
  - FormData.
  - 요청 취소.
  - 파일 업로드/다운로드.
  - 시간 초과.
  - 사용자 정의 어댑터.
  - 변환기.

## 기본 형태

```dart
import 'package:dio/dio.dart';

final dio = Dio();

void getHttp() async {
  final response = await dio.get('https://dart.dev');
  print(response);
}
```

## 싱글톤

- Dio 헤더, 기본 url, 시간 제한 과 같은 구성을 일관되게 관리할 수 있는 싱글톤을 프로젝트에서 사용하는게 좋다.
- 두가지 방법으로 이용 가능하다.
  - 전역 변수에 객체를 할당.
  - 싱글톤 클래스에서 객체 관리.

```dart
final dio = Dio(); // With default `Options`.

void configureDio() {
  // Set default configs
  dio.options.baseUrl = 'https://api.pub.dev';
  dio.options.connectTimeout = Duration(seconds: 5);
  dio.options.receiveTimeout = Duration(seconds: 3);

  // Or create `Dio` with a `BaseOptions` instance.
  final options = BaseOptions(
    baseUrl: 'https://api.pub.dev',
    connectTimeout: Duration(seconds: 5),
    receiveTimeout: Duration(seconds: 3),
  );
  final anotherDio = Dio(options);
}
```

## 인터셉터

- dio 인스턴스에 대해 하나 이상의 인터셉터를 추가할 수 있다.
- 이를 통해서 요청, 응답, 오류 상황을 처리할 수 있다.

```dart
dio.interceptors.add(
  InterceptorsWrapper(
    onRequest: (RequestOptions options, RequestInterceptorHandler handler) {
      // Do something before request is sent.
      // If you want to resolve the request with custom data,
      // you can resolve a `Response` using `handler.resolve(response)`.
      // If you want to reject the request with a error message,
      // you can reject with a `DioException` using `handler.reject(dioError)`.
      return handler.next(options);
    },
    onResponse: (Response response, ResponseInterceptorHandler handler) {
      // Do something with response data.
      // If you want to reject the request with a error message,
      // you can reject a `DioException` object using `handler.reject(dioError)`.
      return handler.next(response);
    },
    onError: (DioException error, ErrorInterceptorHandler handler) {
      // Do something with response error.
      // If you want to resolve the request with some custom data,
      // you can resolve a `Response` object using `handler.resolve(response)`.
      return handler.next(error);
    },
  ),
);
```

```dart
import 'package:dio/dio.dart';

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print('ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
```

### 맞춤형 인터셉터

- Interceptor/QueuedInterceptor 클래스를 확장하여 인터셉터를 사용자 정의할 수 있다.
- 간단한 캐시 정책을 구현하는 예시가 있다: [사용자 정의 캐시 인터셉터](https://github.com/cfug/dio/blob/main/example/lib/custom_cache_interceptor.dart)

## 오류 처리

- 오류가 발생하면 `Dio`는 `DioException`을 반환한다.

```dart
try {
  // 404
  await dio.get('https://api.pub.dev/not-exist');
} on DioException catch (e) {
  // The request was made and the server responded with a status code
  // that falls out of the range of 2xx and is also not 304.
  if (e.response != null) {
    print(e.response.data)
    print(e.response.headers)
    print(e.response.requestOptions)
  } else {
    // Something happened in setting up or sending the request that triggered an Error
    print(e.requestOptions)
    print(e.message)
  }
}
```

### DioException 유형

- [소스 코드](https://github.com/cfug/dio/blob/main/dio/lib/src/dio_exception.dart)를 참조.

## Transformer

- 변압기를 통해서 서버와 전송/수진되기 전에 요청/응답 데이터를 변경할 수 있다.
- PUT, POST, PATCH 에만 적용이 가능하다
- Json 디코딩의 경우 멀티 스레드에서 함수를 실행하는 것을 권장한다.

  ```dart
  /// Must be top-level function
  Map<String, dynamic> _parseAndDecode(String response) {
    return jsonDecode(response) as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> parseJson(String text) {
    return compute(_parseAndDecode, text);
  }

  void main() {
    // Custom `jsonDecodeCallback`.
    dio.transformer = DefaultTransformer()..jsonDecodeCallback = parseJson;
    runApp(MyApp());
  }
  ```
