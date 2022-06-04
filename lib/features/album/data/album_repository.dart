import 'dart:convert';

import 'package:async_value/features/album/data/album_datasource.dart';
import 'package:async_value/features/album/domain/album.dart';
import 'package:async_value/utils/service/http/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final albumRepositoryProvider =
    Provider<AlbumRepository>((ref) => AlbumRepository());

final albumProvider = FutureProvider<Album>(
  (ref) async {
    final albumRepository = ref.watch(albumRepositoryProvider);
    return await albumRepository.fetchAlbum(
        url: 'https://jsonplaceholder.typicode.com/albums/1',
        authorizationHeader: 'Basic your_api_token_here');
  },
);

class AlbumRepository implements AlbumRepositoryDataSource {
  final httpClient = HTTPService.instance;

  @override
  Future<Album> fetchAlbum(
      {required String url, required String authorizationHeader}) async {
    final response = await httpClient.get(
      url: 'https://jsonplaceholder.typicode.com/albums/1',
      authorizationHeader: 'Basic your_api_token_here',
    );

    return Album.fromJson(jsonDecode(response!.body));
  }
}
