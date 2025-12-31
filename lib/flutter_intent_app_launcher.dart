import 'flutter_intent_app_launcher_platform_interface.dart';

class FlutterIntentAppLauncher {
  Future<String?> getAppUrl(String intentUrl) {
    return FlutterIntentAppLauncherPlatform.instance.getAppUrl(intentUrl);
  }

  Future<String?> getPackageName(String intentUrl) {
    return FlutterIntentAppLauncherPlatform.instance.getPackageName(intentUrl);
  }
}
