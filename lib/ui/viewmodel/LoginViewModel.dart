import 'package:riverpod/riverpod.dart';
import '../../data/model/User.dart';
import '../../domain/repositories/UserRepository.dart';


class LoginViewModel extends StateNotifier<AsyncValue<List<User>>> {
  final UserRepository _userRepository;

  LoginViewModel(this._userRepository) : super(const AsyncValue.loading());

  Future<void> loginUser(String email, String password) async {
    try {
      state = const AsyncValue.loading();

      // Ambil user dari repository
      final user = await _userRepository.getUser(email, password);

      // Periksa apakah user ditemukan atau null
      if (user != null) {
        // Jika user ditemukan, masukkan dalam list (karena state menggunakan List<User>)
        state = AsyncValue.data([user]);
      } else {
        // Jika user tidak ditemukan, gunakan AsyncValue dengan data kosong
        state = AsyncValue.data([]);
      }
    } catch (e) {
      // Tangani error dan ubah state ke AsyncValue.error
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> insertUsers(List<User> users) async {
    try {
      state = const AsyncValue.loading(); // Mengindikasikan loading ke UI
      await _userRepository.insertUsers(users);
      state = AsyncValue.data([]); // Set kembali ke sukses (data kosong untuk insert)
    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current); // Error
    }
  }
}