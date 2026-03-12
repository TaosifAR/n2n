import 'dart:async';

import 'package:n2n/data/model/app_settings_model.dart';

class SettingsRepository {
  Future<AppSettings> fetchRemoteSettings() async {
    await Future.delayed(const Duration(seconds: 2));

    return AppSettings(
      isMaintenance: false,
      latestVersion: '1.0.5',
      isUpdateRequired: true,
      serverStatus: 'online',
    );
  }
}
