import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher_platform_interface.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIntentAppLauncherPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIntentAppLauncherPlatform {
  @override
  Future<String?> extractAndroidPackageName(String intentUrl) =>
      Future.value('com.example.test');

  @override
  Future<bool> openAndroidApp(String intentUrl) => Future.value(true);
}

void main() {
  final FlutterIntentAppLauncherPlatform initialPlatform =
      FlutterIntentAppLauncherPlatform.instance;

  test('$MethodChannelFlutterIntentAppLauncher is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelFlutterIntentAppLauncher>());
  });

  test('extractAndroidPackageName', () async {
    FlutterIntentAppLauncher flutterIntentAppLauncherPlugin =
        FlutterIntentAppLauncher();
    MockFlutterIntentAppLauncherPlatform fakePlatform =
        MockFlutterIntentAppLauncherPlatform();
    FlutterIntentAppLauncherPlatform.instance = fakePlatform;

    expect(
        await flutterIntentAppLauncherPlugin
            .extractAndroidPackageName('intent://test'),
        'com.example.test');
  });

  test('openAndroidApp', () async {
    FlutterIntentAppLauncher flutterIntentAppLauncherPlugin =
        FlutterIntentAppLauncher();
    MockFlutterIntentAppLauncherPlatform fakePlatform =
        MockFlutterIntentAppLauncherPlatform();
    FlutterIntentAppLauncherPlatform.instance = fakePlatform;

    expect(await flutterIntentAppLauncherPlugin.openAndroidApp('intent://test'),
        true);
  });
}
