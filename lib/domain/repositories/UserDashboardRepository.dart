import '../../data/model/response/CollectionUserResponse.dart';
import '../../data/networking/UserService.dart';

abstract class UserDashboardRepository {
  Future<CollectionUserResponse> fetchUsers({required int page, required int perPage});
}