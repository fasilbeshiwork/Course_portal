import 'dart:async';

import 'package:course_portal/data/dataProviders/user_api_provider.dart';
import 'package:course_portal/data/models/user_.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  final UserApiProvider userApiProvider = UserApiProvider();

  Future<User> getUser(int id) async {
    final user = await userApiProvider.getUser(http.Client(), id);
    return user;
  }
}
