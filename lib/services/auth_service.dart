import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(email, password);
    await prefs.setBool('isLoggedIn', true);
    await prefs.setString('loggedInUser', email);
  }

  static Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedPassword = prefs.getString(email);
    if (storedPassword == password) {
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('loggedInUser', email);
      return true;
    }
    return false;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('loggedInUser');
  }

  static String? validateRegistration(String email, String password) {
    if (!email.contains('@')) return 'Невалідна пошта';
    if (password.length < 6) return 'Пароль має бути не менше 6 символів';
    return null;
  }
}
