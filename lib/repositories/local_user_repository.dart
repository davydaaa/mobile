import 'package:lab_1/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalUserRepository implements UserRepository {
  static const String _emailKey = 'user_email';
  static const String _passwordKey = 'user_password';
  static const String _loggedInKey = 'is_logged_in';

  @override
  Future<void> saveUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
    await prefs.setBool(_loggedInKey, true);
  }

  @override
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString(_emailKey);
    final storedPassword = prefs.getString(_passwordKey);
    final isValid = storedEmail == email && storedPassword == password;

    if (isValid) await prefs.setBool(_loggedInKey, true);
    return isValid;
  }

  @override
  Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final isLoggedIn = prefs.getBool(_loggedInKey) ?? false;
    return isLoggedIn ? prefs.getString(_emailKey) : null;
  }

  @override
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loggedInKey, false);
  }
}
