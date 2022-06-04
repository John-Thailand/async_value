import 'package:async_value/features/album/domain/album.dart';

abstract class AlbumRepositoryDataSource {
  Future<Album> fetchAlbum(
      {required String url, required String authorizationHeader});
}
