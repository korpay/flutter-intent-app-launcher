import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _urlController = TextEditingController(
      text:
          'intent://kakaopay/pg?url=https://...#Intent;scheme=kakaotalk;package=com.kakao.talk;end');

  String _resultMessage = '결과가 여기에 표시됩니다.';
  final _plugin = FlutterIntentAppLauncher();

  Future<void> _testExtractPackage() async {
    String result;
    try {
      final packageName =
          await _plugin.extractAndroidPackageName(_urlController.text);
      result = '추출된 패키지명: $packageName';
    } on PlatformException catch (e) {
      result = '에러 발생: ${e.message}';
    }

    setState(() {
      _resultMessage = result;
    });
  }

  Future<void> _testOpenApp() async {
    String result;
    try {
      final isOpened = await _plugin.openAndroidApp(_urlController.text);
      result = isOpened ? '앱 실행 성공!' : '앱 실행 실패 (설치 안 됨)';
    } on PlatformException catch (e) {
      result = '에러 발생: ${e.message}';
    }

    setState(() {
      _resultMessage = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Intent Launcher Test'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Intent URL 입력',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _testExtractPackage,
                    child: const Text('패키지명 추출'),
                  ),
                  ElevatedButton(
                    onPressed: _testOpenApp,
                    child: const Text('앱 실행하기'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                _resultMessage,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
