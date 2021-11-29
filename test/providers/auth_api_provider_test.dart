import 'package:course_portal/data/dataProviders/authentication_api_provider.dart';
import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/utilities/base_url.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'auth_api_provider_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  //AuthApiProvider _authApiClient = AuthApiProvider();
  AuthenticationApiProvider _authApiClient = AuthenticationApiProvider();

  final client = MockClient();

  group('Registration:', () {
    final url = Uri.parse(baseUrl + "/api/register");
    test('\nRegister Success', () async {
      when(client.post(url, body: {
        "name": 'gadisa',
        'email': 'gadisa@gmail.com',
        'password': 'password',
        'password_confirmation': 'password',
        "role": 'student'
      })).thenAnswer((_) async => http.Response(
          '{"user":{"id": 2,"name": "gadisa","email":"gadisa@gmail.com","role":{"role":"student","user_id":2}  },"access_token":"token"}',
          200));
      expect(
          await _authApiClient.register(
              name: 'gadisa',
              email: 'gadisa@gmail.com',
              password: 'password',
              passwordConf: 'password',
              role: 'student',
              client: client),
          isA<User>());
    });
    test('\nRegister Failure', () {
      when(client.post(url, body: {
        "name": 'name',
        'email': 'email',
        'password': 'password',
        'password_confirmation': 'passwordConf',
        "role": 'role'
      })).thenAnswer((_) async => http.Response('Not Found', 404));
      expect(
          _authApiClient.register(
              name: 'name',
              email: 'email',
              password: 'password',
              passwordConf: 'passwordConf',
              role: 'role',
              client: client),
          throwsException);
    });
  });
  group('login:', () {
    final url = Uri.parse(baseUrl + "/api/login");
    test('\nLogin Success', () async {
      when(client.post(url, body: {
        'email': 'g@gmail.com',
        'password': 'aa123'
      })).thenAnswer((_) async => http.Response(
          //here token and user are sent as two key value
          '{"user":{"id": 2,"name": "gadisa","email":"gadisa@gmail.com","role":{"role":"student","user_id":2}  },"access_token":"token"}',
          200));
      expect(await _authApiClient.logIn("g@gmail.com", "aa123", client),
          isA<User>());
    });

    test('\nLogin Failure', () {
      when(client
              .post(url, body: {'email': 'g@gmail.com', 'password': 'wrong11'}))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      expect(_authApiClient.logIn('g@gmail.com', 'wrong11', client),
          throwsException);
    });
  });
}
