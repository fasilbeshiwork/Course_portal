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

  group('Register', () {
    final url = Uri.parse(baseUrl + "/api/register");
    test('Register Success', () async {
      when(client.post(url, body: {
        "name": 'name',
        'email': 'email',
        'password': 'password',
        'password_confirmation': 'passwordConf',
        "role": 'role'
      })).thenAnswer((_) async => http.Response(
          //here token and user are sent as two key value
          '{"token":"toooken","user":{"user_id": "1", "rating":"2","first_name": "gadisa","profile_picture":"proP","role":{"role":"student","user_id":"1"} ,"email": "gadisa@gmail.com", "last_name": "asfaw","subjects":{"data":[{ "name": "Mathematics","type":null}]}}}',
          200));
      expect(
          await _authApiClient.register(
              name: 'name',
              email: 'email',
              password: 'password',
              passwordConf: 'passwordConf',
              role: 'role',
              client: client),
          isA<User>());
    });
    test('Register Failure', () {
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
}
