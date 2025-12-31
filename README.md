# flutter-intent-app-launcher

Android intent주소 파싱 유틸리티

## Installation

pubspec.yaml

```yaml
dependencies:
  flutter:
    sdk: flutter
    
  flutter_intent_app_launcher:
    git:
      url: https://github.com/korpay/flutter-intent-app-launcher.git
```

```sh
flutter pub get
```

## Usage


```dart
import 'package:flutter_intent_app_launcher/flutter_intent_app_launcher.dart';

// ...

final launcher = FlutterIntentAppLauncher();

launcher.getAppUrl(intentUrl).then((url) {
  print('App Scheme URL: $url');
});

launcher.getPackageName(intentUrl).then((packageName) {
  print('Extracted package name: $packageName');
});
```


## License

MIT
