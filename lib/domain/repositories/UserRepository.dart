import '../../data/model/User.dart';

abstract class UserRepository {
  Future<User?> getUser(String email, String password);
  Future<void> insertUsers(List<User> users);
}