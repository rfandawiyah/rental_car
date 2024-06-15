import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  static const String _accessTokenKey = 'access_token';

  // Mengambil token akses dari SharedPreferences
  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  // Menyimpan token akses ke SharedPreferences
  static Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(_accessTokenKey, accessToken);
  }

  // Hapus token akses dari SharedPreferences
  static Future<void> removeAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(_accessTokenKey);
  }
}
