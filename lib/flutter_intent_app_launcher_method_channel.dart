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
  Future<bool> openAndroidApp(String intentUrl) async {
    final result = await methodChannel
        .invokeMethod<bool>('openAndroidApp', {'intentUrl': intentUrl});
    return result ?? false;
  }

  @override
  Future<String?> extractAndroidPackageName(String intentUrl) async {
    final result = await methodChannel.invokeMethod<String>(
        'extractAndroidPackageName', {'intentUrl': intentUrl});
    return result;
  }
}
