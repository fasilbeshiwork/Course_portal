import 'dart:convert';
import 'dart:io';

import 'package:course_portal/data/models/user_.dart';
import 'package:course_portal/utilities/base_url.dart';
import 'package:http/http.dart' as http;

class UserApiProvider {
  Future<User> getUser(http.Client client, int id) async {
    var url = Uri.parse(baseUrl + "/api/user/$id");

    //final response = await client.get(url, headers: {HttpHeaders.authorizationHeader: 'Bearer $token'});
    final response = await client.get(url);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }
    final responseJson = jsonDecode(response.body);
    print('GAAAAAAAA' + responseJson.toString());
    final usr = responseJson['user'];

    return User.fromJson(usr);
  }
}
