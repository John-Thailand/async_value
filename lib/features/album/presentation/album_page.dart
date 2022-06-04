import 'package:async_value/features/album/data/album_repository.dart';
import 'package:async_value/features/album/domain/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Album> album = ref.watch(albumProvider);

    return Scaffold(
      body: album.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) =>
            const Center(child: Text('Oops, something unexpected happened')),
        data: (value) =>
            Center(child: Text('${value.id} ${value.userId} ${value.title}')),
      ),
    );
  }
}
