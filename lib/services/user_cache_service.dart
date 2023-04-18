import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../core/service_locator.dart';
import '../features/auth/data/models/auth_user.dart';

const String USER_CACHE_KEY = 'user-cache';

class UserCacheService {
  AuthUser? _user;
  AuthUser? get user => _user;

  SharedPreferences get sharedPrefs => serviceLocator<SharedPreferences>();

  Future<bool> saveUser(AuthUser user) async {
    var map = user.toJson();
    bool saved = await sharedPrefs.setString(USER_CACHE_KEY, jsonEncode(map));
    if (saved) {
      _user = await getUser();
    }
    return saved;
  }

  Future<AuthUser?> getUser() async {
    AuthUser usr;
    var userMap = sharedPrefs.getString(USER_CACHE_KEY);
    if (userMap == null) {
      return null;
    }
    usr = AuthUser.fromJson(jsonDecode(userMap));
    _user = usr;
    return usr;
  }

  Future<bool> deleteUser() async {
    _user = null;
    return await sharedPrefs.remove(USER_CACHE_KEY);
  }
}
