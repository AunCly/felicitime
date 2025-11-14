import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/user/data/user_repository.dart';
import 'package:felicitime/features/user/model/user.dart';
import 'package:felicitime/ui/widgets/button.dart';

import 'async_value_widget.dart';

class AppAppBar extends ConsumerWidget implements PreferredSizeWidget {
  const AppAppBar({
    super.key,
    this.previous,
    this.onBackMethod,
    this.height = kToolbarHeight,
  });

  final double height;
  final bool? previous;
  final Function? onBackMethod;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    ref.watch(getMeProvider);
    String location = GoRouterState.of(context).uri.toString();
    AsyncValue<User?> me = ref.watch(getMeStreamProvider);

    return AppBar(
      elevation: 0,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      primary: true,
      shape: Border(
        bottom: BorderSide(
          color: Theme.of(context).colorScheme.shadow,
          width: 2,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 150,
            child: AsyncValueWidget(
              value: me,
              data: (dataValue) => dataValue != null ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Bonjour,', style: Theme.of(context).textTheme.titleMedium),
                  Text(dataValue.pseudo, style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary)),
                ],
              ) : const Text('Bonjour,', style: TextStyle(color: AppTheme.appBlack, fontSize: 20, fontWeight: FontWeight.w600)),
            ),
          ),
          const Spacer(),
          AppButton(
            color: location == '/profile' ? Theme.of(context).colorScheme.secondary : Theme.of(context).colorScheme.primary,
            onPressed: () => context.go('/profile'),
            icon: FontAwesomeIcons.solidSlidersUp
          ),
        ],
      ),
    );
  }
}

