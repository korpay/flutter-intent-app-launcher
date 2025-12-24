import 'flutter_intent_app_launcher_platform_interface.dart';

class FlutterIntentAppLauncher {
  Future<bool> openAndroidApp(String intentUrl) {
    return FlutterIntentAppLauncherPlatform.instance.openAndroidApp(intentUrl);
  }

  Future<String?> extractAndroidPackageName(String intentUrl) {
    return FlutterIntentAppLauncherPlatform.instance
        .extractAndroidPackageName(intentUrl);
  }
}
