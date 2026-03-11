import 'dart:async';
import 'dart:isolate';

import 'package:n2n/data/repositories/setting_repository.dart';

class BackgrouondMonitor {
  static Future<void> start(SendPort sendPort) async {
    final repository = SettingsRepository();

    Timer.periodic(const Duration(seconds: 30), (timer) async {
      try {
        final settings = await repository.fetchRemoteSettings();

        if (settings.isMaintenance) {
          sendPort.send('maintenance');
        } else if (settings.isUpdateRequired) {
          sendPort.send('update');
        } else if (settings.serverStatus == 'offline') {
          sendPort.send('Server down');
        } else {
          sendPort.send('Normal');
        }
      } catch (e) {
        sendPort.send('error');
      }
    });
  }
}
