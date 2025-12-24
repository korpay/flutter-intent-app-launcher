import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFlutterIntentAppLauncher platform =
      MethodChannelFlutterIntentAppLauncher();
  const MethodChannel channel = MethodChannel('flutter_intent_app_launcher');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'extractAndroidPackageName') {
          return 'com.test.package';
        } else if (methodCall.method == 'openAndroidApp') {
          return true;
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('extractAndroidPackageName', () async {
    expect(await platform.extractAndroidPackageName('intent://test'),
        'com.test.package');
  });

  test('openAndroidApp', () async {
    expect(await platform.openAndroidApp('intent://test'), true);
  });
}
