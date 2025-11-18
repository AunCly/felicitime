import 'package:felicitime/features/capsules/data/capsule_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:felicitime/config/theme.dart';
import 'package:felicitime/features/settings/data/settings_repository.dart';
import 'package:felicitime/routing/router.dart';

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {

  @override
  Widget build(BuildContext context) {

    ref.watch(capsuleRepositoryProvider);
    AsyncValue theme = ref.watch(watchThemeProvider);
    final GoRouter router = ref.watch(routerProvider);

    return MaterialApp.router(
        debugShowCheckedModeBanner: true,
        routerConfig: router,
        title: 'Félicitime',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: switch(theme){
          AsyncData(:final value) => value == 'dark' ? ThemeMode.dark : ThemeMode.light,
          _ => ThemeMode.light,
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('fr'),
        ],
        builder: (context, child) {
          FlutterNativeSplash.remove();
          return child!;
        }
    );
  }
}