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
        if (methodCall.method == 'getPackageName') {
          return 'com.test.package';
        } else if (methodCall.method == 'getAppUrl') {
          return 'testscheme://host';
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPackageName', () async {
    expect(await platform.getPackageName('intent://test'), 'com.test.package');
  });

  test('getAppUrl', () async {
    expect(await platform.getAppUrl('intent://test'), 'testscheme://host');
  });
}
