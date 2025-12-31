import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher_platform_interface.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterIntentAppLauncherPlatform
    with MockPlatformInterfaceMixin
    implements FlutterIntentAppLauncherPlatform {
  @override
  Future<String?> getPackageName(String intentUrl) =>
      Future.value('com.example.test');

  @override
  Future<String?> getAppUrl(String intentUrl) =>
      Future.value('testscheme://host');
}

void main() {
  final FlutterIntentAppLauncherPlatform initialPlatform =
      FlutterIntentAppLauncherPlatform.instance;

  test('$MethodChannelFlutterIntentAppLauncher is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelFlutterIntentAppLauncher>());
  });

  test('getPackageName', () async {
    FlutterIntentAppLauncher flutterIntentAppLauncherPlugin =
        FlutterIntentAppLauncher();
    MockFlutterIntentAppLauncherPlatform fakePlatform =
        MockFlutterIntentAppLauncherPlatform();
    FlutterIntentAppLauncherPlatform.instance = fakePlatform;

    expect(await flutterIntentAppLauncherPlugin.getPackageName('intent://test'),
        'com.example.test');
  });

  test('getAppUrl', () async {
    FlutterIntentAppLauncher flutterIntentAppLauncherPlugin =
        FlutterIntentAppLauncher();
    MockFlutterIntentAppLauncherPlatform fakePlatform =
        MockFlutterIntentAppLauncherPlatform();
    FlutterIntentAppLauncherPlatform.instance = fakePlatform;

    expect(await flutterIntentAppLauncherPlugin.getAppUrl('intent://test'),
        'testscheme://host');
  });
}
