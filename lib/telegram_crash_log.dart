library telegram_crash_log;
import 'dart:io' as Io;
import 'package:flutter/foundation.dart';
import 'package:dart_telegram_bot/dart_telegram_bot.dart';
import 'package:dart_telegram_bot/telegram_entities.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

/// A Calculator.
class TelegramCrashLog {
  static logError(FlutterErrorDetails detail, String token, int chatID,{String info = ''}) async {
    try {
      final bot = Bot(token: token);
      final directory = await getApplicationDocumentsDirectory();
      final Io.File file = Io.File('${directory.path}/my_file.txt');
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      String caption = "OS: ${Io.Platform.operatingSystem}\n";
      caption += "Version: ${Io.Platform.operatingSystemVersion}\n";
      caption += "App name: ${packageInfo.appName}\n";
      caption += "Package name:${packageInfo.packageName}\n";
      caption += "Version: ${packageInfo.version}\n";
      caption += "Build Number: ${packageInfo.buildNumber}\n";
      caption += "Build Signature: ${packageInfo.buildSignature}\n";
      caption += info;
      await file.writeAsString(caption + detail.stack.toString());

      String name = '${DateTime.now().toUtc().toString()}.log';

      final response = await bot.sendDocument(ChatID(-1001845381104),
          HttpFile.fromBytes(name, file.readAsBytesSync()),
          caption: '${detail.exceptionAsString()}\n');
      file.delete();
    } catch (e) {
      print(e);
    }
  }
}
