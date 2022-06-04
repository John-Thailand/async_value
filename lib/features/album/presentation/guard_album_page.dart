import 'package:async_value/features/album/domain/album.dart';
import 'package:async_value/features/album/presentation/album_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GuardAlbumPage extends ConsumerStatefulWidget {
  const GuardAlbumPage({Key? key}) : super(key: key);

  @override
  _GuardAlbumPageState createState() => _GuardAlbumPageState();
}

class _GuardAlbumPageState extends ConsumerState<GuardAlbumPage> {
  @override
  Widget build(BuildContext context) {
    /// ref.watch / ref.listenの違い
    /// ref.watchは値の変化に応じてウィジェットやプロバイダーを更新する
    /// ref.listenは任意の関数を呼び出してくれる
    ref.listen<AsyncValue<Album?>>(albumPageControllerProvider, (_, state) {
      if (state is AsyncError) {
        _showErrorDialog(context);
      }
      if (state.value is Album) {
        _showInfoDialog(context);
      }
    });

    /// albumPageControllerProvider プロバイダーを監視する
    /// ref.watch / ref.listenの違い
    /// ref.watchは値の変化に応じてウィジェットやプロバイダーを更新する
    /// ref.listenは任意の関数を呼び出してくれる
    final state = ref.watch(albumPageControllerProvider);

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                /// Albumが取得された場合、Albumの情報を表示する
                Visibility(
                  visible: state.value != null,
                  child: Text(
                      '${state.value?.id} ${state.value?.userId} ${state.value?.title}'),
                ),
                ElevatedButton(
                  onPressed: () async => await _fetchAlbum(),
                  child: const Text("Albumを取得"),
                ),
              ],
            ),
          ),

          /// AsyncValue.loading()の場合、インジケーターを回す
          Visibility(
            visible: state is AsyncLoading,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    );
  }

  Future<void> _showErrorDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('エラー'),
          content: const Text('Albumを取得できませんでした'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInfoDialog(
    BuildContext context,
  ) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: null,
          content: const Text('Albumのデータを取得しました'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(dialogContext),
            ),
          ],
        );
      },
    );
  }

  Future<void> _fetchAlbum() async {
    /// ref.read()はユーザー操作によって呼び出される関数内で使用するのが一般的です。
    /// 例えば、ボタンクリックイベント発生時にカウンターの数字を変更する場合に使用できます。
    /// AlbumPageController クラスの fetchAlbum() メソッドを呼び出す
    /// 重要：buildメソッド内でref.read()を使用しない方が良いらしい
    /// 理由：ref.read()だとstateの更新を検知しないため、それによるバグが発生する可能性がある
    ref.read(albumPageControllerProvider.notifier).fetchAlbum(
          url: 'https://jsonplaceholder.typicode.com/albums/1',
          authorizationHeader: 'Basic your_api_token_here',
        );
  }
}
