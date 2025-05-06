abstract class UserRepository {
  Future<void> saveUser(String email, String password);
  Future<bool> login(String email, String password);
  Future<String?> getCurrentUserEmail();
  Future<void> logout();
}
