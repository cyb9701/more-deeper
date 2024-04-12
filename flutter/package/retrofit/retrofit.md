## [retrofit](https://pub.dev/packages/retrofit)

- v4.1.0
- dio 클라이언트 생성기이다.

## Generator

```dart
dependencies:
  retrofit: '>=4.0.0 <5.0.0'
  logger: any  #for logging purpose
  json_annotation: ^4.8.1

dev_dependencies:
  retrofit_generator: '>=7.0.0 <8.0.0'   // required dart >=2.19
  build_runner: '>=2.3.0 <4.0.0'
  json_serializable: ^6.6.2
```

## 기본 유형

```dart
part 'example.g.dart';

@RestApi(baseUrl: 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('/tasks')
  Future<List<Task>> getTasks();
}
```

## HTTP 메소드

```dart
@GET('/tasks/{id}')
  Future<Task> getTask(@Path('id') String id);

  @GET('/demo')
  Future<String> queries(@Queries() Map<String, dynamic> queries);

  @GET('https://httpbin.org/get')
  Future<String> namedExample(
      @Query('apikey') String apiKey,
      @Query('scope') String scope,
      @Query('type') String type,
      @Query('from') int from);

  @PATCH('/tasks/{id}')
  Future<Task> updateTaskPart(
      @Path() String id, @Body() Map<String, dynamic> map);

  @PUT('/tasks/{id}')
  Future<Task> updateTask(@Path() String id, @Body() Task task);

  @DELETE('/tasks/{id}')
  Future<void> deleteTask(@Path() String id);

  @POST('/tasks')
  Future<Task> createTask(@Body() Task task);

  @POST('http://httpbin.org/post')
  Future<void> createNewTaskFromFile(@Part() File file);

  @POST('http://httpbin.org/post')
  @FormUrlEncoded()
  Future<String> postUrlEncodedFormData(@Field() String hello);
```

## 원본 HTTP 응답 받기

```dart
@GET('/tasks/{id}')
  Future<HttpResponse<Task>> getTask(@Path('id') String id);

  @GET('/tasks')
  Future<HttpResponse<List<Task>>> getTasks();
```

## 정적 HTTP 헤더

```dart
import 'package:dio/dio.dart' hide Headers;

  // ...

  @GET('/tasks')
  @Headers(<String, dynamic>{
    'Content-Type': 'application/json',
    'Custom-Header': 'Your header',
  })
  Future<Task> getTasks();
```

## 오류 처리

- catchError(Object)에서 예외 및 실패한 응답을 캡처한다.
- 오류의 자세한 정보는 DioError.response에서 확인이 가능하다.

```dart
client.getTask('2').then((it) {
  logger.i(it);
}).catchError((obj) {
  // non-200 error goes here.
  switch (obj.runtimeType) {
    case DioError:
      // Here's the sample to get the failed response error code and message
      final res = (obj as DioError).response;
      logger.e('Got error : ${res.statusCode} -> ${res.statusMessage}');
      break;
  default:
    break;
  }
});
```

## 상대 API baseUrl

- RestClient의 RestApi 주석에서 상대 baseUrl 값을 사용하려면 dio.options.baseUrl에 baseUrl을 지정해야 한다.

```dart
@RestApi(baseUrl: '/tasks')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @GET('{id}')
  Future<HttpResponse<Task>> getTask(@Path('id') String id);

  @GET('')
  Future<HttpResponse<List<Task>>> getTasks();
}
```

```dart
dio.options.baseUrl = 'https://5d42a6e2bc64f90014a56ca0.mockapi.io/api/v1';
final client = RestClient(dio);
```

## 다중 엔드포인트 지원

- RestClient에 여러 엔드포인트를 사용하려면 RestClient를 시작할 때 기본 URL을 전달해야 한다.
  - RestApi에 정의된 모든 값은 무시됩니다.
- 우선순위가 가장 낮은 dio.option.baseUrl의 기본 URL을 사용하려면 RestApi 주석 및 RestClient의 구조 메소드에 매개변수를 전달하지 마십시오.

```dart
@RestApi(baseUrl: 'this url will be ignored if baseUrl is passed')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;
}
```

```dart
final client = RestClient(dio, baseUrl: 'your base url');
```
