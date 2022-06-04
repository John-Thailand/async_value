import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  final AsyncValue<T> value;
  final Widget Function(T) data;

  const AsyncValueWidget({
    Key? key,
    required this.value,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        // APIError error = (e as APIError);
        // String msg = (error.asAsyncValue() as AsyncError).error.toString();

        String msg = e.toString();

        return Center(
          child: Text(msg),
        );
      },
      loading: () => const Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
