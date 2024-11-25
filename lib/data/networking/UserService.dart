import 'package:chopper/chopper.dart';
import '../Constants.dart';
part 'UserService.chopper.dart';

@ChopperApi()
abstract class UserService extends ChopperService {
  @Get(path: '/users')
  Future<Response> getUsers({
    @Query('page') required int page,
    @Query('per_page') required int perPage,
  });

  static UserService create() {
    final client = ChopperClient(
      baseUrl: Uri.tryParse(Constants.API_URL),
      services: [
        _$UserService(),
      ],
      converter: const JsonConverter(),
    );
    return _$UserService(client);
  }
}
