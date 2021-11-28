import 'dart:convert';

import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/utilities/base_url.dart';
import 'package:course_portal/utilities/secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthenticationApiProvider {
  // final SecureStorage secureStorage;
  AuthenticationApiProvider(
      // {required this.secureStorage}
      );
  Future<User> logIn(String email, String password, http.Client client) async {
    var url = Uri.parse(baseUrl + "/api/login");

    final response =
        await client.post(url, body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      print(responseJson);

      final u1 = responseJson['user'];

      //  await secureStorage.saveData(
      //    responseJson['access_token'], 'access_token');

      return User.fromJson(u1);
    } else {
      throw Exception('EE11' + response.body);
    }
  }

  Future<User> register(
      {required String name,
      required String email,
      required String password,
      required String passwordConf,
      required String role,
      required http.Client client}) async {
    var url = Uri.parse(
      baseUrl + "/api/register",
    );
    final response = await client.post(
      url,
      body: {
        "name": name,
        'email': email,
        'password': password,
        'password_confirmation': passwordConf,
        "role": role
      },
    );

    if (response.statusCode != 200) throw Exception('EEEE' + response.body);
    //
    final responseJson = jsonDecode(response.body);
    final u1 = responseJson['user'];
    //u1["token"] = responseJson['token'];

    return User.fromJson(u1);
  }
}
