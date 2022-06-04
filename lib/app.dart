import 'package:async_value/features/album/presentation/album_page.dart';
import 'package:async_value/features/album/presentation/guard_album_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: GuardAlbumPage(),
    );
  }
}
