import 'package:shared_preferences/shared_preferences.dart';
///shared preferences : a small key-value storage on the user's device.
class SessionStore {

  static const _key = 'last_signed_in_email';

  Future<String?> lastSignedInEmail() async =>
      (await SharedPreferences.getInstance()).getString(_key);

  Future<void> saveEmail(String email) async =>
      (await SharedPreferences.getInstance()).setString(_key, email);

  Future<void> clearEmail() async =>
      (await SharedPreferences.getInstance()).remove(_key);
}
