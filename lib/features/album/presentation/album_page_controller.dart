import 'package:async_value/features/album/data/album_datasource.dart';
import 'package:async_value/features/album/data/album_repository.dart';
import 'package:async_value/features/album/domain/album.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final albumPageControllerProvider =
    StateNotifierProvider.autoDispose<AlbumPageController, AsyncValue<Album?>>(
        (ref) {
  final albumRepository = ref.watch(albumRepositoryProvider);

  return AlbumPageController(
    repository: albumRepository,
  );
});

class AlbumPageController extends StateNotifier<AsyncValue<Album?>> {
  AlbumPageController({
    required this.repository,
  }) : super(const AsyncValue.data(null));

  final AlbumRepositoryDataSource repository;

  Future<void> fetchAlbum(
      {required String url, required String authorizationHeader}) async {
    /// guardを使わない方法
    // state = const AsyncValue.loading();
    // try {
    //   final data = await repository.fetchAlbum(
    //       url: url, authorizationHeader: authorizationHeader);
    //   state = AsyncValue.data(data);
    // } catch (err, stack) {
    //   state = AsyncValue.error(err, stackTrace: stack);
    // }

    /// guardを使う方法
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await repository.fetchAlbum(
          url: url, authorizationHeader: authorizationHeader);
    });
  }
}
