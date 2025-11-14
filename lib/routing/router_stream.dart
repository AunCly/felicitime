import 'dart:async';

import 'package:flutter/foundation.dart';

class GoRouterRefreshStream extends ChangeNotifier {
  late final StreamSubscription _connectivitySubscription;
  late final StreamSubscription _authSubscription;
  late final StreamSubscription _versionSubscription;

  GoRouterRefreshStream(Stream connectivityStream, Stream latestVersionStream, Stream authStream) {
    _connectivitySubscription = connectivityStream.asBroadcastStream().listen((_) => notifyListeners());
    _versionSubscription = latestVersionStream.asBroadcastStream().listen((_) => notifyListeners());
    _authSubscription = authStream.asBroadcastStream().listen((_) => notifyListeners());
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _versionSubscription.cancel();
    _authSubscription.cancel();
    super.dispose();
  }
}
