import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValueWidget<T> extends StatelessWidget {
  const AsyncValueWidget({
    super.key,
    required this.value,
    required this.data,
    this.loading,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final Widget Function()? loading;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: data,
      error: (e, st) {
        return const Center(child: Text('Un problème est survenu. Veuillez réessayer plus tard, ou contactez le support a l\'adresse : contact@ludovik.fr.'));
      },
      loading: () {
        if (loading != null) {
          return loading!();
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}