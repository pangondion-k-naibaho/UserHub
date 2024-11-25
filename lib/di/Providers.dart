import 'package:riverpod/riverpod.dart';
import 'package:userhub/data/local/DatabaseHelper.dart';
import 'package:userhub/ui/viewmodel/LoginViewModel.dart';
import '../data/model/User.dart';
import '../data/model/response/CollectionUserResponse.dart';
import '../data/networking/UserService.dart';
import '../data/repository_impl/UserDashboardRepositoryImpl.dart';
import '../data/repository_impl/UserRepositoryImpl.dart';
import '../domain/repositories/UserDashboardRepository.dart';
import '../domain/repositories/UserRepository.dart';
import '../ui/viewmodel/DashboardViewModel.dart';

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

final userDashboardApiServiceProvider = Provider<UserService>((ref) {
  return UserService.create();
});

final userDashboardRepositoryProvider = Provider<UserDashboardRepository>((ref) {
  final apiService = ref.read(userDashboardApiServiceProvider);
  return UserDashboardRepositoryImpl(apiService);
});

final dashboardViewModelProvider = StateNotifierProvider<DashboardViewModel, AsyncValue<CollectionUserResponse>>((ref) {
  final repository = ref.read(userDashboardRepositoryProvider);
  return DashboardViewModel(repository);
});