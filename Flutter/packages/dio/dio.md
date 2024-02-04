## [dio](https://pub.dev/packages/dio)

final response = await Dio().post(
'$ip/auth/token',
        options: Options(
          headers: {
            authorization: '$bearer $refreshToken',
},
),
);

await storage.write(key: accessTokenKey, value: response.data['accessToken']);

---

class CustomInterceptor extends Interceptor {
