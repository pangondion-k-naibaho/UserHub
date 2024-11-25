import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/model/response/CollectionUserResponse.dart';
import '../../data/model/response/UserResponse.dart';
import '../../domain/repositories/UserDashboardRepository.dart';

class DashboardViewModel extends StateNotifier<AsyncValue<CollectionUserResponse>> {
  final UserDashboardRepository _repository;
  int currentPage = 1;
  bool isLoadingMore = false;
  CollectionUserResponse? _cachedResponse;

  DashboardViewModel(this._repository) : super(const AsyncValue.loading());

  Future<void> fetchUsers({required int page, required int perPage, bool append = false}) async {
    try {
      if (append) {
        isLoadingMore = true;
        state = AsyncValue.data(_cachedResponse!); // Tampilkan data sementara loading
      } else {
        state = const AsyncValue.loading();
      }

      final response = await _repository.fetchUsers(page: page, perPage: perPage);

      if (append && _cachedResponse != null) {
        // Append data baru ke data lama
        final newData = List<UserResponse>.from(_cachedResponse!.data)..addAll(response.data);
        _cachedResponse = CollectionUserResponse(
          page: response.page,
          perPage: response.perPage,
          total: response.total,
          totalPages: response.totalPages,
          data: newData,
        );
      } else {
        _cachedResponse = response;
      }

      state = AsyncValue.data(_cachedResponse!);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    } finally {
      isLoadingMore = false;
    }
  }

  bool canLoadMore() {
    return _cachedResponse != null &&
        _cachedResponse!.page! < _cachedResponse!.totalPages!;
  }
}