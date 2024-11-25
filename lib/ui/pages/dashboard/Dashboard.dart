import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import '../../../data/model/response/CollectionUserResponse.dart';
import '../../../di/Providers.dart';
import '../../custom_components/UserItem.dart';
import '../../themes/AppColors.dart';

class Dashboard extends ConsumerStatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  ConsumerState<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends ConsumerState<Dashboard> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(dashboardViewModelProvider.notifier).fetchUsers(page: 1, perPage: 10);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
        // Memuat halaman berikutnya jika memungkinkan
        final viewModel = ref.read(dashboardViewModelProvider.notifier);
        if (!viewModel.isLoadingMore && viewModel.canLoadMore()) {
          viewModel.fetchUsers(
            page: viewModel.currentPage + 1,
            perPage: 10,
            append: true,
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final dashboardState = ref.watch(dashboardViewModelProvider);
    final Logger log = Logger();

    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: Stack(
        children: [
          dashboardState.when(
            data: (CollectionUserResponse response) {
              return ListView.builder(
                controller: _scrollController,
                itemCount: response.data.length + 1, // Tambahkan 1 untuk indikator loading
                itemBuilder: (context, index) {
                  if (index == response.data.length) {
                    return ref.read(dashboardViewModelProvider.notifier).isLoadingMore
                        ? const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                        : const SizedBox.shrink();
                  }

                  final user = response.data[index];
                  return UserItem(
                    avatarUrl: user.avatar ?? '',
                    name: '${user.firstName ?? ''} ${user.lastName ?? ''}',
                    email: user.email ?? '',
                    isLast: index == response.data.length - 1,
                    onClick: () {
                      log.i('Clicked on ${user.firstName}');
                    },
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, stack) => Center(child: Text('Error: $err')),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}