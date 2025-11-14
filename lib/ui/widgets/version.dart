import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:felicitime/main.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersion extends ConsumerWidget {
  const AppVersion({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final PackageInfo packageInfo = ref.read(packageInfoProvider);
    return Text('v${packageInfo.version}+${packageInfo.buildNumber}', style: Theme.of(context).textTheme.bodyMedium);
  }
}
