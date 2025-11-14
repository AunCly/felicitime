import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/ui/widgets/error_message.dart';

class AsyncValuesWidget<T> extends StatelessWidget {
  const AsyncValuesWidget({
    super.key,
    required this.values,
    required this.data,
    this.loading,
  });

  final List<AsyncValue<T>> values;
  final Widget Function(List<T>) data;
  final Widget Function()? loading;

  @override
  Widget build(BuildContext context) {
    // Check if any value is loading
    final isLoading = values.any((value) => value.isLoading);
    if (isLoading) {
      return loading != null ? loading!() : const Center(child: CircularProgressIndicator());
    }

    // Check if any value has an error
    final errorValue = values.firstWhere((value) => value.hasError, orElse: () => AsyncValue.data(null as T));
    if (errorValue.hasError) {
      return Center(child: ErrorMessageWidget(errorValue.error.toString()));
    }

    // All values are successfully loaded
    final dataList = values.map((value) => value.value as T).toList();
    return data(dataList);
  }
}
