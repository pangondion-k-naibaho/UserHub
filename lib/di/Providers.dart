import 'package:riverpod/riverpod.dart';
import 'package:userhub/data/local/DatabaseHelper.dart';
import 'package:userhub/ui/viewmodel/LoginViewModel.dart';
import '../data/model/User.dart';
import '../data/repository_impl/UserRepositoryImpl.dart';
import '../domain/repositories/UserRepository.dart';

final databaseProvider = Provider<DatabaseHelper>((ref){
  return DatabaseHelper.instance;
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final databaseHelper = ref.watch(databaseProvider);
  return UserRepositoryImpl(databaseHelper);
});

final loginViewModelProvider = StateNotifierProvider<LoginViewModel, AsyncValue<List<User>>>((ref) {
  final userRepository = ref.watch(userRepositoryProvider);
  return LoginViewModel(userRepository);
});