Log flutter app errors to a telegram channel.

```dart
 FlutterError.onError = (detail) {
  TelegramCrashLog.logError(
    detail, TELEGRAM_GUZO_ADMIN_BOT_API_KEY, TELEGRAM_CHANNEL_ID,
    info: "Token: ${idToken}\n");

    FirebaseCrashlytics.instance.recordFlutterError(detail);
  };
```