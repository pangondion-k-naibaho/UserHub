import '../../domain/repositories/UserDashboardRepository.dart';
import '../model/response/CollectionUserResponse.dart';
import '../networking/UserService.dart';

class UserDashboardRepositoryImpl implements UserDashboardRepository {
  final UserService _apiService;

  UserDashboardRepositoryImpl(this._apiService);

  @override
  Future<CollectionUserResponse> fetchUsers({required int page, required int perPage}) async {
    final response = await _apiService.getUsers(page: page, perPage: perPage);

    if (response.isSuccessful) {
      final json = response.body;
      return CollectionUserResponse.fromJson(json);
    } else {
      throw Exception('Failed to load users: ${response.error}');
    }
  }
}