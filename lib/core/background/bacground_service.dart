import 'dart:async';
import 'dart:isolate';
import 'package:n2n/data/repositories/setting_repository.dart';

class BackgrouondMonitor {
  static Future<void> start(SendPort sendPort) async {
    final repository = SettingsRepository();

    // Perform an immediate check without waiting for the first 30-second interval
    await _checkStatus(repository, sendPort);

    Timer.periodic(const Duration(seconds: 30), (timer) async {
      await _checkStatus(repository, sendPort);
    });
  }

  // Helper function to avoid code duplication
  static Future<void> _checkStatus(
    SettingsRepository repo,
    SendPort port,
  ) async {
    try {
      final settings = await repo.fetchRemoteSettings();

      if (settings.isMaintenance) {
        port.send('maintenance');
      } else if (settings.isUpdateRequired) {
        port.send('update');
      } else if (settings.serverStatus == 'offline') {
        port.send('server_down'); // Send in lowercase to match BLoC logic
      } else {
        port.send('normal');
      }
    } catch (e) {
      port.send('error');
    }
  }
}
