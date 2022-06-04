import 'package:async_value/components/async_value_widget.dart';
import 'package:async_value/features/album/data/album_repository.dart';
import 'package:async_value/features/album/domain/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AlbumPage extends ConsumerWidget {
  const AlbumPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Album> albumValue = ref.watch(albumProvider);

    // 基本的なAsyncValueの使い方
    // return Scaffold(
    //   body: albumValue.when(
    //     loading: () => const Center(child: CircularProgressIndicator()),
    //     error: (error, stack) =>
    //         const Center(child: Text('Oops, something unexpected happened')),
    //     data: (value) =>
    //         Center(child: Text('${value.id} ${value.userId} ${value.title}')),
    //   ),
    // );

    // Widgetに切り出した場合の使い方
    return Scaffold(
      body: AsyncValueWidget<Album>(
        value: albumValue,
        data: (album) =>
            Center(child: Text('${album.id} ${album.userId} ${album.title}')),
      ),
    );
  }
}
