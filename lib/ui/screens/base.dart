import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:felicitime/ui/widgets/appbar.dart';
import 'package:felicitime/ui/widgets/async_value_widget.dart';
import 'package:felicitime/ui/widgets/bottom_bar.dart';

class BaseScreen extends ConsumerStatefulWidget {
  const BaseScreen({
    super.key,
    required this.screen,
    this.topBar = true,
    this.bottomBar = true,
  });

  final Widget screen;
  final bool topBar;
  final bool bottomBar;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BaseScreenState();
}

class _BaseScreenState extends ConsumerState<BaseScreen> {

  @override
  Widget build(BuildContext context) {

    AsyncValue me = ref.watch(getMeStreamProvider);

    return Scaffold(
      body: SafeArea(child: _EagerAuthInitialization(child: widget.screen)),
    );
  }
}

class _EagerAuthInitialization extends ConsumerWidget {
  const _EagerAuthInitialization({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(userRepositoryProvider);
    ref.watch(getMeStreamProvider);

    return child;
  }
}