import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_intent_app_launcher_method_channel.dart';

abstract class FlutterIntentAppLauncherPlatform extends PlatformInterface {
  /// Constructs a FlutterIntentAppLauncherPlatform.
  FlutterIntentAppLauncherPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterIntentAppLauncherPlatform _instance =
      MethodChannelFlutterIntentAppLauncher();

  /// The default instance of [FlutterIntentAppLauncherPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterIntentAppLauncher].
  static FlutterIntentAppLauncherPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterIntentAppLauncherPlatform] when
  /// they register themselves.
  static set instance(FlutterIntentAppLauncherPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getAppUrl(String intentUrl) {
    throw UnimplementedError('getAppUrl() has not been implemented.');
  }

  Future<String?> getPackageName(String intentUrl) {
    throw UnimplementedError('getPackageName() has not been implemented.');
  }
}
