import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_intent_app_launcher_platform_interface.dart';

/// An implementation of [FlutterIntentAppLauncherPlatform] that uses method channels.
class MethodChannelFlutterIntentAppLauncher
    extends FlutterIntentAppLauncherPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_intent_app_launcher');

  @override
  Future<String?> getAppUrl(String intentUrl) async {
    return await methodChannel
        .invokeMethod<String>('getAppUrl', {'intentUrl': intentUrl});
  }

  @override
  Future<String?> getPackageName(String intentUrl) async {
    return await methodChannel
        .invokeMethod<String>('getPackageName', {'intentUrl': intentUrl});
  }
}
