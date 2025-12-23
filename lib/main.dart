import 'package:felicitime/services/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:felicitime/app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final packageInfoProvider = Provider<PackageInfo>((ref) {
  throw UnimplementedError();
});

Future<void> main() async {

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // 1. Initialiser le service
  final notificationService = NotificationService();
  await notificationService.init();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Intl.defaultLocale = "fr_FR";
  await dotenv.load(fileName: ".env");

  final sharedPreferences = await SharedPreferences.getInstance();
  final packageInfo = await PackageInfo.fromPlatform();

  await GoogleFonts.pendingFonts([
    GoogleFonts.solway(),
    GoogleFonts.raleway(),
  ]);

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(sharedPreferences),
          packageInfoProvider.overrideWithValue(packageInfo),
        ],
        child : const MyApp(),
      )
  );
}
