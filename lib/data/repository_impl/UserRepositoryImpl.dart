import 'package:logger/logger.dart';
import '../../domain/repositories/UserRepository.dart';
import '../local/DatabaseHelper.dart';
import '../model/User.dart';

class UserRepositoryImpl implements UserRepository {
  final DatabaseHelper _databaseHelper;
  final Logger _logger = Logger();

  UserRepositoryImpl(this._databaseHelper);

  // @override
  // Future<List<Map<String, dynamic>>> getUser(String email, String password) async {
  //   try {
  //     _logger.d("Fetching user with email: $email");
  //     return await _databaseHelper.getUser(email, password);
  //   } catch (e) {
  //     _logger.e("Error fetching user: $e");
  //     rethrow;
  //   }
  // }
  

  @override
  Future<void> insertUsers(List<User> users) async {
    try {
      _logger.d("Inserting ${users.length} users");
      final userMaps = users.map((user) => user.toMap()).toList();
      await _databaseHelper.insertUsers(userMaps);
    } catch (e) {
      _logger.e("Error inserting users: $e");
      rethrow;
    }
  }

  @override
  Future<User?> getUser(String email, String password) async {
    try {
      _logger.d("Fetching user with email: $email");

      // Ambil data user dari DatabaseHelper
      final userMap = await _databaseHelper.getUser(email, password);

      // Jika tidak ada user, log dan kembalikan null
      if (userMap == null) {
        _logger.d("No user found with email: $email");
        return null;
      }

      // Jika ada user, konversikan dari Map ke User
      return User.fromMap(userMap);
    } catch (e) {
      // Log error dan propagasi ulang error
      _logger.e("Error fetching user: $e");
      rethrow;
    }
  }
}